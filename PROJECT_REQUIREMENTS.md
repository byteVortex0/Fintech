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

---

## Screens to Implement (7 Total)

1. **Onboarding & Authentication** ✅ COMPLETE
   - [x] Onboarding (4-slide carousel) - DONE
   - [x] Login (Email/Password + Face ID/Fingerprint) - DONE
   - [ ] Register/Signup
   - [ ] Biometric setup (integrated into Login)

2. **Home** - Market overview, trending coins, top gainers

3. **Market** - Coin list with pagination, search functionality

4. **Coin Details** - Chart, detailed info, price history

5. **Buy/Sell Flow** - Trading interface

6. **Portfolio** - Holdings, live prices, performance

7. **Settings** - Profile, preferences, security

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

### Phase 2: Authentication & Security (IN PROGRESS)

- [x] Onboarding UI (4-slide carousel)
- [x] Login UI (Email/Password)
- [x] Face ID Scanning UI (with animation)
- [x] Face ID Verified UI (success screen)
- [x] Social login icons (Fingerprint & Face ID)
- [ ] Register/Signup UI
- [ ] Implement biometric authentication logic (BLoC)
- [ ] Setup secure token storage
- [ ] Implement auto-lock mechanism
- [ ] Screenshot prevention on sensitive screens
- [ ] Root detection (optional)

### Phase 3: Core Features
1. Home Screen (market overview)
2. Market Screen (coin list)
3. Coin Details Screen
4. Portfolio Screen

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

1. **Clarify with you**: Which screen to start with?
2. **Add missing packages** to pubspec.yaml
3. **Create feature structure** for first screen
4. **Setup BLoC** architecture
5. **Begin implementation**

Would you like to start with the requirements review or jump into implementation?
