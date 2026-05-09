import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:investmentapp/features/assets/domain/entities/asset.dart';
import 'package:investmentapp/features/assets/presentation/pages/asset_detail_page.dart';
import 'package:investmentapp/features/clients/domain/entities/client.dart';
import 'package:investmentapp/features/clients/presentation/pages/client_detail_page.dart';
import 'package:investmentapp/features/home/presentation/pages/home_page.dart';
import 'package:investmentapp/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const InvestmentApp());
}

class InvestmentApp extends StatelessWidget {
  const InvestmentApp({super.key});

  static final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'client',
            builder: (context, state) => ClientDetailPage(state.extra as Client),
          ),
          GoRoute(
            path: 'asset',
            builder: (context, state) => AssetDetailPage(state.extra as Asset),
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Invest Nest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Quicksand',
        scaffoldBackgroundColor: CupertinoColors.lightBackgroundGray,
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.deepPurple.shade400,
          shadowColor: Colors.transparent,
          indicatorColor: Colors.green.shade400,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          iconTheme: WidgetStateProperty.all(
            const IconThemeData(
              color: Colors.white,
            ),
          ),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(
              color: Colors.white,
              fontFamily: 'Quicksand',
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(fontSize: 22, color: Colors.black, fontFamily: 'Quicksand'),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}
