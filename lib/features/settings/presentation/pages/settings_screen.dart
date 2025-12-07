import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fintech/core/utils/image_manager.dart';
import 'package:fintech/core/theme/theme_cubit.dart';
import 'package:fintech/core/routes/app_routes.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import 'package:fintech/features/settings/presentation/widgets/profile_section.dart';
import 'package:fintech/features/settings/presentation/widgets/settings_section_header.dart';
import 'package:fintech/features/settings/presentation/widgets/settings_item.dart';
import 'package:fintech/features/settings/presentation/widgets/dark_mode_toggle.dart';

/// Settings screen with profile, general settings, and preferences
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  /// Handle logout - sign out from Firebase and navigate to login
  Future<void> _handleLogout(BuildContext context) async {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              try {
                // Sign out from Firebase
                await FirebaseAuth.instance.signOut();

                // Navigate to login screen and clear navigation stack
                if (context.mounted) {
                  NavigationService.navigateToAndReplace(context, AppRoutes.login);
                }
              } catch (e) {
                // Handle logout error
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logout failed: $e')),
                  );
                }
              }
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _handleLogout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ProfileSection(
                  name: 'Abdelrahman Mohamed',
                  imagePath: ImageManager.profilePlaceholder,
                ),
              ),
              SizedBox(height: 32.h),
              const SettingsSectionHeader(title: 'General'),
              SettingsItem(
                icon: Icons.person,
                title: 'My Account',
                onTap: () {},
              ),
              SettingsItem(
                icon: Icons.account_balance_wallet,
                title: 'Billing/Payment',
                onTap: () {},
              ),
              SettingsItem(
                icon: Icons.help_outline,
                title: 'FAQ & Support',
                onTap: () {},
                showBorder: false,
              ),
              SizedBox(height: 32.h),
              const SettingsSectionHeader(title: 'Settings'),
              SettingsItem(
                icon: Icons.language,
                title: 'Language',
                onTap: () {},
              ),
              BlocBuilder<ThemeCubit, bool>(
                builder: (context, isDarkMode) {
                  return DarkModeToggle(
                    isDarkMode: isDarkMode,
                    onChanged: (value) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
