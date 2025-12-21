import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class SecurityGate extends StatefulWidget {
  final Widget child;
  const SecurityGate({super.key, required this.child});

  @override
  State<SecurityGate> createState() => _SecurityGateState();
}

class _SecurityGateState extends State<SecurityGate> with WidgetsBindingObserver {
  static const MethodChannel _channel = MethodChannel('security_channel');
  final LocalAuthentication _auth = LocalAuthentication();

  bool _locked = false;
  bool _shouldAuthOnResume = false;
  bool _isAuthenticating = false;
  bool _isCaptured = false;
  bool _isScreenshotDetected = false;

  DateTime? _lastScreenshotAt;
  DateTime? _lastScreenshotEventAt;
  final Duration _screenshotDebounce = const Duration(milliseconds: 400);
  final Duration _ignoreLifecycleAfterScreenshot = const Duration(seconds: 1);

  // ✅ Ignore lifecycle noise during app boot/login
  final DateTime _bootAt = DateTime.now();
  final Duration _bootIgnoreWindow = const Duration(seconds: 4);

  // ✅ KEY FIX: suppress lifecycle noise caused by FaceID prompt itself
  bool _suppressLifecycleFromAuthPrompt = false;
  DateTime? _authPromptStartedAt;
  final Duration _authPromptWindow = const Duration(seconds: 2);

  bool _recentScreenshot() {
    final t = _lastScreenshotAt;
    if (t == null) return false;
    return DateTime.now().difference(t) < _ignoreLifecycleAfterScreenshot;
  }

  bool _authPromptLikelyActive() {
    if (!_suppressLifecycleFromAuthPrompt) return false;
    final t = _authPromptStartedAt;
    if (t == null) return true;
    return DateTime.now().difference(t) < _authPromptWindow;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _channel.setMethodCallHandler((call) async {
      debugPrint('[SecurityGate] Received from iOS: ${call.method}');

      switch (call.method) {
        case 'onCapturedChanged':
        case 'captureChanged':
          final args = (call.arguments as Map?) ?? {};
          final captured = args['isCaptured'] == true;

          if (!mounted) return;

          final wasCaptured = _isCaptured;

          setState(() {
            _isCaptured = captured;

            if (captured) {
              // ✅ recording/mirroring ON: lock always, no auth
              _locked = true;
              _shouldAuthOnResume = false;
            } else {
              // ✅ IMPORTANT:
              // Do NOT arm auth every time iOS sends captureChanged(false).
              // Only arm if we were previously captured and now stopped.
              if (wasCaptured == true) {
                _locked = true;
                _shouldAuthOnResume = true;
              }
              // else: do nothing (avoid FaceID loop)
            }
          });
          return;

        case 'onScreenshot':
        case 'screenshot':
          debugPrint('[SecurityGate] 🎬 SCREENSHOT EVENT DETECTED from iOS');
          final now = DateTime.now();
          if (_lastScreenshotEventAt != null &&
              now.difference(_lastScreenshotEventAt!) < _screenshotDebounce) {
            debugPrint('[SecurityGate] ⏱️ Screenshot debounce active, ignoring...');
            return;
          }
          _lastScreenshotEventAt = now;
          _lastScreenshotAt = now;
          debugPrint('[SecurityGate] ✅ Screenshot event accepted - showing friendly message');

          if (!mounted) return;

          setState(() {
            _isScreenshotDetected = true;
            debugPrint('[SecurityGate] 📺 setState called - _isScreenshotDetected is NOW TRUE');
          });

          // Show friendly message for 2 seconds
          Future.delayed(const Duration(milliseconds: 2000), () {
            if (!mounted) return;
            debugPrint('[SecurityGate] ⏰ 2 second delay finished - hiding screenshot message');
            setState(() => _isScreenshotDetected = false);
          });
          return;

        default:
          return;
      }
    });
  }

  void _lockOnly() {
    if (!_locked && mounted) setState(() => _locked = true);
  }

  void _armAuthAndLock() {
    _shouldAuthOnResume = true;
    _lockOnly();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    debugPrint(
      '[SecurityGate] Lifecycle: $state '
      '(locked=$_locked, shouldAuth=$_shouldAuthOnResume, auth=$_isAuthenticating, captured=$_isCaptured)',
    );

    // Recording: keep locked and do nothing
    if (_isCaptured) return;

    // Ignore lifecycle noise right after screenshot
    if (_recentScreenshot()) return;

    // ✅ ignore inactive/paused caused by FaceID prompt itself
    if (_authPromptLikelyActive() &&
        (state == AppLifecycleState.inactive ||
            state == AppLifecycleState.paused ||
            state == AppLifecycleState.hidden)) {
      return;
    }

    // ✅ Ignore lifecycle noise during app boot/login (prevents extra FaceID after login)
    if (DateTime.now().difference(_bootAt) < _bootIgnoreWindow) {
      return;
    }

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden ||
        state == AppLifecycleState.paused) {
      // If auth is in progress, don't re-arm.
      if (_isAuthenticating) return;

      _armAuthAndLock();
      return;
    }

