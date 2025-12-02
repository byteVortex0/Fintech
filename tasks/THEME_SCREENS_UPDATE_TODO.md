# Dark Mode - Update All Screens Todo List

## Status: 📋 Planning - Waiting for Approval

---

## Overview
Update ALL screens in the application to support dark mode by replacing hardcoded colors with Theme.of(context) colors.

**Current Issue**:
- ✅ Theme system works (Cubit + persistence)
- ✅ Settings screen supports dark mode
- ❌ All other screens still use hardcoded colors
- ❌ Navigating to Home/Market/Portfolio shows light mode even when dark mode is ON

**Goal**:
- Make dark mode work in 100% of the app
- All colors come from Theme.of(context)
- No hardcoded colors remain
- Theme persists across app restarts (already implemented ✅)

---

## Screens to Update (10 screen groups)

### 1. Bottom Navigation Bar ✅ (Already theme-aware via bottomNavigationBarTheme)
- [x] Uses theme colors from ThemeData
- [x] No changes needed

### 2. Home Screen (1 screen)
- [ ] Update `home_screen.dart` - Replace hardcoded colors
- [ ] Update `home_header.dart` - Text and icon colors
- [ ] Update `current_balance_card.dart` - Background and text colors
- [ ] Update `market_overview_grid.dart` - Card and text colors
- [ ] Update `trending_coins_section.dart` - Section header color
- [ ] Update `trending_coin_card.dart` - Card background, text, icon colors
- [ ] Update `top_gainers_section.dart` - Section header color
- [ ] Update `top_gainer_item.dart` - Background, text, icon colors
- [ ] Test Home screen in dark mode

### 3. Market Screen (1 screen)
- [ ] Update `market_screen.dart` - Scaffold background
- [ ] Update `market_search_bar.dart` - Background, text, icon colors
- [ ] Update `category_filter.dart` - Selected/unselected colors
- [ ] Update `coin_list_item.dart` - Background, text, icon colors
- [ ] Test Market screen in dark mode

### 4. Coin Details Screen (1 screen)
- [ ] Update `coin_details_screen.dart` - Scaffold background
- [ ] Update `coin_header_section.dart` - Text and icon colors
- [ ] Update `price_card_widget.dart` - Card background, text colors
- [ ] Update `chart_section_widget.dart` - Background, button colors
- [ ] Update `statistics_section.dart` - Card background, text colors
- [ ] Update `about_section.dart` - Text colors
- [ ] Update `action_buttons_section.dart` - Button colors
- [ ] Test Coin Details in dark mode

### 5. Buy Crypto Screen (1 screen)
- [ ] Update `buy_crypto_screen.dart` - Scaffold background
- [ ] Update `currency_input_section.dart` - Input background, text colors
- [ ] Update `exchange_rate_indicator.dart` - Text colors
- [ ] Update `exchange_fee_card.dart` - Card background, text colors
- [ ] Test Buy Crypto in dark mode

### 6. Payment Method Screen (1 screen)
- [ ] Update `payment_method_screen.dart` - Scaffold background
- [ ] Update `credit_card_section.dart` - Card background, text colors
- [ ] Update `gradient_card_display.dart` - Consider dark variant
- [ ] Update `payment_option_row.dart` - Background, text, icon colors
- [ ] Update `email_receipt_toggle.dart` - Switch and text colors
- [ ] Test Payment Method in dark mode

### 7. Portfolio Screen (1 screen)
- [ ] Update `portfolio_screen.dart` - Scaffold background
- [ ] Update `total_value_card.dart` - Gradient (consider dark variant), text colors
- [ ] Update `time_period_selector.dart` - Selected/unselected colors
- [ ] Update `portfolio_donut_chart.dart` - Chart colors (may need adjustment)
- [ ] Update `my_holdings_section.dart` - Section header color
- [ ] Update `holding_card_item.dart` - Card background, text colors
- [ ] Update `recent_transactions_section.dart` - Section header color
- [ ] Update `transaction_item.dart` - Background, text, icon colors
- [ ] Test Portfolio in dark mode

