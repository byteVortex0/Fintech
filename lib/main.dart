import 'package:fintech/core/extensions/string_extension.dart';
import 'package:fintech/core/service/shared_pref/pref_keys.dart';
import 'package:fintech/core/service/shared_pref/shared_pref.dart';
import 'package:fintech/core/utils/constants.dart';
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
  await checkIfLoggedInUser();

  runApp(const FinTechApp());
}

checkIfLoggedInUser() async {
  String? userUId = await SharedPref.getValue(
    PrefKeys.uid,
  );
  if (!userUId.isNullOrEmpty()) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}
