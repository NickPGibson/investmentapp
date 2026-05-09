import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:investmentapp/features/clients/presentation/bloc/clients/clients_bloc.dart';
import 'package:investmentapp/injection_container.dart';
import 'package:investmentapp/shared/services/image_service.dart';
import 'package:investmentapp/utils/utils.dart';
import 'package:investmentapp/widgets/info_card.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClientsBloc>(
      create: (_) => sl<ClientsBloc>()..add(const ClientsFetchRequested()),
      child: Builder(
        builder: (context) => BlocBuilder<ClientsBloc, ClientsState>(
          builder: (context, state) {
            switch (state) {
              case ClientsInitial():
                return const SizedBox.shrink();
              case ClientsLoading():
                return const CircularProgressIndicator();
              case ClientsLoaded():
                final clients = state.clients;
                return ListView.builder(
                  itemCount: clients.length,
                  itemBuilder: (context, index) {
                    final client = clients[index];
                    return InfoCard(
                      image: sl<ImageService>().getImage(client.imageUri),
                      topText: Text(client.name),
                      bottomText: Text(toSterling(client.portfolioValue)),
                      onTapped: () => GoRouter.of(context).go('/client', extra: client),
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
