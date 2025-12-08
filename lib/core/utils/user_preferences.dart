import 'package:fintech/core/service/shared_pref/pref_keys.dart';
import 'package:fintech/core/service/shared_pref/shared_pref.dart';

class UserPreferences {
  /// Initialize SharedPreferences (must be called before any other methods)
  static Future<void> init() async {
    await SharedPref.init();
    // ignore: avoid_print
    print('[UserPreferences] SharedPreferences initialized');
  }

  static Future<void> saveUserUid(String uid) async {
    await SharedPref.setValue(PrefKeys.uid, uid);
    // ignore: avoid_print
    print('[UserPreferences] Saved UID: $uid');
  }

  static Future<bool> checkIfLoggedInUser() async {
    final uid = SharedPref.getValue(PrefKeys.uid);
    final isLoggedIn = uid != null;
    // ignore: avoid_print
    print('[UserPreferences] checkIfLoggedInUser - UID value: $uid, isLoggedIn: $isLoggedIn');
    return isLoggedIn;
  }
}
