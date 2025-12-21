import 'core/app/bloc_observer.dart';
import 'core/utils/constants.dart';
import 'core/utils/user_preferences.dart';
import 'fintech_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/injection.dart';
import 'firebase_options.dart';

/// Production flavour entry point
/// Runs the app in release mode with minimal logging
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  // Load environment variables from .env file
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    // .env file not found - will use fallback values from ApiConfig
    // ignore: avoid_print
    print('Warning: .env file not found, using fallback API key');
  }

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize SharedPreferences before checking login state
  await UserPreferences.init();

  setupInjection();

  isLoggedInUser = await UserPreferences.checkIfLoggedInUser();

  Bloc.observer = AppBlocObserver();

  runApp(const FinTechApp());
}
