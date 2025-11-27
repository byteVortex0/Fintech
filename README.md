# Crypto X - Fintech Cryptocurrency Trading App

A professional Flutter cryptocurrency trading application with real-time market data, biometric authentication, secure portfolio management, and advanced trading features.

---

## 📱 Features

### Implemented

- **Onboarding Flow** - Professional 4-slide carousel with smooth animations
- **Login Screen** - Email/password authentication with social login icons
- **Face ID Scanning** - Full-screen background image with Face ID card
- **Face ID Verified** - Success screen with checkmark card
- **Touch ID Scanning** - Fingerprint icon with curved background
- **Touch ID Verified** - Success screen with filled checkmark circle
- **Register Screen** - User registration with 6 input fields
- **Set Face ID** - Face ID setup during registration (Skip/Continue)
- **Set Fingerprint** - Fingerprint setup during registration
- **Face ID & Fingerprint Verified** - Success screens for registration flow
- **Home Screen Dashboard** - Market overview with balance, market stats, trending coins, and top gainers
- **Custom SVG Icons** - Integrated flutter_svg for custom cryptocurrency icons
- **Freezed Data Models** - Immutable data classes with copyWith(), equality, and code generation
- **Shared AppTextField** - Reusable text input across app
- **NavigationService** - Centralized navigation management
- **AppRoutes Constants** - No hardcoded route strings (0 found)
- **Responsive Design** - Works seamlessly on all screen sizes using `flutter_screenutil`
- **Theme Support** - Light and Dark mode ready (implementation in progress)

### In Development 🚧

- **Splash Screen** - App initialization and onboarding check
- **Market Screen** - Full coin list with search and pagination
- **Coin Details** - Detailed price charts and information
- **Portfolio** - User holdings and performance tracking
- **Buy/Sell** - Trading interface and transaction history
- **Settings** - User preferences and security options

### Recently Completed ✨

- **Home Screen** - Market overview dashboard with balance card, market overview grid, trending coins section, and top gainers list
- **CoinModel with Freezed** - Immutable data class with auto-generated copyWith(), equality, and toString()
- **SVG Icon Integration** - Custom SVG icons for cryptocurrency coins throughout the app

### Planned 📋
- **Biometric Authentication** - Fingerprint and Face ID support
- **Encrypted Storage** - Secure credential and transaction storage
- **Security Features** - Auto-lock, root detection, screenshot prevention
- **Firebase Integration** - Analytics and crash reporting
- **BLoC State Management** - Reactive state management
- **Unit & Integration Tests** - Comprehensive test coverage

---

## 🛠️ Tech Stack

### Core Framework
- **Flutter** ^3.9.2 - UI framework
- **Dart** ^3.9.2 - Programming language

### State Management
- **BLoC** (planned) - Business Logic Component pattern

### API & Networking
- **Retrofit** ^4.9.1 - Type-safe HTTP client
- **Dio** ^5.9.0 - HTTP client engine
- **Pretty Dio Logger** ^1.4.0 - Request/response logging

### Local Storage
- **SharedPreferences** ^2.5.3 - Simple key-value storage
- **Hive** (prepared) - NoSQL local database

### UI & Styling
- **Flutter ScreenUtil** ^5.9.3 - Responsive design
- **Smooth Page Indicator** ^1.1.0 - Animated page dots
- **Flutter SVG** ^2.0.0 - SVG asset rendering for icons

### Dependency Injection
- **GetIt** ^9.1.0 - Service locator pattern

### Data & Serialization
- **JSON Annotation** ^4.9.0 - JSON serialization
- **JSON Serializable** ^6.6.0 - Code generation
- **Freezed Annotation** ^2.2.0 - Immutable model annotations
- **Freezed** ^2.2.0 - Code generation for immutable models

### Development Tools
- **Flutter Lints** ^5.0.0 - Code quality analysis
- **Build Runner** ^2.4.0 - Code generation
- **Retrofit Generator** ^9.7.0 - API client generation

---

## 🏗️ Architecture

This project follows **Clean Architecture** with a **Feature-First** approach:

```text
lib/
├── features/                 # Feature modules
│   ├── onboarding/          # Onboarding flow (Complete)
│   ├── login/               # Login & biometric authentication (Complete)
│   │   └── presentation/
│   │       ├── pages/
│   │       │   ├── login_page.dart
│   │       │   ├── face_id_scanning_page.dart
│   │       │   ├── face_id_verified_page.dart
│   │       │   ├── touch_id_scanning_page.dart
│   │       │   └── touch_id_verified_page.dart
│   │       └── widgets/
│   │           ├── curved_background.dart
│   │           ├── login_input_field.dart
│   │           ├── login_form.dart
│   │           ├── social_login_section.dart
│   │           └── face_id_card.dart
│   ├── home/                # Home screen dashboard (Complete)
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   │   └── home_screen.dart
│   │   │   └── widgets/
│   │   │       ├── home_header.dart
│   │   │       ├── current_balance_card.dart
│   │   │       ├── market_overview_grid.dart
│   │   │       ├── trending_coins_section.dart
│   │   │       ├── trending_coin_card.dart
│   │   │       ├── top_gainers_section.dart
│   │   │       └── top_gainer_item.dart
│   │   └── data/
│   │       └── models/
│   │           ├── coin_model.dart
│   │           └── coin_model.freezed.dart
│   ├── splash/              # App initialization (planned)
│   ├── market/              # Market listing (planned)
│   ├── coin_details/        # Coin details (planned)
│   ├── portfolio/           # Portfolio management (planned)
│   ├── buy_sell/            # Trading interface (planned)
│   └── settings/            # User settings (planned)
├── core/                     # Core utilities & services
│   ├── di/                  # Dependency injection
│   ├── navigation/          # Navigation service
│   ├── routes/              # Navigation & routing
│   ├── service/             # API, storage, security services
│   └── utils/               # Colors, fonts, themes, images, SVG icons
├── shared/                   # Shared components
│   └── widgets/             # Reusable widgets (AppTextField, AppBottomNavigation)
└── main.dart               # App entry point
```