    if (state == AppLifecycleState.resumed) {
      // Once we are back, stop suppressing (auth prompt closed)
      _suppressLifecycleFromAuthPrompt = false;
      _authPromptStartedAt = null;

      if (!_shouldAuthOnResume) return;
      if (_isAuthenticating) return;

      // ✅ Prevent re-entry loop:
      _shouldAuthOnResume = false;
      _lockOnly();

      await _authenticateAndUnlock();
    }
  }

  Future<void> _authenticateAndUnlock() async {
    if (_isAuthenticating) return;
    if (_isCaptured) return;

    _isAuthenticating = true;

    // ✅ FaceID prompt triggers lifecycle changes
    _suppressLifecycleFromAuthPrompt = true;
    _authPromptStartedAt = DateTime.now();

    try {
      final supported = await _auth.isDeviceSupported();
      final canCheck = await _auth.canCheckBiometrics;

      if (!supported || !canCheck) {
        // policy: unlock to avoid dead lock
        if (mounted) setState(() => _locked = false);
        return;
      }

      final ok = await _auth.authenticate(localizedReason: 'Authenticate to continue');

      if (!mounted) return;

      if (_isCaptured) {
        setState(() => _locked = true);
        return;
      }

      setState(() => _locked = ok ? false : true);
    } catch (e) {
      debugPrint('[SecurityGate] Auth exception: $e');
      if (mounted) setState(() => _locked = true);
    } finally {
      _isAuthenticating = false;

      // stop suppress after we settle in resumed
      Future.delayed(const Duration(milliseconds: 150), () {
        _suppressLifecycleFromAuthPrompt = false;
        _authPromptStartedAt = null;
      });
    }
  }

  Widget _lockScreen() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? Colors.black : Colors.white;
    final fg = isDark ? Colors.white : Colors.black;
    final sub = isDark ? Colors.white70 : Colors.black54;

    return Material(
      color: bg,
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shield_outlined, size: 54, color: sub),
                const SizedBox(height: 16),
                Text(
                  _isCaptured ? 'Screen recording detected' : 'App is locked',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: fg),
                ),
                const SizedBox(height: 8),
                Text(
                  _isCaptured
                      ? 'For your privacy, please stop recording to continue.'
                      : 'Authenticate to continue.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: sub, height: 1.3),
                ),
                const SizedBox(height: 22),
                if (!_isCaptured)
                  SizedBox(
                    height: 44,
                    child: ElevatedButton.icon(
                      onPressed: _isAuthenticating ? null : _authenticateAndUnlock,
                      icon: const Icon(Icons.face),
                      label: Text(_isAuthenticating ? 'Authenticating...' : 'Unlock'),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _screenshotWarningScreen() {
    debugPrint(
      '[SecurityGate] 📱 _screenshotWarningScreen() CALLED - building friendly warning UI',
    );
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? Colors.black : Colors.white;
    final fg = isDark ? Colors.white : Colors.black;
    debugPrint('[SecurityGate] 🎨 Theme detected - isDark=$isDark');

    return Material(
      color: bg,
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.screenshot, size: 64, color: Colors.orange),
                const SizedBox(height: 24),
                Text(
                  'Screenshots Blocked',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: fg),
                ),
                const SizedBox(height: 12),
                Text(
                  'This app protects your privacy.\nScreenshots are not allowed.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.white70 : Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
      '[SecurityGate] 🏗️ BUILD CALLED - _isScreenshotDetected=$_isScreenshotDetected, _locked=$_locked',
    );

    if (_isScreenshotDetected) {
      debugPrint('[SecurityGate] 🎨 RENDERING screenshot warning screen (Positioned.fill)');
    }
    if (_locked) {
      debugPrint('[SecurityGate] 🔒 RENDERING lock screen (Positioned.fill)');
    }

    return Stack(
      children: [
        widget.child,

        // Screenshot detected: show full-screen friendly warning
        if (_isScreenshotDetected) Positioned.fill(child: _screenshotWarningScreen()),

        // Lock screen for authentication
        if (_locked) Positioned.fill(child: _lockScreen()),
      ],
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
