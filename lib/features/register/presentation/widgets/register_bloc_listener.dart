import '../../../../core/navigation/navigation_service.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/color_manager.dart';
import '../../logic/register_cubit.dart';
import '../../logic/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterBlocListener extends StatelessWidget {
  const RegisterBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: LightColorManager.screenBackground,
                ),
              ),
            );
          },
          success: (data) {
            NavigationService.goBack(context);
            showSuccessDialog(context);
          },
          error: (error) {
            setupErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Register Successful'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Congratulations, you have signed up successfully!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                disabledForegroundColor: Colors.grey.withValues(alpha: 0.38),
              ),
              onPressed: () {
                NavigationService.navigateToAndRemoveUntil(
                  context,
                  AppRoutes.setFingerprint,
                );
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }

  void setupErrorState(BuildContext context, String error) {
    NavigationService.goBack(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.error, color: Colors.red, size: 32),
        content: Text(
          error,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              NavigationService.goBack(context);
            },
            child: Text(
              'Got it',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
