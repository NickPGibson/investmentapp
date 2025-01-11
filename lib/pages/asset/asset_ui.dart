


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:investmentapp/pages/asset/asset_bloc.dart';
import 'package:investmentapp/repository/image_repository.dart';
import 'package:investmentapp/repository/models/asset.dart';
import 'package:investmentapp/repository/repository.dart';
import 'package:investmentapp/widgets/heading.dart';
import 'package:investmentapp/widgets/info_card.dart';
import 'package:investmentapp/widgets/invest_nest_padding.dart';
import 'package:investmentapp/widgets/rounded_card.dart';

class AssetUi extends StatelessWidget {

  final Asset _asset;

  const AssetUi(this._asset, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AssetBloc>(
      create: (context) => AssetBloc(context.read<Repository>())..add(FetchClients(_asset.isin)),
      child: Builder(
        builder: (context) => BlocBuilder<AssetBloc, AssetState>(
          builder: (context, state) {
            switch(state) {
              case AssetInitial():
                return const SizedBox.shrink();
              case AssetLoading():
                return const CircularProgressIndicator();
              case AssetLoaded():
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Asset'),
                  ),
                  body: InvestNestPadding(child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        RoundedCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(backgroundImage: context.read<ImageRepository>().getImage(_asset.imageUri), radius: 60),
                              Text(_asset.name),
                              Text('Risk Level: ${_asset.riskRating}'),
                            ],
                          )
                        ),
                        Heading(text: 'Clients'),
                        for (final entry in state.clients.entries)
                          InfoCard(
                            topText: Text(entry.key.name),
                            bottomText: Text("Portfolio: ${entry.value}%"),
                            image: context.read<ImageRepository>().getImage(entry.key.imageUri),
                            onTapped: () => GoRouter.of(context).go('/client', extra: entry.key)
                          ),
                      ],
                    ),
                  )
                );
            }
          },
        )),
    );
  }
}
