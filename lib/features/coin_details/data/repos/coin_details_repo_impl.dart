import 'package:fintech/core/service/api/error/api_result.dart';
import 'package:fintech/features/coin_details/data/models/coins_chart_request.dart';
import 'package:fintech/features/coin_details/data/models/coins_chart_respose.dart';

import '../../../../core/service/api/api_service.dart';
import '../../../../core/service/api/error/error_model.dart';
import '../mappers/coin_details_mapper.dart';
import '../models/coin_details_model.dart';
import 'coin_details_repo.dart';

class CoinDetailsRepoImpl implements CoinDetailsRepo {
  final ApiService apiService;

  CoinDetailsRepoImpl(this.apiService);

  @override
  Future<ApiResult<CoinDetailsModel>> getCoinDetails(String id) async {
    try {
      final coinDetailsResponse = await apiService.getCoinDetails(id);

      final coinDetails = CoinDetailsMapper.fromRemote(coinDetailsResponse);

      return Success(coinDetails);
    } catch (e) {
      return Failure(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<CoinsChartResponse>> getChartCoin(
    CoinsChartRequest request,
  ) async {
    try {
      final chartResponse = await apiService.chartCoin(
        request.id,
        request.vsCurrency,
        request.days,
      );

      return Success(chartResponse);
    } catch (e) {
      return Failure(ErrorModel(message: e.toString()));
    }
  }
}
