import 'package:blockchain_new/app/presentation/modules/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeLoaded extends StatelessWidget {
  const HomeLoaded({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = context.watch<HomeBloc>();
    final state = bloc.state;

    return state.maybeMap(
      orElse: () => SizedBox(),
      loaded: (state) {
        final cryptos = state.cryptos;
        return ListView.builder(
          itemCount: cryptos.length,
          itemBuilder: (context, index) {
            final crypto = cryptos[index];
            return ListTile(
              title: Text(crypto.symbol),
              subtitle: Text(crypto.price.toString()),
            );
          },
        );
      },
    );
  }
}
