import 'package:fintech/core/utils/app_regex.dart';
import 'package:fintech/features/login/logic/login_cubit.dart';
import 'package:fintech/features/register/logic/register_cubit.dart';
import 'package:fintech/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        children: [
          AppTextField(
            hintText: 'Email-ID',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.mail_outline,
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            controller: context.read<LoginCubit>().emailController,
          ),
          SizedBox(height: 16.h),
          AppTextField(
            controller: context.read<LoginCubit>().passwordController,
            hintText: 'Password',
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            prefixIcon: Icons.lock_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
              return null;
            },
          ),
          SizedBox(height: 12.h),

          /// Remember me checkbox and Forgot password link row
          _buildRememberForgotRow(),
          SizedBox(height: 20.h),

          /// Primary action: Login button with dark navy background
          _buildLoginButton(),
        ],
      ),
    );
  }

  /// Builds row with Remember Me checkbox and Forgot Password link
  /// Remember Me: Maintains checkbox state via setState for persistent login feature
  /// Forgot Password: Routes to password recovery flow when tapped
  Widget _buildRememberForgotRow() {
    return Builder(
      builder: (context) => Row(
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

          /// Right side: Forgot password link
          /// Tapping routes to password recovery page via callback
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
  /// Button height 52.h provides comfortable touch target
  /// Rounded corners (30.r radius) match app design system
  /// No elevation for flat, modern appearance
  Widget _buildLoginButton() {
    return Builder(
      builder: (context) => SizedBox(
        width: double.infinity,
        height: 52.h,
        child: ElevatedButton(
          onPressed: widget.onLoginPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
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
      ),
    );
  }
}