### 8. Settings Screen ✅ (Already Updated)
- [x] Uses Theme.of(context) colors
- [x] Already supports dark mode
- [x] No changes needed

### 9. Login Screens (5 screens)
- [ ] Update `login_page.dart` - Scaffold background, text colors
- [ ] Update `curved_background.dart` - Background color (light/dark variant)
- [ ] Update `login_form.dart` - Input colors, button colors
- [ ] Update `social_login_section.dart` - Icon colors
- [ ] Update `face_id_scanning_page.dart` - Background, card, text colors
- [ ] Update `face_id_verified_page.dart` - Card, text, button colors
- [ ] Update `touch_id_scanning_page.dart` - Background, text colors
- [ ] Update `touch_id_verified_page.dart` - Card, text, button colors
- [ ] Test all Login screens in dark mode

### 10. Register Screens (5 screens)
- [ ] Update `register_page.dart` - Scaffold background, text colors
- [ ] Update `register_header.dart` - Text colors
- [ ] Update `register_form.dart` - Input colors, button colors
- [ ] Update `set_face_id_page.dart` - Background, button, text colors
- [ ] Update `set_face_id_verified_page.dart` - Card, text, button colors
- [ ] Update `set_fingerprint_page.dart` - Background, button, text colors
- [ ] Update `set_fingerprint_verified_page.dart` - Card, text, button colors
- [ ] Test all Register screens in dark mode

### 11. Onboarding Screen (1 screen)
- [ ] Update `onboarding_page.dart` - Background color
- [ ] Update `onboarding_slide.dart` - Text colors
- [ ] Update `onboarding_indicators.dart` - Indicator colors (active/inactive)
- [ ] Update `onboarding_next_button.dart` - Button colors
- [ ] Update `onboarding_get_started.dart` - Button colors
- [ ] Test Onboarding in dark mode

---

## Color Replacement Strategy

### What to Replace:

#### 1. Background Colors
**Before:**
```dart
backgroundColor: LightColorManager.scaffoldBackground,
// or
backgroundColor: const Color(0xFFF8F9FA),
```

**After:**
```dart
backgroundColor: Theme.of(context).scaffoldBackgroundColor,
```

#### 2. Text Colors
**Before:**
```dart
color: const Color(0xFF1E3A5F),
// or
color: Colors.black,
```

**After:**
```dart
color: Theme.of(context).textTheme.bodyLarge?.color,
// or for secondary text:
color: Theme.of(context).textTheme.bodyMedium?.color,
```

#### 3. Icon Colors
**Before:**
```dart
color: const Color(0xFF1E3A5F),
```

**After:**
```dart
color: Theme.of(context).iconTheme.color,
```

#### 4. Card Colors
**Before:**
```dart
color: Colors.white,
// or
color: const Color(0xFFFFFFFF),
```

**After:**
```dart
color: Theme.of(context).cardTheme.color,
```

#### 5. AppBar Colors
**Before:**
```dart
AppBar(
  backgroundColor: const Color(0xFFF8F9FA),
  iconTheme: IconThemeData(color: Color(0xFF1E3A5F)),
)
```

**After:**
```dart
AppBar(
  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  iconTheme: Theme.of(context).appBarTheme.iconTheme,
)
```

---

## Special Cases

### 1. Gradients (Total Value Card, Login Background)
**Option A:** Create dark variants
```dart
final isDark = Theme.of(context).brightness == Brightness.dark;
final gradient = isDark
  ? LinearGradient(colors: [Color(0xFF1E3A5F), Color(0xFF0D1F3D)])
  : LinearGradient(colors: [Color(0xFF5B8DEF), Color(0xFF0063F7)]);
```

**Option B:** Use semi-transparent overlays
```dart
decoration: BoxDecoration(
  gradient: LinearGradient(...),
  color: Theme.of(context).brightness == Brightness.dark
    ? Colors.black.withOpacity(0.3)
    : null,
),
```

### 2. SVG Icons
- SVG icons should inherit color from parent
- Use `color` parameter in SvgPicture.asset()
```dart
SvgPicture.asset(
  icon,
  color: Theme.of(context).iconTheme.color,
)
```

