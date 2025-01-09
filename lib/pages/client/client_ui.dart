

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investmentapp/pages/client/client_bloc.dart';
import 'package:investmentapp/repository/models/client.dart';
import 'package:investmentapp/repository/repository.dart';

class ClientUi extends StatelessWidget {

  final Client _client;

  const ClientUi(this._client, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClientBloc>(
      create: (context) => ClientBloc(context.read<Repository>())..add(FetchClient(client: _client)),
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
                    title: Text(_client.name),
                  ),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(_client.name),
                      ],
                    ),
                  ),
                );
            }
          },
        )
      ),
    );
  }
}
