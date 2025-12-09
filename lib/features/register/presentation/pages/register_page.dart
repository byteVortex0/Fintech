import '../../../login/presentation/widgets/curved_background.dart';
import '../widgets/register_bloc_listener.dart';
import '../widgets/register_form.dart';
import '../widgets/register_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          const CurvedBackground(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    const RegisterHeader(),
                    SizedBox(height: 32.h),
                    RegisterForm(),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
          const RegisterBlocListener(),
        ],
      ),
    );
  }
}
