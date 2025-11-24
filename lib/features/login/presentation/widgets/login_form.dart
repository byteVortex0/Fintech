import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_input_field.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onForgotPasswordPressed;

  const LoginForm({
    super.key,
    required this.onLoginPressed,
    required this.onForgotPasswordPressed,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoginInputField(
          hintText: 'E-mail ID',
          controller: _emailController,
          prefixIcon: Icons.mail_outline,
        ),
        SizedBox(height: 16.h),
        LoginInputField(
          hintText: 'Password',
          controller: _passwordController,
          obscureText: true,
          prefixIcon: Icons.lock_outline,
        ),
        SizedBox(height: 12.h),
        _buildRememberForgotRow(),
        SizedBox(height: 20.h),
        _buildLoginButton(),
      ],
    );
  }

  Widget _buildRememberForgotRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 24.w,
              height: 24.w,
              child: Checkbox(
                value: _rememberMe,
                onChanged: (value) =>
                    setState(() => _rememberMe = value ?? false),
                activeColor: const Color(0xFF1A2B4A),
                side: BorderSide(color: const Color(0xFF9CA3AF), width: 1.5),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              'Remember me',
              style: TextStyle(fontSize: 13.sp, color: const Color(0xFF374151)),
            ),
          ],
        ),
        GestureDetector(
          onTap: widget.onForgotPasswordPressed,
          child: Text(
            'Forget Password?',
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF1A5FFF),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: widget.onLoginPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A2B4A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          elevation: 0,
        ),
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
