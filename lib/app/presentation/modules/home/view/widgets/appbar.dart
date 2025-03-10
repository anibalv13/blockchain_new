import 'package:blockchain_new/app/presentation/modules/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = context.watch<HomeBloc>();
    return AppBar(
      title: bloc.state.whenOrNull(
        loaded: (_, wsStatus) => Text(
          wsStatus.when(
            connecting: () => 'Connecting...',
            connected: () => 'Connected',
            failed: () => 'Failed',
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
