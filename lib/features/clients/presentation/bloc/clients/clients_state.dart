part of 'clients_bloc.dart';

sealed class ClientsState extends Equatable {
  const ClientsState();
  @override
  List<Object?> get props => [];
}

class ClientsInitial extends ClientsState {
  const ClientsInitial();
}

class ClientsLoading extends ClientsState {
  const ClientsLoading();
}

class ClientsLoaded extends ClientsState {
  final List<Client> clients;
  const ClientsLoaded(this.clients);
  @override
  List<Object?> get props => [clients];
}
