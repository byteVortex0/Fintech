import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    NotificationCenter.default.addObserver(self,
          selector: #selector(protectData),
          name: UIApplication.userDidTakeScreenshotNotification,
          object: nil)

      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    @objc func protectData() {
        if let window = UIApplication.shared.windows.first {
            let view = UIView(frame: window.bounds)
            view.backgroundColor = UIColor.black
            view.tag = 99999
            window.addSubview(view)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                window.viewWithTag(99999)?.removeFromSuperview()
            }
        }
  }
}
