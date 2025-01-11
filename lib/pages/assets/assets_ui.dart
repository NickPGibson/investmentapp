
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:investmentapp/pages/assets/assets_bloc.dart';
import 'package:investmentapp/repository/image_repository.dart';
import 'package:investmentapp/repository/repository.dart';
import 'package:investmentapp/widgets/info_card.dart';

class AssetsUi extends StatelessWidget {
  const AssetsUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AssetsBloc>(
      create: (context) => AssetsBloc(context.read<Repository>())..add(FetchAssets()),
      child: Builder(
          builder: (context) => BlocBuilder<AssetsBloc, AssetsState>(
            builder: (context, state) {
              switch(state) {
                case AssetsInitial():
                  return const SizedBox.shrink();
                case AssetsLoading():
                  return const CircularProgressIndicator();
                case AssetsLoaded():
                  final assets = state.assets;
                  return ListView.builder(
                    itemCount: assets.length,
                    itemBuilder: (context, index) {
                      final asset = assets[index];
                      return InfoCard(
                        image: context.read<ImageRepository>().getImage(asset.imageUri),
                        topText: Text(asset.name),
                        onTapped: () => GoRouter.of(context).go('/asset', extra: asset)
                      );
                    },
                  );
              }
            },
          )),
    );
  }
}
