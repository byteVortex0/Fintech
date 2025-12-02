# Theme System (Dark/Light Mode) - Implementation Todo List

## Branch: feature/theme
## Status: 📋 Planning - Waiting for Approval

---

## Overview
Implement complete dark/light mode system using Cubit for state management, with persistence and integration with Settings screen toggle.

**User Requirements**:
- "fully clean and so easy нет complicated code"
- Use Cubit for state management
- Connect to dark mode toggle in Settings
- Persist theme preference
- Update all existing screens to support dark mode

---

## Phase 1: Dependencies & Setup

### 1.1 Add Dependencies
- [ ] Add `flutter_bloc: ^8.1.3` to pubspec.yaml dependencies
- [ ] Run `flutter pub get` to install packages

---

## Phase 2: Theme Configuration

### 2.1 Create Theme Data Files
- [ ] Create `lib/core/utils/themes/light_theme.dart` - Complete light ThemeData
- [ ] Create `lib/core/utils/themes/dark_theme.dart` - Complete dark ThemeData
- [ ] Define all theme properties:
  - scaffoldBackgroundColor
  - appBarTheme
  - textTheme
  - iconTheme
  - cardTheme
  - bottomNavigationBarTheme
  - inputDecorationTheme
  - buttonTheme

### 2.2 Expand ColorManager
- [ ] Add all missing colors to DarkColorManager:
  - scaffoldBackground
  - screenBackground
  - borderColor
  - textPrimary
  - textSecondary
  - iconPrimary
  - iconSecondary
  - cardBackground

---

## Phase 3: Theme Cubit Implementation

### 3.1 Create Theme Cubit
- [ ] Create `lib/core/theme/theme_cubit.dart` - Simple Cubit class
- [ ] Create `lib/core/theme/theme_state.dart` - Light/Dark state (use enum)
- [ ] Implement `toggleTheme()` method
- [ ] Implement `setTheme(ThemeMode mode)` method
- [ ] Add theme persistence with SharedPreferences
- [ ] Load saved theme on app start

### 3.2 Theme Persistence
- [ ] Create `lib/core/service/local_storage/theme_storage_service.dart`
- [ ] Implement `saveTheme(String theme)` method
- [ ] Implement `loadTheme()` → returns 'light' or 'dark'
- [ ] Use SharedPreferences for storage

---

## Phase 4: App Integration

### 4.1 Update Main App Structure
- [ ] Wrap `MaterialApp.router` with `BlocProvider<ThemeCubit>`
- [ ] Update `fintech_app.dart` to use `BlocBuilder<ThemeCubit, ThemeState>`
- [ ] Pass `theme` and `darkTheme` to MaterialApp.router
- [ ] Set `themeMode` based on Cubit state
- [ ] Initialize ThemeCubit in main.dart before runApp

### 4.2 Update Dependency Injection
- [ ] Add ThemeCubit to GetIt registration in `injection.dart`
- [ ] Add ThemeStorageService to GetIt
- [ ] Ensure proper singleton lifecycle

---

## Phase 5: Connect Settings Toggle

### 5.1 Update Settings Screen
- [ ] Inject ThemeCubit into SettingsScreen via context.read
- [ ] Update DarkModeToggle to use Cubit state (not local StatefulWidget)
- [ ] Call `context.read<ThemeCubit>().toggleTheme()` on switch change
- [ ] Use `BlocBuilder` or `context.watch` to reflect current theme state
- [ ] Remove local `isDarkMode` state from SettingsScreen

---

## Phase 6: Update Existing Screens for Dark Mode

### 6.1 Update Home Screen
- [ ] Replace hardcoded colors with Theme.of(context) colors
- [ ] Test all widgets in dark mode
- [ ] Verify SVG icons visibility
- [ ] Verify text readability

### 6.2 Update Market Screen
- [ ] Replace hardcoded colors with Theme colors
- [ ] Update search bar colors
- [ ] Update category filter colors
- [ ] Test coin list in dark mode

### 6.3 Update Coin Details Screen
- [ ] Update all hardcoded colors
- [ ] Update chart section colors
- [ ] Update statistics section
- [ ] Test action buttons visibility

### 6.4 Update Buy Crypto Screen
- [ ] Update currency input section colors
- [ ] Update exchange fee card
- [ ] Test in dark mode

### 6.5 Update Payment Method Screen
- [ ] Update credit card section
- [ ] Update payment options
- [ ] Test toggle colors

### 6.6 Update Portfolio Screen
- [ ] Update total value card gradient (consider dark variant)
- [ ] Update donut chart colors
- [ ] Update holdings cards
- [ ] Update transaction items
- [ ] Test all sections in dark mode

