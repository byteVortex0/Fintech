import 'dart:developer';
import '../../../../core/service/api/error/api_result.dart';
import '../../../../core/service/api/error/error_handler.dart';
import '../models/coins_chart_request.dart';
import '../models/coins_chart_respose.dart';

import '../../../../core/service/api/api_service.dart';
import '../mappers/coin_details_mapper.dart';
import '../models/coin_details_model.dart';
import 'coin_details_repo.dart';

class CoinDetailsRepoImpl implements CoinDetailsRepo {
  final ApiService apiService;

  CoinDetailsRepoImpl(this.apiService);

  @override
  Future<ApiResult<CoinDetailsModel>> getCoinDetails(String id) async {
    try {
      log('[CoinDetailsRepoImpl] getCoinDetails called with id: $id');
      final coinDetailsResponse = await apiService.getCoinDetails(id);

      final coinDetails = CoinDetailsMapper.fromRemote(coinDetailsResponse);

      log('[CoinDetailsRepoImpl] getCoinDetails SUCCESS');
      return Success(coinDetails);
    } catch (e) {
      log('[CoinDetailsRepoImpl] getCoinDetails ERROR: $e');
      final failure = await ErrorHandler.handle(e);
      log('[CoinDetailsRepoImpl] ErrorHandler returned: ${failure.errorModel.userMessage}');
      return Failure(failure.errorModel);
    }
  }

  @override
  Future<ApiResult<CoinsChartResponse>> getChartCoin(CoinsChartRequest request) async {
    try {
      log('[CoinDetailsRepoImpl] getChartCoin called for ${request.id}, days: ${request.days}');
      final chartResponse = await apiService.chartCoin(
        request.id,
        request.vsCurrency,
        request.days,
      );

      log('[CoinDetailsRepoImpl] getChartCoin SUCCESS');
      return Success(chartResponse);
    } catch (e) {
      log('[CoinDetailsRepoImpl] getChartCoin ERROR: $e');
      final failure = await ErrorHandler.handle(e);
      log('[CoinDetailsRepoImpl] ErrorHandler returned: ${failure.errorModel.userMessage}');
      return Failure(failure.errorModel);
    }
  }
}
