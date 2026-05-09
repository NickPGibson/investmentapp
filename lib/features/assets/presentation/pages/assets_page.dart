import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:investmentapp/features/assets/presentation/bloc/assets/assets_bloc.dart';
import 'package:investmentapp/injection_container.dart';
import 'package:investmentapp/shared/services/image_service.dart';
import 'package:investmentapp/widgets/info_card.dart';

class AssetsPage extends StatelessWidget {
  const AssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AssetsBloc>(
      create: (_) => sl<AssetsBloc>()..add(const AssetsFetchRequested()),
      child: Builder(
        builder: (context) => BlocBuilder<AssetsBloc, AssetsState>(
          builder: (context, state) {
            switch (state) {
              case AssetsInitial():
                return const SizedBox.shrink();
              case AssetsLoading():
                return const CircularProgressIndicator();
              case AssetsError():
                return const Center(child: Text('Something went wrong'));
              case AssetsLoaded():
                final assets = state.assets;
                return ListView.builder(
                  itemCount: assets.length,
                  itemBuilder: (context, index) {
                    final asset = assets[index];
                    return InfoCard(
                      image: sl<ImageService>().getImage(asset.imageUri),
                      topText: Text(asset.name),
                      onTapped: () => GoRouter.of(context).go('/asset/${asset.isin}', extra: asset),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
