import 'package:flutter/material.dart';
import 'package:investmentapp/features/assets/presentation/pages/assets_page.dart';
import 'package:investmentapp/features/clients/presentation/pages/clients_page.dart';
import 'package:investmentapp/widgets/invest_nest_padding.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  final List<Widget> _pages = [
    const ClientsPage(),
    const AssetsPage(),
  ];

  final List<String> _titles = [
    'Clients',
    'Assets',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
      ),
      body: SafeArea(
        child: InvestNestPadding(
          child: _pages[_index],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: NavigationBar(
          onDestinationSelected: (int newIndex) {
            setState(() {
              _index = newIndex;
            });
          },
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.people),
              icon: Icon(Icons.people_outline),
              key: ValueKey('ClientsKey'),
              label: 'Clients',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.assessment),
              icon: Icon(Icons.assessment_rounded),
              key: ValueKey('AssetsKey'),
              label: 'Assets',
            ),
          ],
          selectedIndex: _index,
        ),
      ),
    );
  }
}
