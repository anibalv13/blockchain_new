import 'package:blockchain_new/app/presentation/modules/home/bloc/home_bloc.dart';
import 'package:blockchain_new/app/presentation/modules/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeBloc(
        exchangeRepository: context.read(),
      )..init(),
      builder: (context, _) {
        final HomeBloc bloc = context.watch<HomeBloc>();

        return Scaffold(
          body: () {
            final state = bloc.state;
            if (state is HomeStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeStateLoaded) {
              return ListView.builder(
                itemCount: state.cryptos.length,
                itemBuilder: (_, index) {
                  final crypto = state.cryptos[index];
                  return ListTile(
                    title: Text(crypto.id),
                    subtitle: Text(crypto.price.toString()),
                  );
                },
              );
            }
            return const Center(
              child: Text('Failed to load cryptos'),
            );
          }(),
        );
      },
    );
  }
}
