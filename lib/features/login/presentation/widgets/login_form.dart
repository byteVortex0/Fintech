import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_input_field.dart';

/// LoginForm - Stateful email/password input form widget
///
/// Manages credential-based authentication form with:
/// - Email and Password input fields using LoginInputField widget
/// - Remember me checkbox state management
/// - Forgot password navigation callback
/// - Form state lifecycle (controllers, cleanup)
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
  /// Controls email input field text
  /// Must be disposed to prevent memory leaks
  late TextEditingController _emailController;

  /// Controls password input field text
  /// Must be disposed to prevent memory leaks
  late TextEditingController _passwordController;

  /// Tracks "Remember me" checkbox state for persistent login
  bool _rememberMe = false;

  /// Lifecycle initialization
  /// Creates TextEditingController instances for form fields
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  /// Lifecycle cleanup
  /// Disposes TextEditingController instances to prevent memory leaks
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
        /// Email input field with mail icon and standard validation
        LoginInputField(
          hintText: 'E-mail ID',
          controller: _emailController,
          prefixIcon: Icons.mail_outline,
        ),
        SizedBox(height: 16.h),

        /// Password input field with obscure text toggle and lock icon
        LoginInputField(
          hintText: 'Password',
          controller: _passwordController,
          obscureText: true,
          prefixIcon: Icons.lock_outline,
        ),
        SizedBox(height: 12.h),

        /// Remember me checkbox and Forgot password link row
        _buildRememberForgotRow(),
        SizedBox(height: 20.h),

        /// Primary action: Login button with dark navy background
        _buildLoginButton(),
      ],
    );
  }

  /// Builds row with Remember Me checkbox and Forgot Password link
  /// Remember Me: Maintains checkbox state via setState for persistent login feature
  /// Forgot Password: Routes to password recovery flow when tapped
  Widget _buildRememberForgotRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Left side: Remember me checkbox with label
        /// Checkbox state triggers setState to update _rememberMe variable
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

        /// Right side: Forgot password link
        /// Tapping routes to password recovery page via callback
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

  /// Builds primary Login button with full width and dark navy styling
  /// Button height 52.h provides comfortable touch target
  /// Rounded corners (30.r radius) match app design system
  /// No elevation for flat, modern appearance
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
