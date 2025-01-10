

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investmentapp/pages/client/client_bloc.dart';
import 'package:investmentapp/repository/image_repository.dart';
import 'package:investmentapp/repository/models/asset.dart';
import 'package:investmentapp/repository/models/client.dart';
import 'package:investmentapp/repository/repository.dart';
import 'package:investmentapp/utils/utils.dart';
import 'package:investmentapp/widgets/heading.dart';
import 'package:investmentapp/widgets/info_card.dart';
import 'package:investmentapp/widgets/rounded_card.dart';

class ClientUi extends StatefulWidget {

  final Client _client;

  const ClientUi(this._client, {super.key});

  @override
  State<ClientUi> createState() => _ClientUiState();
}

class _ClientUiState extends State<ClientUi> {

  int? _touchedIndex = null;


  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClientBloc>(
      create: (context) => ClientBloc(context.read<Repository>())..add(FetchAssets(client: widget._client)),
      child: Builder(
          builder: (context) => BlocBuilder<ClientBloc, ClientState>(
            builder: (context, state) {
              switch(state) {
                case ClientInitial():
                  return const SizedBox.shrink();
                case ClientLoading():
                  return const CircularProgressIndicator();
                case ClientReady():
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(widget._client.name),
                    ),
                    body: SafeArea(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Heading(text: 'Profile'),
                              RoundedCard(
                                child: Column(
                                  children: [
                                    CircleAvatar(backgroundImage: context.read<ImageRepository>().getImage(widget._client.imageUri), radius: 60),
                                    Text('Portfolio Value: ${toSterling(widget._client.portfolioValue)}'),
                                    Text('Risk Strategy: Low'),
                                    // Text('Investment Strategy: ${_client.investmentStrategy}'),
                                  ],
                                )
                              ),
                              Heading(text: 'Investment Breakdown'),
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
                                              if (index == _touchedIndex) {
                                                _touchedIndex = null;
                                              } else {
                                                _touchedIndex = index;
                                              }
                                            });
                                          }
                                        }
                                      ),
                                      sectionsSpace: 10,
                                      centerSpaceRadius: 50,
                                      sections: _getSections(state.assets),
                                    ),
                                  ),
                                )
                              ),
                              for(var (index, investment) in state.assets.entries.indexed)
                                InfoCard(
                                  topText: Text(investment.key.name,),
                                  bottomText: Text("${investment.value.toString()}%", style: TextStyle(fontWeight: FontWeight.bold),),
                                  image: context.read<ImageRepository>().getImage(investment.key.imageUri),
                                  isGrey: _touchedIndex != null && _touchedIndex != -1 && index != _touchedIndex,
                                  onTapped: () {
                                    setState(() {
                                      if (index == _touchedIndex) {
                                        _touchedIndex = null;
                                      } else {
                                        _touchedIndex = index;
                                      }
                                    });
                                  },
                                  showArrow: false,
                                )
                            ],
                          ),
                        )
                      )
                    ),
                  );
              }
            },
          )
      ),
    );
  }


  static const _colours = [Colors.blue, Colors.yellow, Colors.purple,
    Colors.green, Colors.amber, Colors.red, Colors.pink, Colors.teal,
    Colors.orange, Colors.indigo, Colors.cyan, Colors.brown, Colors.grey,
    Colors.lime, Colors.deepOrange, Colors.deepPurple, Colors.lightBlue,
    Colors.lightGreen, Colors.blueGrey, Colors.black, Colors.white
  ];

  List<PieChartSectionData> _getSections(Map<Asset, int> assets) {
    return assets.entries.mapIndexed((index, entry) {
      final isTouched = index == _touchedIndex;
      final radius = isTouched ? 60.0 : 50.0;
      return PieChartSectionData(
        color: _colours[index % _colours.length],
        value: entry.value.toDouble(),
        title: "${entry.value}%",
        radius: radius,
        titleStyle: TextStyle(
          fontSize: 16,
        ),
      );
    }).toList();
  }
}
