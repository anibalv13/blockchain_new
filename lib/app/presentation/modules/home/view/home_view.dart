import 'package:blockchain_new/app/presentation/modules/home/bloc/home_bloc.dart';
import 'package:blockchain_new/app/presentation/modules/home/view/widgets/appbar.dart';
import 'package:blockchain_new/app/presentation/modules/home/view/widgets/error.dart';
import 'package:blockchain_new/app/presentation/modules/home/view/widgets/loaded.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeBloc(
        exchangeRepository: context.read(),
        wsRepository: context.read(),
      )..init(),
      builder: (context, _) {
        final HomeBloc bloc = context.watch<HomeBloc>();

        return Scaffold(
          appBar: HomeAppBar(),
          body: bloc.state.when(
            loading: () => Center(
              child: CircularProgressIndicator(),
            ),
            failed: (_) => HomeError(),
            loaded: (cryptos, _) => HomeLoaded(),
          ),
        );
      },
    );
  }
}