### Design Principles
- **SOLID Principles** - Single responsibility, Open/closed, Liskov substitution, Interface segregation, Dependency inversion
- **Clean Code** - Readable, maintainable, testable code
- **OOP** - Object-oriented programming patterns
- **Separation of Concerns** - Clear boundaries between layers

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK: ^3.9.2
- Dart SDK: ^3.9.2
- Android SDK 21+ or iOS 11.0+

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-repo/fintech.git
   cd fintech
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run code generation** (for Retrofit API client)
   ```bash
   flutter pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 📱 API Integration

This app uses the **CoinGecko API** for cryptocurrency data (free tier):

### Endpoints Used
- `GET /global` - Market overview statistics
- `GET /search/trending` - Trending coins
- `GET /coins/markets` - Coin list with pagination
- `GET /coins/{id}` - Detailed coin information
- `GET /coins/{id}/market_chart` - Historical price data
- `GET /simple/price` - Current prices for holdings

**Note**: No API key required for free tier

---

## 🌐 Git Workflow

### Branch Naming
- `feature/feature-name` - New features
- `fix/bug-name` - Bug fixes
- `refactor/description` - Code refactoring

### Before Every Push
```bash
# Check for errors
flutter analyze

# Format code consistently
dart format .

# Run tests (when available)
flutter test
```

### Commit Message Format
```
feat: brief description
- Change 1
- Change 2

Prompt used: [UI implementation / API integration / etc]
```

---

## 👥 Team Members

- **Abdulrahman Mohammed** - Lead Developer
- **Team Members** - Add your names here

---

## 📋 Project Status

### Phase 1: UI Implementation ✅
- [x] Project structure setup
- [x] Core utilities & services
- [x] Onboarding feature (Complete)
- [x] Login & Face ID authentication (Complete)
- [x] Register screen (Complete)
- [x] Home screen dashboard (Complete)
  - [x] Market overview with stats
  - [x] Trending coins section with SVG icons
  - [x] Top gainers list with SVG icons
  - [x] Custom CoinModel with Freezed
  - [x] Bottom navigation bar
- [ ] Splash screen
- [ ] Market screen

### Phase 2: State Management 🚧
- [ ] BLoC integration
- [ ] Repository pattern
- [ ] API integration

### Phase 3: Features 📋
- [ ] Home screen
- [ ] Market screen
- [ ] Portfolio management
- [ ] Trading interface

### Phase 4: Polish 📋
- [ ] Unit tests
- [ ] Integration tests
- [ ] Performance optimization
- [ ] CI/CD pipeline

---

## 📚 Documentation

- [GIT_WORKFLOW.md](GIT_WORKFLOW.md) - Complete git workflow guide
- [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) - Project progress tracking
- [CLAUDE.md](CLAUDE.md) - Development guidelines and rules
- [ONBOARDING_IMPLEMENTATION.md](tasks/ONBOARDING_IMPLEMENTATION.md) - Onboarding feature details
- [LOGIN_IMPLEMENTATION.md](tasks/LOGIN_IMPLEMENTATION.md) - Login feature details

---

## 🔐 Security Features (Planned)

- Biometric authentication (fingerprint & face ID)
- Encrypted credential storage
- Auto-lock on inactivity
- Transaction history encryption
- Root/jailbreak detection
- Screenshot prevention on sensitive screens
- Secure token management & refresh

---

## 📊 Responsive Design

Built with `flutter_screenutil` for true responsive design:
- Adapts to all screen sizes (phones, tablets)
- Responsive typography (font sizes scale)
- Responsive spacing (padding, margins scale)
- Safe area handling for notches & cutouts

---

## 🧪 Testing

Testing structure is prepared for:
- **Unit Tests** - Individual component testing
- **Widget Tests** - UI component testing
- **Integration Tests** - Full feature flow testing

Run tests with:
```bash
flutter test
```

---

## 📦 Build & Deployment

### Development Build
```bash
flutter build apk --debug
```

### Release Build
```bash
flutter build apk --release
flutter build ios --release
```

---

## 🤝 Contributing

1. Create a feature branch from `develop`
2. Make your changes
3. Run `flutter analyze` and `dart format .`
4. Create a pull request
5. Wait for code review
6. Merge to `develop`

---

## 📝 License

This project is part of a graduation project. All rights reserved.

---

## 📞 Support & Questions

For questions or issues:
1. Check existing documentation
2. Review git workflow guidelines
3. Contact the development team

---

## 🎯 Project Goals

- ✅ Professional code quality
- ✅ Clean architecture
- ✅ Team collaboration
- ✅ Graduation project requirements
- ✅ Real-world cryptocurrency data integration
- ✅ Secure user authentication
- ✅ Comprehensive feature set

---

**Last Updated**: November 27, 2025
**Project Status**: In Active Development
**Current Phase**: Phase 1 (UI Implementation) - Home Screen Complete with Freezed & SVG Icons → Next: Market Screen
