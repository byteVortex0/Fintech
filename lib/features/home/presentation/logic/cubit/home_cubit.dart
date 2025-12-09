import 'package:fintech/core/service/api/error/api_result.dart';
import 'package:fintech/features/home/data/models/home_screen_response.dart';
import 'package:fintech/features/home/data/repo/home_screen_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../settings/data/models/user_profile_model.dart';
import '../../../../settings/data/repository/settings_repository.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeScreenRepo, this._repository)
    : super(const HomeState.loading());

  final HomeScreenRepo homeScreenRepo;
  final SettingsRepository _repository;

  Future<void> getHomeScreen() async {
    emit(const HomeState.loading());

    try {
      final dataFuture = homeScreenRepo.getHomeScreen();
      final userFuture = _repository.getUserProfile();

      final result = await dataFuture;

      result.when(
        success: (data) async {
          final userProfile = await userFuture;
          if (!isClosed) {
            emit(HomeState.loaded(data: data, userProfile: userProfile));
          }
        },
        failure: (error) {
          if (!isClosed) emit(HomeState.error(message: error.message));
        },
      );
    } catch (e) {
      if (!isClosed) emit(HomeState.error(message: e.toString()));
    }
  }
}
