import Flutter
import UIKit

final class ForwardingSecureTextField: UITextField {
    weak var forwardedView: UIView?

    override var canBecomeFirstResponder: Bool { false }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let forwardedView = forwardedView else { return nil }
        let converted = forwardedView.convert(point, from: self)
        return forwardedView.hitTest(converted, with: event)
    }
}

@main
@objc class AppDelegate: FlutterAppDelegate {

    private var blurView: UIVisualEffectView?
    private var channel: FlutterMethodChannel?

    // ✅ Secure screen state
    private var secureField: ForwardingSecureTextField?
    private weak var originalFlutterSuperview: UIView?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        GeneratedPluginRegistrant.register(with: self)

        guard let controller = window?.rootViewController as? FlutterViewController else {
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        }

        channel = FlutterMethodChannel(
            name: "security_channel",
            binaryMessenger: controller.binaryMessenger
        )

        channel?.setMethodCallHandler { [weak self] call, result in
            switch call.method {
            case "enableSecureScreen":
                self?.enableSecureScreenStrong()
                result(true)
            case "disableSecureScreen":
                self?.disableSecureScreen()
                result(true)
            default:
                result(FlutterMethodNotImplemented)
            }
        }

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onScreenshot),
            name: UIApplication.userDidTakeScreenshotNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onCapturedChanged),
            name: UIScreen.capturedDidChangeNotification,
            object: nil
        )

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.onCapturedChanged()
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // MARK: - App Lifecycle

    override func applicationWillResignActive(_ application: UIApplication) {
        showBlurCover()
        channel?.invokeMethod("onAppWillResignActive", arguments: nil)
        channel?.invokeMethod("appWillResignActive", arguments: nil)
    }

    override func applicationDidBecomeActive(_ application: UIApplication) {
        hideBlurCover()
        channel?.invokeMethod("onAppDidBecomeActive", arguments: nil)
        channel?.invokeMethod("appDidBecomeActive", arguments: nil)
        onCapturedChanged()
    }

    // MARK: - Blur cover (app switcher)

    private func showBlurCover() {
        guard blurView == nil, let window = window else { return }
        let blur = UIBlurEffect(style: .systemMaterial)
        let view = UIVisualEffectView(effect: blur)
        view.frame = window.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        window.addSubview(view)
        blurView = view
    }

    private func hideBlurCover() {
        blurView?.removeFromSuperview()
        blurView = nil
    }

    // MARK: - Screenshot (UI only notification)

    @objc private func onScreenshot() {
        // Can't change what's saved in Photos when secure screen is enabled.
        print("[AppDelegate] 📸 onScreenshot() called - screenshot already captured by iOS")
        print("[AppDelegate] ℹ️ Note: iOS captures screenshot at OS level BEFORE we get notified")
        print("[AppDelegate] ℹ️ Current secure field state: \(secureField != nil ? "ACTIVE" : "INACTIVE")")
        channel?.invokeMethod("onScreenshot", arguments: nil)
        channel?.invokeMethod("screenshot", arguments: nil)
    }

    // MARK: - Screen Recording

    @objc private func onCapturedChanged() {
        let isCaptured = UIScreen.main.isCaptured
        let payload: [String: Any] = ["isCaptured": isCaptured]
        channel?.invokeMethod("onCapturedChanged", arguments: payload)
        channel?.invokeMethod("captureChanged", arguments: payload)
    }

    // MARK: - Secure Screen (deep secure layer)

    private func deepestLayer(from layer: CALayer) -> CALayer {
        var current = layer
        while let last = current.sublayers?.last {
            current = last
        }
        return current
    }

    private func enableSecureScreenStrong() {
        guard secureField == nil,
            let window = window,
            let controller = window.rootViewController as? FlutterViewController
        else {
            print("[AppDelegate] ⚠️ enableSecureScreenStrong() SKIPPED - secureField already exists or window/controller nil")
            return
        }

        print("[AppDelegate] 🔒 enableSecureScreenStrong() called - activating iOS secure layer")

        let flutterView = controller.view!

        let field = ForwardingSecureTextField(frame: window.bounds)
        field.isSecureTextEntry = true
        field.backgroundColor = .clear
        field.text = " "
        field.textColor = .clear
        field.tintColor = .clear
        field.isEnabled = false
        field.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        window.addSubview(field)
        window.bringSubviewToFront(field)

        originalFlutterSuperview = flutterView.superview
        flutterView.removeFromSuperview()

        flutterView.frame = field.bounds
        flutterView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        field.addSubview(flutterView)
        field.forwardedView = flutterView

        flutterView.layer.removeFromSuperlayer()
        let target = deepestLayer(from: field.layer)
        target.addSublayer(flutterView.layer)
        flutterView.layer.frame = target.bounds

        secureField = field
        print("[AppDelegate] ✅ Secure screen ENABLED - ForwardingSecureTextField activated")
    }

    private func disableSecureScreen() {
        guard let window = window,
            let controller = window.rootViewController as? FlutterViewController
        else {
            print("[AppDelegate] ⚠️ disableSecureScreen() SKIPPED - window or controller nil")
            return
        }

        print("[AppDelegate] 🔓 disableSecureScreen() called - removing iOS secure layer")

        let flutterView = controller.view!
        flutterView.layer.removeFromSuperlayer()
        flutterView.removeFromSuperview()

        if let originalSuperview = originalFlutterSuperview {
            originalSuperview.addSubview(flutterView)
        } else {
            window.insertSubview(flutterView, at: 0)
        }

        flutterView.frame = window.bounds
        flutterView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        secureField?.removeFromSuperview()
        secureField = nil
        originalFlutterSuperview = nil

        print("[AppDelegate] ✅ Secure screen DISABLED - Flutter view restored")
    }
}
