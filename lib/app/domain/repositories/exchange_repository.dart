import 'package:blockchain_new/app/domain/either/either.dart';
import 'package:blockchain_new/app/domain/failures/http_request_failure.dart';
import 'package:blockchain_new/app/domain/models/crypto/crypto.dart';

typedef GetpricesFuture = Future<Either<HttpRequestFailure, List<Crypto>>>;

abstract class ExchangeRepository {
  GetpricesFuture getPrices(List<String> ids);
}
