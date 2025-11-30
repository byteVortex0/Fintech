import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/utils/color_manager.dart';
import 'package:fintech/core/utils/image_manager.dart';
import 'package:fintech/features/settings/presentation/widgets/profile_section.dart';
import 'package:fintech/features/settings/presentation/widgets/settings_section_header.dart';
import 'package:fintech/features/settings/presentation/widgets/settings_item.dart';
import 'package:fintech/features/settings/presentation/widgets/dark_mode_toggle.dart';

/// Settings screen with profile, general settings, and preferences
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColorManager.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: LightColorManager.scaffoldBackground,
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E3A5F),
          ),
        ),
        centerTitle: false,
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
              DarkModeToggle(
                isDarkMode: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
