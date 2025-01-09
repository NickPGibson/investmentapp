part of 'clients_bloc.dart';

sealed class ClientsEvent extends Equatable {
  const ClientsEvent();
}

class FetchClients extends ClientsEvent {
  @override
  List<Object> get props => [];
}

