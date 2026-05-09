part of 'clients_bloc.dart';

sealed class ClientsEvent extends Equatable {
  const ClientsEvent();
  @override
  List<Object?> get props => [];
}

class ClientsFetchRequested extends ClientsEvent {
  const ClientsFetchRequested();
}
