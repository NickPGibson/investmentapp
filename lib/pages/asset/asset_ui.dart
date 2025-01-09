


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investmentapp/pages/asset/asset_bloc.dart';

class AssetUi extends StatelessWidget {
  const AssetUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AssetBloc>(
      create: (context) => AssetBloc(),
      child: Builder(
        builder: (context) => BlocBuilder<AssetBloc, AssetState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Asset'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Asset',
                    ),
                  ],
                ),
              ),
            );
          },
        )),
    );
  }
}
