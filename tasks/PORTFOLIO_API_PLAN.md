# Phase 13: Portfolio Feature - CoinGecko API Integration Plan

**Date**: December 3, 2025
**Branch**: feature/portfolio-api (to be created)
**Objective**: Integrate CoinGecko API for real-time cryptocurrency prices and portfolio calculations

---

## 1. Current State Assessment

### Existing Infrastructure ✅

#### 1.1 DioFactory (`lib/core/service/api/dio_factory.dart`)
- ✅ Singleton pattern: Properly implemented with `instance` and `getDio()`
- ✅ Timeout configuration: 30 seconds (connectTimeout + receiveTimeout)
- ✅ Interceptor: PrettyDioLogger added for request/response logging
- ✅ Status: **READY TO USE - No changes needed**
- ℹ️ Note: Has commented code for Bearer token auth (future enhancement)

#### 1.2 ApiService (`lib/core/service/api/api_service.dart`)
- ✅ Retrofit library: Properly imported and configured
- ✅ Base URL: `https://api.coingecko.com/api/` (needs v3 update)
- ✅ Factory pattern: Correct implementation
- ⚠️ Status: **NEEDS UPDATES**
  - [ ] Update base URL to include `/v3`
  - [ ] Add portfolio price endpoint

#### 1.3 Dependency Injection (`lib/core/di/injection.dart`)
- ✅ DioFactory: Already registered in `_initCore()`
- ⚠️ ApiService: Commented out on line 22 - ready to uncomment
- Status: **NEEDS REGISTRATION**
  - [ ] Uncomment ApiService registration

#### 1.4 Existing Models ✅
- ✅ `HoldingModel`: Freezed immutable model with 9 fields
- ✅ `PortfolioModel`: Freezed immutable model with 4 fields
- ✅ `TransactionModel`: Freezed immutable model with 6 fields
- ✅ Status: **READY - All existing models can be reused**

---

## 2. API Endpoint Specification

### Portfolio Price Endpoint

**Endpoint URL**:
```
GET /simple/price
```

**Base URL Update**:
```dart
// Current (INCORRECT):
const String baseUrl = 'https://api.coingecko.com/api/';

// Should be:
const String baseUrl = 'https://api.coingecko.com/api/v3/';
```

**Query Parameters**:
| Parameter | Type | Value | Description |
|-----------|------|-------|-------------|
| `ids` | String | `bitcoin,ethereum,litecoin` | Comma-separated coin IDs |
| `vs_currencies` | String | `usd` | Target currency |
| `include_24hr_change` | Boolean | `true` | Include 24-hour price change |

**Full Request URL**:
```
https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,litecoin&vs_currencies=usd&include_24hr_change=true
```

**Expected Response**:
```json
{
  "bitcoin": {
    "usd": 42500.50,
    "usd_24h_change": 2.35
  },
  "ethereum": {
    "usd": 2250.75,
    "usd_24h_change": -1.20
  },
  "litecoin": {
    "usd": 95.30,
    "usd_24h_change": 0.50
  }
}
```

**Rate Limits**: CoinGecko free tier (10-50 calls/minute)

---

## 3. Implementation Phases

### Phase 1: API Configuration & Models

#### Step 1.1: Update ApiService Base URL
**File**: `lib/core/service/api/api_service.dart`

```dart
// Change line 6:
const String baseUrl = 'https://api.coingecko.com/api/v3/';
```

#### Step 1.2: Create CoinGeckoPrice Model
**File**: `lib/features/portfolio/data/models/coingecko_price_response.dart` (NEW)

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coingecko_price_response.freezed.dart';

/// API response model for CoinGecko price data
@freezed
class CoinGeckoPriceResponse with _$CoinGeckoPriceResponse {
  const factory CoinGeckoPriceResponse({
    required Map<String, CoinPriceData> data,
  }) = _CoinGeckoPriceResponse;
}

/// Individual coin price data from API
@freezed
class CoinPriceData with _$CoinPriceData {
  const factory CoinPriceData({
    required double usd,
    @JsonKey(name: 'usd_24h_change') required double usd24hChange,
  }) = _CoinPriceData;
}
```

#### Step 1.3: Add Portfolio Price Endpoint to ApiService
**File**: `lib/core/service/api/api_service.dart`

```dart
@GET('simple/price')
Future<Map<String, dynamic>> getHoldingsPrices({
  @Query('ids') required String coinIds,        // bitcoin,ethereum,litecoin
  @Query('vs_currencies') String currency = 'usd',
  @Query('include_24hr_change') bool include24h = true,
});
```

---

### Phase 2: Data Layer (Repository Pattern)

#### Step 2.1: Create PortfolioRepository
**File**: `lib/features/portfolio/data/repository/portfolio_repository.dart` (NEW)

**Responsibilities**:
- Call ApiService with held coin IDs
- Parse JSON response to models
- Calculate portfolio totals and percentages
- Handle network errors gracefully
- Provide data to BLoC/Cubit layer

**Key Methods**:
```dart
Future<List<HoldingModel>> fetchHoldings({
  required List<String> coinIds,
  required Map<String, double> coinAmounts,
}) // Fetch prices and map to HoldingModel

