import 'package:fintech/core/utils/app_regex.dart';
import 'package:fintech/features/register/logic/register_cubit.dart';
import 'package:fintech/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = context.read<RegisterCubit>().passwordController;
    setupPasswordControllerListener();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      setState(() {
        hasLowercase = AppRegex.hasLowerCase(passwordController.text);
        hasUppercase = AppRegex.hasUpperCase(passwordController.text);
        hasSpecialCharacters = AppRegex.hasSpecialCharacter(
          passwordController.text,
        );
        hasNumber = AppRegex.hasNumber(passwordController.text);
        hasMinLength = AppRegex.hasMinLength(passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<RegisterCubit>().formKey,
      child: Column(
        children: [
          AppTextField(
            hintText: 'First Name',
            prefixIcon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid name';
              }
              return null;
            },
            keyboardType: TextInputType.name,
            controller: context.read<RegisterCubit>().firstNameController,
          ),
          SizedBox(height: 16.h),
          AppTextField(
            hintText: 'Last Name',
            prefixIcon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid name';
              }
              return null;
            },
            keyboardType: TextInputType.name,
            controller: context.read<RegisterCubit>().lastNameController,
          ),
          SizedBox(height: 16.h),
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
            controller: context.read<RegisterCubit>().emailController,
          ),
          SizedBox(height: 16.h),
          AppTextField(
            controller: context.read<RegisterCubit>().passwordController,
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
          SizedBox(height: 16.h),
          AppTextField(
            controller: context.read<RegisterCubit>().confirmPasswordController,
            hintText: 'Confirm Password',
            keyboardType: TextInputType.visiblePassword,
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              } else if (value != passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          AppTextField(
            hintText: 'xxx xxx xxxx',
            keyboardType: TextInputType.phone,
            prefixIcon: Icons.phone_outlined,
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isPhoneNumberValid(value)) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
            controller: context.read<RegisterCubit>().phoneController,
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
          onPressed: widget.onRegisterPressed,
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
            onTap: widget.onLoginPressed,
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
}