### 6.7 Update Settings Screen
- [ ] Update profile section colors
- [ ] Update settings item colors
- [ ] Update section headers
- [ ] Test in dark mode

### 6.8 Update Login/Register Screens
- [ ] Update curved background colors
- [ ] Update input field colors
- [ ] Update button colors
- [ ] Test biometric screens

### 6.9 Update Onboarding Screen
- [ ] Update slide colors
- [ ] Update indicator colors
- [ ] Update button colors

### 6.10 Update Bottom Navigation
- [ ] Use Theme colors for selected/unselected
- [ ] Update background color
- [ ] Test in both modes

---

## Phase 7: Testing & Refinement

### 7.1 Manual Testing
- [ ] Test theme toggle on Settings screen
- [ ] Verify theme persists after app restart
- [ ] Test all screens in light mode
- [ ] Test all screens in dark mode
- [ ] Test theme switching while navigating
- [ ] Verify no hardcoded colors remain
- [ ] Check text readability in both modes
- [ ] Check icon visibility in both modes

### 7.2 Code Quality
- [ ] Run `flutter analyze` (0 errors, 0 new warnings)
- [ ] Run `dart format .`
- [ ] Verify all files under 100 lines
- [ ] Verify clean code practices
- [ ] Verify no complicated widgets

---

## Phase 8: Documentation

### 8.1 Update Documentation Files
- [ ] Update README.md (move Theme System from "In Development" to "Implemented")
- [ ] Update PROJECT_SUMMARY.md with Phase 12
- [ ] Update PROJECT_REQUIREMENTS.md
- [ ] Update tasks/todo.md
- [ ] Create tasks/THEME_IMPLEMENTATION.md

---

## Phase 9: Git Workflow

### 9.1 Commit & Push
- [ ] Stage all changes
- [ ] Create comprehensive commit message
- [ ] Push to remote feature/theme branch
- [ ] Wait for PR review and approval

---

## Technical Approach

### Cubit State (Simple Enum)
```dart
enum ThemeMode {
  light,
  dark,
}

class ThemeState {
  final ThemeMode mode;
  const ThemeState(this.mode);
}
```

### Theme Toggle Flow
1. User taps dark mode switch in Settings
2. Settings calls `context.read<ThemeCubit>().toggleTheme()`
3. ThemeCubit emits new state (light ↔ dark)
4. ThemeCubit saves preference to SharedPreferences
5. BlocBuilder in fintech_app.dart rebuilds MaterialApp with new theme
6. Entire app UI updates instantly

### Theme Access in Widgets
```dart
// Get colors from theme
Theme.of(context).scaffoldBackgroundColor
Theme.of(context).textTheme.bodyLarge?.color
Theme.of(context).colorScheme.primary

// Or use ColorManager with theme awareness
final colors = Theme.of(context).brightness == Brightness.dark
    ? DarkColorManager
    : LightColorManager;
```

---

## Files to Create (Estimated 8 new files)

1. `lib/core/theme/theme_cubit.dart` - State management
2. `lib/core/theme/theme_state.dart` - State definition
3. `lib/core/utils/themes/light_theme.dart` - Light ThemeData
4. `lib/core/utils/themes/dark_theme.dart` - Dark ThemeData
5. `lib/core/service/local_storage/theme_storage_service.dart` - Persistence
6. `tasks/THEME_IMPLEMENTATION.md` - Documentation

## Files to Modify (Estimated 20+ files)

1. `pubspec.yaml` - Add flutter_bloc
2. `lib/main.dart` - Initialize ThemeCubit
3. `lib/fintech_app.dart` - Add BlocProvider and BlocBuilder
4. `lib/core/di/injection.dart` - Register ThemeCubit
5. `lib/core/utils/color_manager.dart` - Expand DarkColorManager
6. `lib/features/settings/presentation/pages/settings_screen.dart` - Connect to Cubit
7. All screen files (10+) - Replace hardcoded colors with Theme colors

---

## Complexity Estimate

- **Low Complexity**: Cubit setup, theme configuration, persistence
- **Medium Complexity**: Settings integration, color replacement
- **Time Estimate**: 2-3 hours of focused work

---

## Success Criteria

✅ Dark mode toggle in Settings works
✅ Theme preference persists after app restart
✅ All screens support dark mode
✅ No hardcoded colors in widgets
✅ Text readable in both modes
✅ Icons visible in both modes
✅ Clean, simple code (no complicated widgets)
✅ Flutter analyze: 0 errors, 0 new warnings
✅ All files under 100 lines

---

**Ready for Implementation**: Waiting for user approval to proceed 🚀
