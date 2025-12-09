import 'package:fintech/features/coin_details/data/models/coins_chart_request.dart';
import 'package:fintech/features/coin_details/data/models/coins_chart_respose.dart';

import '../../../../core/service/api/error/api_result.dart';
import '../models/coin_details_model.dart';

abstract class CoinDetailsRepo {
  Future<ApiResult<CoinsChartResponse>> getChartCoin(CoinsChartRequest request);

  Future<ApiResult<CoinDetailsModel>> getCoinDetails(String id);
}
