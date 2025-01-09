part of 'clients_bloc.dart';

sealed class ClientsState extends Equatable {
  const ClientsState();
}

final class ClientsInitial extends ClientsState {
  @override
  List<Object> get props => [];
}

final class ClientsLoading extends ClientsState {
  @override
  List<Object?> get props => [];
}

final class ClientsLoaded extends ClientsState {
  final List<Client> clients;

  const ClientsLoaded(this.clients);

  @override
  List<Object?> get props => [clients];
}
