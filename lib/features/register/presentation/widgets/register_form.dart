import '../../../../core/utils/app_regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app/widgets/app_text_field.dart';

import '../../../../core/navigation/navigation_service.dart';
import '../../../../core/routing/app_routes.dart';
import '../../logic/register_cubit.dart';

/// RegisterForm - Stateful signup form widget with 6 input fields
///
/// Manages multi-field registration form with:
/// - First Name and Last Name input fields
/// - Email and Password fields with visibility toggle
/// - Confirm Password field for validation
/// - Phone number field
/// - All fields use shared AppTextField for consistency
/// - Form state lifecycle (controllers, cleanup)
class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          AppTextField(
            hintText: 'First Name',
            controller: cubit.firstNameController,
            prefixIcon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your first name';
              }
              if (value.length < 3) {
                return 'First name must be at least 3 characters long';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          AppTextField(
            hintText: 'Last Name',
            controller: cubit.lastNameController,
            prefixIcon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your last name';
              }
              if (value.length < 3) {
                return 'Last name must be at least 3 characters long';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          AppTextField(
            hintText: 'Email-ID',
            controller: cubit.emailController,
            prefixIcon: Icons.mail_outline,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email';
              }

              if (!AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email';
              }

              return null;
            },
          ),
          SizedBox(height: 16.h),
          AppTextField(
            hintText: 'Password',
            controller: cubit.passwordController,
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your password';
              }
              if (!AppRegex.isPasswordValid(value)) {
                return 'Please enter a valid password';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          AppTextField(
            hintText: 'Confirm Password',
            controller: cubit.confirmPasswordController,
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please confirm your password';
              }
              if (value != cubit.passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          AppTextField(
            hintText: 'xxx xxx xxxx',
            controller: cubit.phoneController,
            prefixIcon: Icons.phone_outlined,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your phone number';
              }
              if (!AppRegex.isPhoneNumberValid(value)) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),
          SizedBox(height: 24.h),
          _buildRegisterButton(),
          SizedBox(height: 16.h),
          _buildLoginRow(),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Builder(
      builder: (context) => SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: () => _validateThenDoRegister(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
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
      ),
    );
  }

  Widget _buildLoginRow() {
    return Builder(
      builder: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account? ',
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          GestureDetector(
            onTap: () => _navigateToLogin(context),
            child: Text(
              'login',
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _validateThenDoRegister(BuildContext context) {
    if (context.read<RegisterCubit>().formKey.currentState!.validate()) {
      context.read<RegisterCubit>().createUser();
    }
  }

  void _navigateToLogin(BuildContext context) =>
      NavigationService.navigateToAndRemoveUntil(context, AppRoutes.login);
}
