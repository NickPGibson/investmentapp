import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:investmentapp/repository/models/client.dart';
import 'package:investmentapp/repository/repository.dart';

part 'clients_event.dart';
part 'clients_state.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {

  final Repository _repository;

  ClientsBloc(this._repository) : super(ClientsInitial()) {
    on<ClientsEvent>((event, emit) async {
      switch(event) {
        case FetchClients():
          emit(ClientsLoading());
          final clients = await _repository.getAllClients();
          emit(ClientsLoaded(clients));
      }
    });
  }
}
