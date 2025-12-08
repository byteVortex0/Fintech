# Fintech App - Project Requirements & Implementation Plan

## Project Overview
A cryptocurrency fintech application with biometric authentication, secure portfolio management, real-time market data, and trading functionality using CoinGecko API.

---

## Architecture & Code Structure

### 1. Clean Architecture (Without Domain Layer)
```
lib/
├── features/
│   ├── onboarding/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   ├── widgets/
│   │   │   └── bloc/
│   │   └── data/
│   │       ├── datasources/
│   │       ├── models/
│   │       └── repositories/
│   ├── auth/
│   ├── home/
│   ├── market/
│   ├── coin_details/
│   ├── buy_sell/
│   ├── portfolio/
│   └── settings/
├── core/
│   ├── di/
│   ├── extensions/
│   ├── routes/
│   ├── service/
│   │   ├── api/
│   │   ├── local_storage/
│   │   ├── biometric/
│   │   └── security/
│   └── utils/
└── main.dart
```

### 2. State Management: BLoC
- Each feature will have its own BLoC
- Shared BLoCs in core for app-level state (auth, theme)
- Events → Processing → States pattern

### 3. OOP + SOLID Principles

- **S**: Single Responsibility
- **O**: Open/Closed
- **L**: Liskov Substitution
- **I**: Interface Segregation
- **D**: Dependency Inversion

### 4. Navigation Architecture

- **ALL navigation in the entire app MUST go through NavigationService**
- Location: `lib/core/navigation/navigation_service.dart`
- Centralized navigation using GlobalKey for NavigatorState
- Context-free navigation for decoupled components
- All route references MUST use AppRoutes constants (never hardcoded strings)

#### Navigation Methods

```dart
NavigationService.navigateTo(AppRoutes.routeName)              // Push
NavigationService.navigateToAndReplace(AppRoutes.routeName)    // Replace
NavigationService.navigateToAndRemoveUntil(AppRoutes.routeName) // Clear stack
NavigationService.goBack()                                      // Pop
```

#### FORBIDDEN ❌

```dart
Navigator.of(context).pushNamed(...)        // NEVER use this
Navigator.of(context).pushReplacementNamed(...) // NEVER use this
Navigator.of(context).pop()                 // NEVER use this
context.push(...)                           // NEVER use this
Navigator.push(...)                         // NEVER use this
```

---

## Screens to Implement (8 Total)

1. **Onboarding & Authentication** - UI COMPLETE
   - [x] Onboarding (4-slide carousel)
   - [x] Login (Email/Password + social login icons)
   - [x] Face ID Scanning (background image + card)
   - [x] Face ID Verified (success with checkmark card)
   - [x] Touch ID Scanning (fingerprint icon)
   - [x] Touch ID Verified (success with filled checkmark)
   - [x] Register/Signup (Form + Face ID & Fingerprint setup)

2. **Home** - COMPLETE ✅
   - [x] Home screen with dashboard
   - [x] Market overview grid (2x2)
   - [x] Trending coins horizontal scroll
   - [x] Top gainers list
   - [x] Bottom navigation bar with state management
   - [x] NavigationService integration
   - [x] Responsive design

3. **Market** - COMPLETE ✅
   - [x] Market screen with coin listing
   - [x] Search functionality with MarketSearchBar
   - [x] Category filters (All, DeFi, NFT, Gaming, Metaverse)
   - [x] Coin list with SVG icons
   - [x] Tap to navigate to coin details
   - [x] MarketCoinModel with Freezed

4. **Coin Details** - COMPLETE ✅
   - [x] Coin header with name and icon
   - [x] Price card with percentage change badge
   - [x] Chart section with time period buttons (1h, 1d, 1w, 1m, 1y)
   - [x] Statistics section (5 rows: Current Price, Market Cap, Volume 24h, Available Supply, Max Supply)
   - [x] About section with coin description
   - [x] Action buttons (Sell and Buy)
   - [x] CoinDetailsModel with Freezed
   - [x] Navigation to Buy Crypto screen

5. **Buy Crypto** - COMPLETE ✅
   - [x] Currency exchange interface
   - [x] "You Pay" input section
   - [x] "You Receive" input section
   - [x] Exchange rate indicator
   - [x] Exchange fee card with money.png icon
   - [x] Continue button navigates to Payment Method

