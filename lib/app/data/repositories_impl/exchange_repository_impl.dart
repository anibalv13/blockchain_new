import 'package:blockchain_new/app/data/services/remote/exchage_api.dart';
import 'package:blockchain_new/app/domain/repositories/exchange_repository.dart';
import 'package:blockchain_new/app/domain/results/get_prices/get_prices_result.dart';

class ExchangeRepositoryImpl implements ExchangeRepository {
  final ExchangeAPI _api;

  ExchangeRepositoryImpl(this._api);
  @override
  Future<GetPricesResult> getPrices(List<String> ids) {
    return _api.getPrices(ids);
  }
}
