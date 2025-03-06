import 'package:blockchain_new/app/data/repositories_impl/exchange_repository_impl.dart';
import 'package:blockchain_new/app/data/services/remote/exchage_api.dart';
import 'package:blockchain_new/app/domain/repositories/exchange_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'app/my_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<ExchangeRepository>(
          create: (_) => ExchangeRepositoryImpl(
            ExchangeAPI(
              Client(),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
