import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintech/features/settings/data/models/user_profile_model.dart';
import 'package:fintech/features/settings/data/repository/settings_repository.dart';

/// HomeCubit for managing home screen user profile data
/// Handles fetching user profile from repository
class HomeCubit extends Cubit<UserProfileModel?> {
  final SettingsRepository _repository;

  HomeCubit(this._repository) : super(null);

  /// Fetch user profile
  Future<void> fetchUserProfile() async {
    try {
      final userProfile = await _repository.getUserProfile();
      if (!isClosed) {
        emit(userProfile);
      }
    } catch (e) {
      // Silently fail - use default values
      if (!isClosed) {
        emit(null);
      }
    }
  }
}
