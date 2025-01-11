import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:investmentapp/pages/asset/asset_ui.dart';
import 'package:investmentapp/pages/client/client_ui.dart';
import 'package:investmentapp/pages/home/home_ui.dart';
import 'package:investmentapp/repository/image_repository.dart';
import 'package:investmentapp/repository/models/asset.dart';
import 'package:investmentapp/repository/models/client.dart';
import 'package:investmentapp/repository/repository.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
            builder: (context, state) => AssetUi(state.extra as Asset),
          ),
        ]
      )
    ]
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Repository>(
          create: (context) => Repository(),
        ),
        Provider<ImageRepository>(
          create: (context) => ImageRepository(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Investment App',
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
              IconThemeData(
                color: Colors.white,
              ),
            ),
            labelTextStyle: WidgetStateProperty.all(
              TextStyle(
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
      ),
    );
  }
}