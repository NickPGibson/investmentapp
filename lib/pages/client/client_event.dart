part of 'client_bloc.dart';

sealed class ClientEvent extends Equatable {
  const ClientEvent();
}

class FetchAssets extends ClientEvent {

  final Client client;

  const FetchAssets({required this.client});

  @override
  List<Object> get props => [client];
}