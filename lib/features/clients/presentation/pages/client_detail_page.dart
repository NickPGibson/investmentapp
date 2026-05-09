import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investmentapp/features/assets/domain/entities/asset.dart';
import 'package:investmentapp/features/clients/domain/entities/client.dart';
import 'package:investmentapp/features/clients/presentation/bloc/client_detail/client_detail_bloc.dart';
import 'package:investmentapp/injection_container.dart';
import 'package:investmentapp/shared/services/image_service.dart';
import 'package:investmentapp/utils/utils.dart';
import 'package:investmentapp/widgets/heading.dart';
import 'package:investmentapp/widgets/info_card.dart';
import 'package:investmentapp/widgets/invest_nest_padding.dart';
import 'package:investmentapp/widgets/rounded_card.dart';

class ClientDetailPage extends StatefulWidget {
  final Client client;

  const ClientDetailPage(this.client, {super.key});

  @override
  State<ClientDetailPage> createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends State<ClientDetailPage> {
  int? _touchedIndex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClientDetailBloc>(
      create: (_) => sl<ClientDetailBloc>()..add(ClientDetailFetchRequested(widget.client.uuid)),
      child: Builder(
        builder: (context) => BlocBuilder<ClientDetailBloc, ClientDetailState>(
          builder: (context, state) {
            switch (state) {
              case ClientDetailInitial():
                return const SizedBox.shrink();
              case ClientDetailLoading():
                return const CircularProgressIndicator();
              case ClientDetailError():
                return const Center(child: Text('Something went wrong'));
              case ClientDetailLoaded():
                return Scaffold(
                  appBar: AppBar(
                    title: Text(widget.client.name),
                  ),
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: InvestNestPadding(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Heading(text: 'Profile'),
                            RoundedCard(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: sl<ImageService>().getImage(widget.client.imageUri),
                                    radius: 60,
                                  ),
                                  Text('Portfolio Value: ${toSterling(widget.client.portfolioValue)}'),
                                  Text('Risk Strategy: ${widget.client.riskStrategy}'),
                                ],
                              ),
                            ),
                            const Heading(text: 'Investment Breakdown'),
                            SizedBox(
                              height: 250,
                              child: RoundedCard(
                                child: PieChart(
                                  PieChartData(
                                    pieTouchData: PieTouchData(
                                      touchCallback: (event, response) {
                                        if (event is FlTapUpEvent) {
                                          final index = response?.touchedSection?.touchedSectionIndex;
                                          setState(() {
                                            _setTouchedIndex(index);
                                          });
                                        }
                                      },
                                    ),
                                    sectionsSpace: 10,
                                    centerSpaceRadius: 50,
                                    sections: _getSections(state.assets),
                                  ),
                                ),
                              ),
                            ),
                            for (var (index, investment) in state.assets.entries.indexed)
                              InfoCard(
                                topText: Text(investment.key.name),
                                bottomText: Text(
                                  '${investment.value.toString()}%',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                image: sl<ImageService>().getImage(investment.key.imageUri),
                                isGrey: _touchedIndex != null && _touchedIndex != -1 && index != _touchedIndex,
                                onTapped: () {
                                  setState(() {
                                    _setTouchedIndex(index);
                                  });
                                },
                                showArrow: false,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  void _setTouchedIndex(int? index) {
    if (index == _touchedIndex) {
      _touchedIndex = null;
    } else {
      _touchedIndex = index;
    }
  }

  static const _colours = [
    Colors.blue, Colors.yellow, Colors.purple, Colors.green, Colors.amber,
    Colors.red, Colors.pink, Colors.teal, Colors.orange, Colors.indigo,
    Colors.cyan, Colors.brown, Colors.grey, Colors.lime, Colors.deepOrange,
    Colors.deepPurple, Colors.lightBlue, Colors.lightGreen, Colors.blueGrey,
    Colors.black, Colors.white,
  ];

  List<PieChartSectionData> _getSections(Map<Asset, int> assets) {
    return assets.entries.mapIndexed((index, entry) {
      final isTouched = index == _touchedIndex;
      final radius = isTouched ? 60.0 : 50.0;
      return PieChartSectionData(
        color: _colours[index % _colours.length],
        value: entry.value.toDouble(),
        title: '${entry.value}%',
        radius: radius,
        titleStyle: const TextStyle(fontSize: 16),
      );
    }).toList();
  }
}
