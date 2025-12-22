import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'core/app/bloc_observer.dart';
import 'core/app/env_variables.dart';
import 'core/utils/constants.dart';
import 'core/utils/user_preferences.dart';
import 'fintech_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  try {
    await EnvVariables.instance.init();
  } catch (e) {
    print('Warning: .env file not found, using fallback API key');
  }

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Stripe.publishableKey = EnvVariables.instance.publishableKey;
  Stripe.instance.applySettings();

  // Initialize SharedPreferences before checking login state
  await UserPreferences.init();

  setupInjection();

  isLoggedInUser = await UserPreferences.checkIfLoggedInUser();
  print('[main_dev] isLoggedInUser: $isLoggedInUser');

  Bloc.observer = AppBlocObserver();

  runApp(const FinTechApp());
}
