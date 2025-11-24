import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/shared/widgets/app_text_field.dart';

class RegisterForm extends StatefulWidget {
  final Function() onRegisterPressed;
  final Function() onLoginPressed;

  const RegisterForm({
    super.key,
    required this.onRegisterPressed,
    required this.onLoginPressed,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          hintText: 'First Name',
          controller: _firstNameController,
          prefixIcon: Icons.person_outline,
        ),
        SizedBox(height: 16.h),
        AppTextField(
          hintText: 'Last Name',
          controller: _lastNameController,
          prefixIcon: Icons.person_outline,
        ),
        SizedBox(height: 16.h),
        AppTextField(
          hintText: 'Email-ID',
          controller: _emailController,
          prefixIcon: Icons.mail_outline,
        ),
        SizedBox(height: 16.h),
        AppTextField(
          hintText: 'Password',
          controller: _passwordController,
          prefixIcon: Icons.lock_outline,
          obscureText: true,
        ),
        SizedBox(height: 16.h),
        AppTextField(
          hintText: 'Confirm Password',
          controller: _confirmPasswordController,
          prefixIcon: Icons.lock_outline,
          obscureText: true,
        ),
        SizedBox(height: 16.h),
        AppTextField(
          hintText: 'xxx xxx xxxx',
          controller: _phoneController,
          prefixIcon: Icons.phone_outlined,
        ),
        SizedBox(height: 24.h),
        _buildRegisterButton(),
        SizedBox(height: 16.h),
        _buildLoginRow(),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: widget.onRegisterPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A2B4A),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.r),
          ),
        ),
        child: Text(
          'Register',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(fontSize: 14.sp, color: const Color(0xFF6B7280)),
        ),
        GestureDetector(
          onTap: widget.onLoginPressed,
          child: Text(
            'login',
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF1A5FFF),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
