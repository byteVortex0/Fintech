import 'package:flutter/material.dart';

/// Legacy placeholder - GoRouter's ShellRoute now handles navigation
class MainShellScreen extends StatelessWidget {
  const MainShellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('MainShellScreen - deprecated')));
  }
}
