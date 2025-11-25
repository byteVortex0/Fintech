import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// App bottom navigation bar widget
/// Manages its own selected state - color changes when items are tapped
class AppBottomNavigation extends StatefulWidget {
  const AppBottomNavigation({super.key});

  @override
  State<AppBottomNavigation> createState() => _AppBottomNavigationState();
}

class _AppBottomNavigationState extends State<AppBottomNavigation> {
  /// Tracks which navigation item is currently selected
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF1A2B4A),
      unselectedItemColor: const Color(0xFF9CA3AF),
      elevation: 8,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, size: 24.sp),
          activeIcon: Icon(Icons.home, size: 24.sp),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up, size: 24.sp),
          activeIcon: Icon(Icons.trending_up, size: 24.sp),
          label: 'Market',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.folder_outlined, size: 24.sp),
          activeIcon: Icon(Icons.folder, size: 24.sp),
          label: 'Portfolio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined, size: 24.sp),
          activeIcon: Icon(Icons.settings, size: 24.sp),
          label: 'Settings',
        ),
      ],
      onTap: (index) => _handleNavigation(index),
    );
  }

  /// Handles bottom navigation item taps
  /// Updates local selected state to change color immediately
  void _handleNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // TODO: Navigate to home screen
        break;
      case 1:
        // TODO: Navigate to market screen
        break;
      case 2:
        // TODO: Navigate to portfolio screen
        break;
      case 3:
        // TODO: Navigate to settings screen
        break;
    }
  }
}
