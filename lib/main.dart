import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:investmentapp/pages/asset/asset_ui.dart';
import 'package:investmentapp/pages/assets/assets_ui.dart';
import 'package:investmentapp/pages/client/client_ui.dart';
import 'package:investmentapp/pages/clients/clients_ui.dart';
import 'package:investmentapp/pages/home/home_ui.dart';
import 'package:investmentapp/repository/models/client.dart';
import 'package:investmentapp/repository/repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const InvestmentApp());
}

class InvestmentApp extends StatelessWidget {
  const InvestmentApp({super.key});

  static final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeUi(),
        routes: [
          GoRoute(
            path: 'client',
            builder: (context, state) => ClientUi(state.extra as Client),
          ),
          GoRoute(
            path: 'asset',
            builder: (context, state) => const AssetUi(),
          ),
        ]
      )
    ]
  );

  @override
  Widget build(BuildContext context) {
    return Provider<Repository>(
      create: (context) => Repository(),
      child: MaterialApp.router(
        title: 'Investment App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
      ),
    );
  }
}