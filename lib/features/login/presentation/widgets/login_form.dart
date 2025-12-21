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
  final Function(String email, String password) onLoginPressed;
  final VoidCallback onForgotPasswordPressed;

  const LoginForm({super.key, required this.onLoginPressed, required this.onForgotPasswordPressed});

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

  /// Get current email from form
  String get currentEmail => _emailController.text;

  /// Get current password from form
  String get currentPassword => _passwordController.text;

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

  /// Builds row with Remember Me checkbox and Forgot Password link
  Widget _buildRememberForgotRow() {
    return Builder(
      builder: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 24.w,
                height: 24.w,
                child: Checkbox(
                  value: _rememberMe,
                  onChanged: (value) => setState(() => _rememberMe = value ?? false),
                  activeColor: Theme.of(context).colorScheme.secondary,
                  side: BorderSide(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF3E3E3E)
                        : const Color(0xFF9CA3AF),
                    width: 1.5,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'Remember me',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: widget.onForgotPasswordPressed,
            child: Text(
              'Forget Password?',
              style: TextStyle(
                fontSize: 13.sp,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds primary Login button with full width and dark navy styling
  Widget _buildLoginButton() {
    return Builder(
      builder: (context) => SizedBox(
        width: double.infinity,
        height: 52.h,
        child: ElevatedButton(
          onPressed: () => widget.onLoginPressed(_emailController.text, _passwordController.text),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
            elevation: 0,
          ),
          child: Text(
            'Login',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