### 3. Custom Colors (Primary Blue, Green, Red)
- Keep brand colors the same in both modes
- Examples: Primary blue (#0063F7), Success green, Error red
```dart
// These stay the same:
color: Theme.of(context).colorScheme.primary, // #0063F7
color: Theme.of(context).colorScheme.error,   // #FF5252
```

### 4. Borders
**Before:**
```dart
border: Border(bottom: BorderSide(color: LightColorManager.borderColor)),
```

**After:**
```dart
border: Border(
  bottom: BorderSide(
    color: Theme.of(context).brightness == Brightness.dark
      ? DarkColorManager.borderColor
      : LightColorManager.borderColor,
  ),
),
```

---

## Shared Widgets to Update

### 1. AppTextField
- [ ] Update `app_text_field.dart` - Input background, text, border colors

### 2. AppBottomNavigation
- [x] Already uses theme colors
- [x] No changes needed

### 3. AppBackButton
- [ ] Update `app_back_button.dart` - Icon color

### 4. PrimaryButton
- [ ] Update `primary_button.dart` - Button background, text colors

---

## Testing Checklist

### Manual Testing (Each Screen)
- [ ] Navigate to screen
- [ ] Toggle dark mode in Settings
- [ ] Navigate back to screen
- [ ] Verify ALL elements updated:
  - [ ] Background color
  - [ ] Text color (titles, body, secondary)
  - [ ] Icon color
  - [ ] Card/container backgrounds
  - [ ] Button colors
  - [ ] Border colors
  - [ ] SVG icon colors
- [ ] Verify readability in dark mode
- [ ] Verify no white flashes or jarring transitions

### Persistence Testing
- [ ] Set dark mode ON
- [ ] Close app completely
- [ ] Reopen app
- [ ] Verify app opens in dark mode
- [ ] Navigate to all screens
- [ ] Verify all screens in dark mode

### Code Quality
- [ ] Run `flutter analyze` (0 errors, 0 new warnings)
- [ ] Run `dart format .`
- [ ] Verify no hardcoded colors remain (search for `Color(0x`)
- [ ] Verify all files under 100 lines

---

## Implementation Order (Recommended)

### Phase 1: Bottom Nav Screens (Most Used)
1. Home Screen (8 files)
2. Market Screen (4 files)
3. Portfolio Screen (8 files)
4. Settings Screen ✅ (already done)

### Phase 2: Secondary Screens
5. Coin Details (7 files)
6. Buy Crypto (4 files)
7. Payment Method (5 files)

### Phase 3: Auth Screens
8. Login Screens (8 files)
9. Register Screens (7 files)
10. Onboarding (5 files)

### Phase 4: Shared Widgets
11. AppTextField (1 file)
12. AppBackButton (1 file)
13. PrimaryButton (1 file)

---

## Files to Update Summary

**Estimated Total**: ~55 widget files to update

### By Screen Group:
- Home: 8 files
- Market: 4 files
- Coin Details: 7 files
- Buy Crypto: 4 files
- Payment Method: 5 files
- Portfolio: 8 files
- Settings: 0 files (done)
- Login: 8 files
- Register: 7 files
- Onboarding: 5 files
- Shared: 3 files

---

## Success Criteria

✅ **Dark mode works in 100% of app**
✅ **No hardcoded colors** (all use Theme.of(context))
✅ **Theme persists** across app restarts
✅ **All text readable** in both light and dark mode
✅ **All icons visible** in both modes
✅ **Smooth transitions** when toggling theme
✅ **No white flashes** or jarring color changes
✅ **Flutter analyze: 0 errors, 0 new warnings**
✅ **All files under 100 lines**
✅ **Clean, simple code** (no complicated widgets)

---

## Complexity Estimate

- **High Volume**: 55+ files to update
- **Low Complexity**: Simple color replacements (Theme.of(context))
- **Time Estimate**: 4-6 hours of focused work
- **Approach**: Systematic screen-by-screen updates

---

**Ready for Implementation**: Waiting for your approval to proceed 🚀

**Should we:**
1. Update all screens at once? (big commit)
2. Update in phases (Home → Market → Portfolio → etc)?
3. Focus on specific screens first?

Let me know your preference!