Future<PortfolioModel> calculatePortfolioSummary({
  required List<HoldingModel> holdings,
})  // Calculate total value and changes
```

---

### Phase 3: State Management (BLoC Pattern)

#### Step 3.1: Create PortfolioCubit
**File**: `lib/features/portfolio/presentation/cubit/portfolio_cubit.dart` (NEW)

**States to Define**:
```dart
abstract class PortfolioState {}

class PortfolioInitial extends PortfolioState {}

class PortfolioLoading extends PortfolioState {}

class PortfolioLoaded extends PortfolioState {
  final PortfolioModel portfolioSummary;
  final List<HoldingModel> holdings;
  PortfolioLoaded({
    required this.portfolioSummary,
    required this.holdings,
  });
}

class PortfolioError extends PortfolioState {
  final String message;
  PortfolioError(this.message);
}
```

**Methods**:
```dart
// Load portfolio data from API
Future<void> loadPortfolio()

// Refresh portfolio (for pull-to-refresh)
Future<void> refreshPortfolio()

// Handle network and parsing errors
void _handleError(dynamic error)
```

---

### Phase 4: Presentation Layer (UI Integration)

#### Step 4.1: Update PortfolioScreen with BLoC
**File**: `lib/features/portfolio/presentation/pages/portfolio_screen.dart`

**Changes**:
```dart
// Wrap with BlocProvider
BlocProvider<PortfolioCubit>(
  create: (context) => PortfolioCubit(repository)..loadPortfolio(),
  child: PortfolioScreenContent(),
)

// Use BlocBuilder for state management
BlocBuilder<PortfolioCubit, PortfolioState>(
  builder: (context, state) {
    if (state is PortfolioLoading) {
      return CircularProgressIndicator();
    } else if (state is PortfolioLoaded) {
      // Display real data from state.holdings, state.portfolioSummary
    } else if (state is PortfolioError) {
      return ErrorWidget(message: state.message);
    }
    return SizedBox.shrink();
  },
)
```

#### Step 4.2: Update Individual Widgets
- Remove hardcoded placeholder data
- Bind to real API data
- Keep error handling graceful

---

## 4. Dependency Injection Setup

**File**: `lib/core/di/injection.dart`

```dart
void _initCore() {
  final dio = DioFactory.getDio();

  // Theme services
  sl.registerLazySingleton<ThemeStorageService>(() => ThemeStorageService());
  sl.registerFactory<ThemeCubit>(() => ThemeCubit(sl()));

  // API Service - UNCOMMENT AND UPDATE:
  sl.registerLazySingleton<ApiService>(() => ApiService(dio));

  // Portfolio Repository
  sl.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepository(sl<ApiService>()),
  );

  // Portfolio Cubit
  sl.registerFactory<PortfolioCubit>(
    () => PortfolioCubit(sl<PortfolioRepository>()),
  );
}
```

---

## 5. Data Flow Diagram

```
API Request (CoinGecko)
        ↓
   DioFactory (HTTP)
        ↓
   ApiService (Retrofit)
        ↓
PortfolioRepository (Parse & Map)
        ↓
PortfolioCubit (State Management)
        ↓
PortfolioScreen (BlocBuilder)
        ↓
     UI Widgets
