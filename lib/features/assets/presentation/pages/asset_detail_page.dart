import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:investmentapp/features/assets/domain/entities/asset.dart';
import 'package:investmentapp/features/assets/presentation/bloc/asset_detail/asset_detail_bloc.dart';
import 'package:investmentapp/injection_container.dart';
import 'package:investmentapp/shared/services/image_service.dart';
import 'package:investmentapp/widgets/heading.dart';
import 'package:investmentapp/widgets/info_card.dart';
import 'package:investmentapp/widgets/invest_nest_padding.dart';
import 'package:investmentapp/widgets/rounded_card.dart';

class AssetDetailPage extends StatelessWidget {
  final Asset asset;

  const AssetDetailPage(this.asset, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AssetDetailBloc>(
      create: (_) => sl<AssetDetailBloc>()..add(AssetDetailFetchRequested(asset.isin)),
      child: Builder(
        builder: (context) => BlocBuilder<AssetDetailBloc, AssetDetailState>(
          builder: (context, state) {
            switch (state) {
              case AssetDetailInitial():
                return const SizedBox.shrink();
              case AssetDetailLoading():
                return const CircularProgressIndicator();
              case AssetDetailError():
                return const Center(child: Text('Something went wrong'));
              case AssetDetailLoaded():
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Asset'),
                  ),
                  body: InvestNestPadding(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RoundedCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: sl<ImageService>().getImage(asset.imageUri),
                                radius: 60,
                              ),
                              Text(asset.name),
                              Text('Risk Level: ${asset.riskRating}'),
                            ],
                          ),
                        ),
                        const Heading(text: 'Clients'),
                        for (final entry in state.clients.entries)
                          InfoCard(
                            topText: Text(entry.key.name),
                            bottomText: Text('Portfolio: ${entry.value}%'),
                            image: sl<ImageService>().getImage(entry.key.imageUri),
                            onTapped: () => GoRouter.of(context).go('/client/${entry.key.uuid}', extra: entry.key),
                          ),
                      ],
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
