
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investmentapp/pages/assets/assets_bloc.dart';

class AssetsUi extends StatelessWidget {
  const AssetsUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AssetsBloc>(
      create: (context) => AssetsBloc(),
      child: Builder(
          builder: (context) => BlocBuilder<AssetsBloc, AssetsState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Assets',
                  ),
                ],
              );
            },
          )),
    );
  }
}
