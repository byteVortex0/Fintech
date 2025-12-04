import 'package:fintech/core/service/api/error/api_result.dart';

import '../../../../core/service/api/api_service.dart';
import '../../../../core/service/api/error/error_model.dart';
import '../mappers/coin_details_mapper.dart';
import '../models/coin_details_model.dart';

class GetCoinDetailsRepo {
  final ApiService apiService;

  GetCoinDetailsRepo(this.apiService);

  Future<ApiResult<CoinDetailsModel>> getCoinDetails(String id) async {
    try {
      final coinDetailsResponse = await apiService.getCoinDetails(id);

      final coinDetails = CoinDetailsMapper.fromRemote(coinDetailsResponse);

      return Success(coinDetails);
    } catch (e) {
      return Failure(ErrorModel(message: e.toString()));
    }
  }
}
