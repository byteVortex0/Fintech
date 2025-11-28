import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Bottom navigation bar with GoRouter state awareness
///
/// Architecture:
/// - StatelessWidget (no internal state management needed)
/// - Uses GoRouterState.of(context) to automatically track current route
/// - Syncs selected tab with current location
/// - Calls context.go() to navigate when tabs are tapped
/// - Persistent across /home, /market, /portfolio, /settings via ShellRoute
class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current route location from GoRouter to determine selected tab
    final location = GoRouterState.of(context).uri.path;
    final selectedIndex = _getSelectedIndex(location);

    return BottomNavigationBar(
      currentIndex: selectedIndex,
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
      onTap: (index) => _handleNavigation(context, index),
    );
  }

  int _getSelectedIndex(String location) {
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/market')) return 1;
    if (location.startsWith('/portfolio')) return 2;
    if (location.startsWith('/settings')) return 3;
    return 0;
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/market');
        break;
      case 2:
        context.go('/portfolio');
        break;
      case 3:
        context.go('/settings');
        break;
    }
  }
}
