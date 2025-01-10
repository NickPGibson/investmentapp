

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:investmentapp/pages/clients/clients_bloc.dart';
import 'package:investmentapp/repository/image_repository.dart';
import 'package:investmentapp/repository/repository.dart';
import 'package:investmentapp/utils/utils.dart';
import 'package:investmentapp/widgets/info_card.dart';

class ClientsUi extends StatelessWidget {
  const ClientsUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClientsBloc>(
      create: (context) => ClientsBloc(context.read<Repository>())..add(FetchClients()),
      child: Builder(
        builder: (context) => BlocBuilder<ClientsBloc, ClientsState>(
          builder: (context, state) {
            switch (state) {
              case ClientsInitial():
                return const SizedBox.shrink();
              case ClientsLoading():
                return CircularProgressIndicator();
              case ClientsLoaded():
                final clients = state.clients;
                return ListView.builder(
                  itemCount: clients.length,
                  itemBuilder: (context, index) {
                    final client = clients[index];
                    return InfoCard(
                      image: context.read<ImageRepository>().getImage(client.imageUri),
                      topText: Text(client.name),
                      bottomText: Text(toSterling(client.portfolioValue)),
                      onTapped: () => GoRouter.of(context).go('/client', extra: client)
                    );
                  },
                );
            }
          },
        )
      ),
    );
  }
}
