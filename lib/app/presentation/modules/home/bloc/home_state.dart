import 'package:blockchain_new/app/domain/models/crypto/crypto.dart';

abstract class HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateFailed extends HomeState {}

class HomeStateLoaded extends HomeState {
  final List<Crypto> cryptos;

  HomeStateLoaded(this.cryptos);
}
