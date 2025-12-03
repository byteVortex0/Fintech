import 'package:fintech/core/service/shared_pref/pref_keys.dart';
import 'package:fintech/core/service/shared_pref/shared_pref.dart';

class UserPreferences {
  static Future<void> saveUserUid(String uid) async {
    await SharedPref.setValue(PrefKeys.uid, uid);
  }

  static Future<bool> checkIfLoggedInUser() async {
    return await SharedPref.getValue(PrefKeys.uid) != null;
  }
}