6. **Payment Method** - COMPLETE ✅
   - [x] Credit Card section (expandable)
   - [x] Payment method selector (VISA, Mastercard, Apple Pay)
   - [x] Gradient card display using card.png
   - [x] Google Pay and Mobile Banking options
   - [x] "Send receipt to your email" toggle
   - [x] Buy button (navy blue #1E3A5F)
   - [x] NavigationService.goBack implementation

7. **Portfolio** - COMPLETE ✅
   - [x] Portfolio screen with 6 functional sections
   - [x] Total Value Card with blue gradient and today's performance
   - [x] Time Period Selector (horizontal scrollable month chips)
   - [x] Portfolio Donut Chart with Stack/Container/SweepGradient (no CustomPaint)
   - [x] My Holdings section with 3 cryptocurrency cards (4-line data display)
   - [x] Recent Transactions list with Buy/Sell indicators (circular arrows)
   - [x] PortfolioModel, HoldingModel, TransactionModel with Freezed
   - [x] Portfolio route in GoRouter ShellRoute
   - [x] Responsive design with flutter_screenutil
   - [x] Placeholder data for UI testing with complete crypto amounts and dollar values
   - [x] Uses only basic Flutter widgets (Stack, Container, Row, Column, SweepGradient)
   - [x] **PHASE 13**: Real API data from CoinGecko
   - [x] Freezed state management (initial, loading, loaded, error)
   - [x] Pull-to-refresh functionality with RefreshIndicator
   - [x] PortfolioCubit with BLoC pattern
   - [x] maybeWhen pattern matching in UI
   - [x] Secure API key management with flutter_dotenv
   - [x] Centralized API endpoints in ApiEndpoints

8. **Settings** - COMPLETE ✅
   - [x] Settings screen with profile section and preferences
   - [x] Profile Section with large CircleAvatar (140px diameter) and user name
   - [x] General Settings section (My Account, Billing/Payment, FAQ & Support)
   - [x] App Settings section (Language, Dark Mode toggle)
   - [x] UserProfileModel with Freezed (name, profileImagePath)
   - [x] Reusable SettingsItem widget with conditional border rendering
   - [x] Dark mode toggle with Switch (fixed deprecated activeColor)
   - [x] Settings route in GoRouter ShellRoute
   - [x] Responsive design with flutter_screenutil
   - [x] Uses only basic Flutter widgets (Container, Row, Column, CircleAvatar, Switch)
   - [x] Added borderColor to LightColorManager for centralized color management

9. **Theme System** - COMPLETE ✅
   - [x] ThemeCubit for dark/light mode state management (BLoC pattern)
   - [x] ThemeStorageService for persistent theme storage (SharedPreferences)
   - [x] Light theme with comprehensive ThemeData configuration
   - [x] Dark theme with optimized colors for dark surfaces
   - [x] LightColorManager extended with light mode colors
   - [x] DarkColorManager extended with dark mode colors
   - [x] FinTechApp updated with BLocProvider and BlocBuilder
   - [x] Dark mode toggle functional in Settings screen
   - [x] Theme loads automatically on app startup
   - [x] Theme persists after app restart
   - [x] All 8+ screens adapt automatically to selected theme
   - [x] Redundant comments removed from 4 widget files (62 lines cleaned)
   - [x] Code quality improved per mentor feedback

---

## Security Features

### 1. Biometric Authentication
- [ ] Fingerprint authentication
- [ ] Face ID support
- [ ] Fallback to PIN/Password

### 2. Encrypted Storage
- [ ] Transaction history encrypted
- [ ] User credentials secured
- [ ] Sensitive data encryption

### 3. App Security
- [ ] Background app blur (sensitive screens)
- [ ] Root detection (optional)
- [ ] Screenshot prevention (portfolio, transactions)
- [ ] Auto-lock after inactivity

### 4. Session Management
- [ ] Automatic logout on timeout
- [ ] Secure token management
- [ ] Refresh token handling
- [ ] Token encryption

---

## API Integration (CoinGecko)

### Home Screen Endpoints
- `GET /global` - Market overview statistics
- `GET /search/trending` - Trending coins
- `GET /coins/markets` - Top gainers

### Market Screen
- `GET /coins/markets?per_page=50&page=1` - Paginated list
- `GET /search?query={keyword}` - Search

### Coin Details
- `GET /coins/{id}` - Detailed info
- `GET /coins/{id}/market_chart?days={1|7|30|365|max}` - Charts

### Portfolio
- `GET /simple/price?ids={ids}&vs_currencies=usd` - Live prices

---

## Technical Stack (From pubspec.yaml)

### Current Dependencies
- `flutter_screenutil: ^5.9.3` - Responsive design
- `get_it: ^9.1.0` - Dependency Injection
- `retrofit: ^4.9.1` - Type-safe API client
- `dio: ^5.9.0` - HTTP client
- `pretty_dio_logger: ^1.4.0` - API logging
- `shared_preferences: ^2.5.3` - Local storage
- `json_annotation: ^4.9.0` - JSON serialization

### Need to Add
- `flutter_bloc: ^8.x.x` - State management
- `equatable: ^2.x.x` - Equality comparison
- `local_auth: ^2.x.x` - Biometric auth
- `flutter_secure_storage: ^8.x.x` - Encrypted storage
- `intl: ^0.x.x` - Internationalization
- `firebase_core: ^2.x.x` - Firebase setup
- `firebase_analytics: ^10.x.x` - Analytics
- `firebase_crashlytics: ^2.x.x` - Crash reporting
- `logger: ^1.x.x` - Logging
- `connectivity_plus: ^3.x.x` - Network detection
- `hive: ^2.x.x` - Local database (already prepared)
- `hive_flutter: ^1.x.x`

---

## Implementation Phases

### Phase 1: Setup & Infrastructure ✅

- [x] Clean architecture structure
- [x] Core utilities & services setup
- [x] Routing system configured
- [ ] Add missing packages to pubspec.yaml
- [ ] Configure Retrofit API client with interceptors
- [ ] Setup BLoC structure and state management
- [ ] Configure flavors (dev, staging, production)
- [ ] Setup CI/CD pipeline
- [ ] Configure Firebase (analytics, crashlytics)

### Phase 2: Authentication & Security (UI COMPLETE)

- [x] Onboarding UI (4-slide carousel)
- [x] Login UI (Email/Password)
- [x] Face ID Scanning UI (with background image)
- [x] Face ID Verified UI (success screen with card)
- [x] Touch ID Scanning UI (fingerprint icon)
- [x] Touch ID Verified UI (success screen with filled checkmark)
- [x] Social login icons (Fingerprint & Face ID)
- [x] Register/Signup UI (Email, password, biometric setup)
- [x] Set Face ID UI (Skip/Continue buttons)
- [x] Set Fingerprint UI (Tap fingerprint, Skip button)
- [x] Face ID Verified UI (Register flow completion)
- [x] Fingerprint Verified UI (Register flow completion)
- [ ] Implement biometric authentication logic (BLoC)
- [ ] Setup secure token storage
- [ ] Implement auto-lock mechanism
- [ ] Screenshot prevention on sensitive screens
- [ ] Root detection (optional)

### Phase 2.5: Code Quality & Refactoring (COMPLETE)

- [x] Replace all hardcoded route strings with AppRoutes constants
- [x] Create shared AppTextField widget
- [x] Create NavigationService for centralized navigation
- [x] Add comprehensive code comments
- [x] Verify 0 hardcoded routes in codebase
- [x] Update app infrastructure files

### Phase 3: Core Features ✅

1. Home Screen (market overview) - COMPLETE
2. Market Screen (coin list) - COMPLETE
3. Coin Details Screen - COMPLETE
4. Buy Crypto Screen - COMPLETE
5. Payment Method Screen - COMPLETE
6. Portfolio Screen - NEXT
7. Settings Screen - PLANNED

### Phase 4: Advanced Features
1. Buy/Sell Flow
2. Settings Screen
3. User Profile Management

### Phase 5: Testing & Polish
1. Unit tests
2. Integration tests
3. UI/UX refinements
4. Performance optimization

---

## Git Workflow (Your Responsibility)

### Flow
1. Create feature branch: `feature/feature-name`
2. Work on implementation (I'll guide)
3. Commit with proper messages
4. Create PR for review
5. Merge to develop

### Commit Format
```
feat: description
- Change 1
- Change 2

fix: description
- Fix 1

refactor: description
- Refactor 1
```

---

## File Size & Code Organization Rules

### Rules to Follow (From CLAUDE.md)
- ✅ Each widget in separate file
- ✅ Max 100 lines per file
- ✅ Simple, not complex
- ✅ Minimal impact changes
- ✅ Follow clean arch & SOLID
- ✅ Track progress in tasks/todo.md
- ✅ Create PROJECT_SUMMARY.md updates

---

## Testing Strategy

### Unit Tests
- Repository layer
- BLoC logic
- Data models
- Utilities

### Integration Tests
- API calls
- Database operations
- Feature workflows

### Testing Tools
- `flutter_test` (built-in)
- `mockito: ^5.x.x` (mocking)
- `bloc_test: ^9.x.x` (BLoC testing)

---

## Environment & Flavors

### Flavors
1. **dev** - Development server
2. **staging** - Staging server
3. **prod** - Production server

### Environment Variables
- API base URL
- Firebase project IDs
- Feature flags
- Analytics tracking IDs

---

## CI/CD Pipeline

### Automated Checks
- [ ] Code analysis (flutter analyze)
- [ ] Test execution
- [ ] Build APK/IPA
- [ ] Deploy to Firebase App Distribution

---

## Firebase Integration

### Services
- **Analytics** - Track user behavior
- **Crashlytics** - Crash reporting
- **Authentication** (optional) - Sign-in management
- **Firestore** (optional) - User data storage

---

## Theming

### Current Setup
- Light theme
- Dark theme
- ThemeExtension for custom colors

### To Implement
- [ ] Verify theme switching works
- [ ] Add theme persistence
- [ ] System theme detection

---

## Caching & Token Management

### Caching Strategy
- [ ] API response caching (Hive)
- [ ] Image caching
- [ ] User data caching

### Token Management
- [ ] Store refresh token securely
- [ ] Auto-refresh expired tokens
- [ ] Logout on token expiry

---

## Next Steps

1. **Git commit** - Commit login feature to feature/login branch
2. **Create PR** - Pull request to develop branch
3. **Register Screen** - Next UI to implement
4. **Home Screen** - After register is complete
5. **BLoC Integration** - State management when UI is ready

---

**Current Status**: Phase 16 Complete (Settings Firebase Integration) - Ready for PR & Phase 17 (Market API/UI Improvements)
