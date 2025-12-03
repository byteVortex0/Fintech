import 'package:fintech/core/utils/constants.dart';
import 'package:fintech/core/utils/user_preferences.dart';
import 'package:fintech/fintech_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/injection.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupInjection();
  isLoggedInUser = await UserPreferences.checkIfLoggedInUser();

  runApp(const FinTechApp());
}
