

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investmentapp/pages/assets/assets_ui.dart';
import 'package:investmentapp/pages/clients/clients_ui.dart';
import 'package:investmentapp/pages/home/home_bloc.dart';
import 'package:investmentapp/repository/repository.dart';
import 'package:investmentapp/widgets/invest_nest_padding.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({super.key});

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {

  int _index = 0;

  final List<Widget> _pages = [
    ClientsUi(),
    AssetsUi(),
  ];

  final List<String> _titles = [
    'Clients',
    'Assets',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(context.read<Repository>())..add(InitialiseApp()),
      child: Builder(
        builder: (context) => BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            switch(state) {
              case HomeInitial():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case HomeLoaded():
                return Scaffold(
                  appBar: AppBar(
                    title: Text(_titles[_index]),
                  ),
                  body: SafeArea(
                    child: InvestNestPadding(
                      child: _pages[_index],
                    )
                  ),
                  bottomNavigationBar: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: NavigationBar(
                      onDestinationSelected: (int newIndex) {
                        setState(() {
                          _index = newIndex;
                        });
                      },
                      destinations: [
                        NavigationDestination(
                          selectedIcon: Icon(Icons.people),
                          icon: Icon(Icons.people_outline),
                          label: 'Clients',
                        ),
                        NavigationDestination(
                          selectedIcon: Icon(Icons.assessment),
                          icon: Icon(Icons.assessment_rounded),
                          label: 'Assets',
                        ),
                      ],
                      selectedIndex: _index,
                    ),
                  ),
                );
              case HomeLoading():
                return Center(child: CircularProgressIndicator());
            }
          },
        ),
      )
    );
  }
}
