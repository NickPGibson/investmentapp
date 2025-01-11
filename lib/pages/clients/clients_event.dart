part of 'clients_bloc.dart';

sealed class ClientsEvent extends Equatable {
  const ClientsEvent();
}

class FetchAllClients extends ClientsEvent {
  @override
  List<Object> get props => [];
}

