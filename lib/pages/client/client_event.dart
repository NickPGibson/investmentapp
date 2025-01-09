part of 'client_bloc.dart';

sealed class ClientEvent extends Equatable {
  const ClientEvent();
}

class FetchClient extends ClientEvent {

  final Client client;

  const FetchClient({required this.client});

  @override
  List<Object> get props => [client];
}