import 'package:blockchain_new/app/presentation/modules/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

const colors = <String, Color>{
  'BTC': Color(0xfff7931a),
  'ETH': Color(0xff627eea),
  'USDT': Color(0xff26a17b),
  'BNB': Color(0xfff3b549),
  'XMR': Color(0xfff37434),
  'LTC': Color(0xff345d9d),
  'USDC': Color(0xff2775ca),
  'DOGE': Color(0xffc3a634),
};

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
          padding: const EdgeInsets.all(6.0),
          itemCount: cryptos.length,
          itemBuilder: (context, index) {
            final crypto = cryptos[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: Colors.white,
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/${crypto.symbol}.svg',
                      width: 30,
                      height: 30,
                      colorFilter: colors[crypto.symbol] != null
                          ? ColorFilter.mode(
                              colors[crypto.symbol]!, BlendMode.srcIn)
                          : null,
                    ),
                  ],
                ),
                title: Text(
                  crypto.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  crypto.symbol,
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      NumberFormat.currency(name: '\$').format(crypto.price),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${crypto.changePercent24Hr.toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: crypto.changePercent24Hr.isNegative
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
