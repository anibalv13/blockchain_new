import 'package:blockchain_new/app/presentation/modules/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeError extends StatelessWidget {
  const HomeError({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = context.watch<HomeBloc>();
    final state = bloc.state;

    return state.maybeWhen(
        orElse: () => SizedBox(),
        failed: (failure) {
          final message = failure.whenOrNull(
            network: () => 'Network error',
            notFound: () => 'Not found',
          );

          if (message == null) {
            return Container();
          }

          return Center(
            child: Text(message),
          );
        });
  }
}
