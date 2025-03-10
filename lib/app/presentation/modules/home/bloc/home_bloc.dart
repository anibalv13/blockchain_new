import 'dart:async';
import 'package:blockchain_new/app/domain/models/ws_status/ws_status.dart';
import 'package:blockchain_new/app/domain/repositories/exchange_repository.dart';
import 'package:blockchain_new/app/domain/repositories/ws_repository.dart';
import 'package:blockchain_new/app/presentation/modules/home/bloc/home_state.dart';
import 'package:flutter/material.dart';

class HomeBloc extends ChangeNotifier {
  HomeBloc({
    required this.exchangeRepository,
    required this.wsRepository,
  });
  final ExchangeRepository exchangeRepository;
  final WsRepository wsRepository;

  StreamSubscription? _pricesSubscription, _wsSubscription;

  HomeState _state = HomeState.loading();

  HomeState get state => _state;

  final _ids = [
    'bitcoin',
    'ethereum',
    'tether',
    'binance-coin',
    'monero',
    'litecoin',
    'usd-coin',
    'dogecoin',
  ];

  Future<void> init() async {
    state.maybeWhen(
      loading: () {},
      orElse: () {
        _state = HomeState.loading();
        notifyListeners();
      },
    );

    final result = await exchangeRepository.getPrices(_ids);

    _state = result.when(
      left: (failure) => HomeState.failed(failure),
      right: (cryptos) {
        startPricesListening();
        return HomeState.loaded(cryptos: cryptos);
      },
    );

    notifyListeners();
  }

  Future<bool> startPricesListening() async {
    final connected = await wsRepository.connect(_ids);

    state.mapOrNull(
      loaded: (state) {
        if (connected) {
          _onPricesChanged();
        }
        _state = state.copyWith(
          wsStatus: connected ? WsStatus.connected() : WsStatus.failed(),
        );
        notifyListeners();
      },
    );

    return connected;
  }

  void _onPricesChanged() {
    _pricesSubscription?.cancel();
    _wsSubscription?.cancel();
    _pricesSubscription = wsRepository.onPricesChanged.listen(
      (changes) {
        state.mapOrNull(
          loaded: (state) {
            // final cryptos = List<Crypto>.from(state.cryptos);
            final keys = changes.keys;

            _state = state.copyWith(
              cryptos: [
                ...state.cryptos.map(
                  (crypto) {
                    if (keys.contains(crypto.id)) {
                      return crypto.copyWith(
                        price: changes[crypto.id]!,
                      );
                    }
                    return crypto;
                  },
                )
              ],
            );
            notifyListeners();
          },
        );
      },
    );

    _wsSubscription = wsRepository.onStatusChanged.listen((status) {
      state.mapOrNull(
        loaded: (state) {
          _state = state.copyWith(
            wsStatus: status,
          );
          notifyListeners();
        },
      );
    });
  }

  @override
  void dispose() {
    _pricesSubscription?.cancel();
    _wsSubscription?.cancel();
    super.dispose();
  }
}