```

---

## 6. Files to Create

### New Files (6 files)

| File | Purpose | Lines |
|------|---------|-------|
| `coingecko_price_response.dart` | Freezed model for API response | ~25 |
| `coingecko_price_response.freezed.dart` | Generated code (auto) | Auto |
| `portfolio_repository.dart` | Data layer logic | ~80 |
| `portfolio_cubit.dart` | State management (Cubit) | ~120 |
| `portfolio_state.dart` | Cubit state definitions | ~50 |
| `.env` (optional) | API base URL config (if needed) | - |

### Files to Modify (3 files)

| File | Change | Lines |
|------|--------|-------|
| `api_service.dart` | Add endpoint, update base URL | +5 |
| `injection.dart` | Register ApiService & PortfolioCubit | +8 |
| `portfolio_screen.dart` | Integrate BLoC, remove mock data | ~30 |

---

## 7. Quality Checklist

### Code Quality
- [ ] flutter analyze: 0 errors, 0 new warnings
- [ ] All new widgets under 100 lines
- [ ] Clean architecture followed
- [ ] SOLID principles applied
- [ ] Comments on complex logic only

### Testing
- [ ] ApiService endpoint works in Postman
- [ ] DioFactory timeouts working
- [ ] Error handling tested (offline mode)
- [ ] BLoC state transitions verified
- [ ] UI displays loading/error/success states

### Integration
- [ ] ApiService registered in DI
- [ ] PortfolioRepository registered
- [ ] PortfolioCubit registered
- [ ] PortfolioScreen uses BLoC
- [ ] Navigation still works

### Documentation
- [ ] README.md updated
- [ ] PROJECT_SUMMARY.md updated
- [ ] PROJECT_REQUIREMENTS.md updated
- [ ] tasks/todo.md updated

---

## 8. What You Need to Provide

### ⏳ Waiting for Your Input

1. **Test API Endpoint in Postman**
   - [ ] Create collection for Portfolio endpoint
   - [ ] Test with coins: bitcoin, ethereum, litecoin
   - [ ] Send screenshot showing request & response
   - [ ] Verify all parameters are correct

2. **Confirm Coin Holdings**
   - [ ] Which coins does user hold?
   - [ ] How many of each coin?
   - Example:
     ```
     Bitcoin: 0.05 BTC
     Ethereum: 1.5 ETH
     Litecoin: 26.3 LTC
     ```

3. **Validate Infrastructure**
   - [ ] Does DioFactory look correct?
   - [ ] Is ApiService setup ok?
   - [ ] Any modifications needed?

---

## 9. Implementation Workflow

### Step-by-Step

1. ✅ **You**: Test API in Postman, send request
2. ✅ **You**: Provide coin holdings data
3. ✅ **You**: Approve this plan
4. ⏳ **Me**: Create feature/portfolio-api branch
5. ⏳ **Me**: Implement Phase 1 (Models + ApiService)
6. ⏳ **Me**: Implement Phase 2 (Repository)
7. ⏳ **Me**: Implement Phase 3 (Cubit)
8. ⏳ **Me**: Implement Phase 4 (PortfolioScreen)
9. ⏳ **Me**: Test & validate everything
10. ⏳ **Me**: Update documentation
11. ⏳ **Me**: Commit & push
12. ⏳ **Me**: Create PR for review

---

## 10. Success Criteria

✅ **Functionality**:
- [ ] PortfolioScreen loads real API data on startup
- [ ] Loading spinner shows during fetch
- [ ] Error message shows if API fails
- [ ] Data updates on pull-to-refresh
- [ ] Portfolio calculations correct

✅ **Code Quality**:
- [ ] flutter analyze: 0 errors
- [ ] 0 new warnings in portfolio feature
- [ ] All files follow clean architecture
- [ ] Comments only on complex logic

✅ **Testing**:
- [ ] Tested on emulator/device
- [ ] Error scenarios handled gracefully
- [ ] Offline mode shows error message
- [ ] Data persists after screen rotation

✅ **Documentation**:
- [ ] All .md files updated
- [ ] Code has class-level docstrings
- [ ] README reflects new feature

---

## 11. Summary

### What We Have ✅
- DioFactory: Configured & ready
- ApiService: Retrofit setup complete
- Models: HoldingModel & PortfolioModel exist
- DI: Ready to register ApiService

### What We Need to Do ⏳
- Update ApiService base URL
- Create CoinGeckoPriceResponse model
- Create PortfolioRepository
- Create PortfolioCubit with states
- Integrate BLoC into PortfolioScreen
- Test everything

### Your Input Needed ✅
1. Test API endpoint in Postman
2. Provide coin holdings information
3. Approve this plan
4. Review DioFactory & ApiService

---

## 📝 Next Steps

**Please**:
1. Review this entire plan carefully
2. Test the endpoint in Postman with your actual coin data
3. Send me the Postman request screenshot
4. Confirm DioFactory and ApiService look correct
5. Provide approval to proceed

**Once approved, I will**:
1. Create feature/portfolio-api branch
2. Implement all code following this plan
3. Test everything thoroughly
4. Update documentation
5. Push and create PR

---

**Status**: ⏳ Waiting for your Postman test & approval
**Estimated Implementation Time**: 2-3 hours
**Complexity**: Medium (requires BLoC integration)

