import 'package:fintech/fintech_app.dart';
import 'package:flutter/material.dart';

import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupInjection();

  runApp(const FinTechApp());
}
