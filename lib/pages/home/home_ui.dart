

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investmentapp/pages/assets/assets_ui.dart';
import 'package:investmentapp/pages/clients/clients_ui.dart';
import 'package:investmentapp/pages/home/home_bloc.dart';
import 'package:investmentapp/widgets/investment_scaffold.dart';

/*
class HomeUi extends StatefulWidget {
  const HomeUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Builder(
        builder: (context) => BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Home'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Home',
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: NavigationBar(
                onDestinationSelected: (int index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                destinations: [
                  NavigationDestination(
                    selectedIcon: Icon(Icons.home),
                    icon: Icon(Icons.home_outlined),
                    label: 'Home',
                  ),
                ],


              ),
            );
          }
        )
      )
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
*/

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: _pages[_index],
          ),
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
          //indicatorColor: Colors.amber,
          selectedIndex: _index,
        ),
      ),
    );
  }
}
