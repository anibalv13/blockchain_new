import 'package:blockchain_new/app/domain/failures/http_request_failure.dart';
import 'package:blockchain_new/app/presentation/modules/home/bloc/home_bloc.dart';
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
          body: bloc.state.when(
            loading: () => Center(
              child: CircularProgressIndicator(),
            ),
            failed: (failure) {
              /* final message = failure.when(
                network: () => 'Network error',
                notFound: () => 'Not found',
                server: () => 'Server error',
                unauthorized: () => 'Unauthorized',
                badRequest: () => 'Bad request',
                local: () => 'Local error',
              ); */
              /* final message = failure.maybeWhen(
                network: () => 'Network error',
                notFound: () => 'Not found',
                orElse: () => 'internalError error',
              ); */
              final message = failure.whenOrNull(
                network: () => 'Network error',
                notFound: () => 'Not found',
              );

              return Center(
                child: Text(message ?? 'internalError error'),
              );
            },
            loaded: (cryptos) => ListView.builder(
              itemCount: cryptos.length,
              itemBuilder: (context, index) {
                final crypto = cryptos[index];
                return ListTile(
                  title: Text(crypto.symbol),
                  subtitle: Text(crypto.price.toString()),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
