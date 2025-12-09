import 'package:fintech/core/service/api/error/api_result.dart';
import 'package:fintech/features/home/data/models/home_screen_response.dart';
import 'package:fintech/features/home/data/repo/home_screen_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_screen_state.dart';
part 'home_screen_cubit.freezed.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit(this.homeScreenRepo) : super(const HomeScreenState.loading());

  final HomeScreenRepo homeScreenRepo;

  Future<void> getHomeScreen() async {
    emit(const HomeScreenState.loading());

    final result = await homeScreenRepo.getHomeScreen();

    result.when(
      success: (data) {
        emit(HomeScreenState.loaded(data: data));
      },
      failure: (error) {
        emit(HomeScreenState.error(message: error.message));
      },
    );
  }
}
