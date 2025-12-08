import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintech/core/utils/image_manager.dart';
import 'package:fintech/core/routes/app_routes.dart';
import 'package:fintech/core/theme/theme_cubit.dart';
import 'package:fintech/features/settings/presentation/widgets/profile_section.dart';
import 'package:fintech/features/settings/presentation/widgets/settings_section_header.dart';
import 'package:fintech/features/settings/presentation/widgets/settings_item.dart';
import 'package:fintech/features/settings/presentation/widgets/dark_mode_toggle.dart';
import 'package:fintech/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:fintech/features/settings/presentation/cubit/settings_state.dart';

/// Settings screen with profile, general settings, and preferences
/// Displays user data from Firebase and manages theme/preferences
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch user profile when screen loads
    context.read<SettingsCubit>().fetchUserProfile();
  }

  /// Show logout confirmation dialog
  /// UI layer only handles presentation - logout logic moved to Cubit
  void _showLogoutDialog(BuildContext context) {
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
            onPressed: () {
              Navigator.pop(dialogContext);
              // Trigger logout logic in Cubit
              context.read<SettingsCubit>().logout();
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

  Widget _buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red),
          SizedBox(height: 16.h),
          Text(
            'Error: $message',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.sp),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => context.read<SettingsCubit>().fetchUserProfile(),
            child: const Text('Retry'),
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
            onPressed: () => _showLogoutDialog(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          state.maybeWhen(
            logoutSuccess: () {
              // Navigate to login on successful logout
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.login,
                (route) => false,
              );
            },
            logoutError: (message) {
              // Show error message on logout failure
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Logout failed: $message')),
              );
            },
            orElse: () {},
          );
        },
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return state.maybeWhen(
              initial: () => _buildLoadingState(),
              loading: () => _buildLoadingState(),
              logoutLoading: () => _buildLoadingState(),
              loaded: (userProfile) => RefreshIndicator(
                onRefresh: () => context.read<SettingsCubit>().refreshUserProfile(),
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: ProfileSection(
                            name: userProfile.name,
                            imagePath: userProfile.profileImagePath.isNotEmpty
                                ? userProfile.profileImagePath
                                : ImageManager.profilePlaceholder,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Center(
                          child: Text(
                            userProfile.email,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
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
              ),
              error: (message) => _buildErrorState(message),
              orElse: () => _buildLoadingState(),
            );
          },
        ),
      ),
    );
  }
}
