import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investmentapp/features/clients/domain/entities/client.dart';
import 'package:investmentapp/features/clients/domain/usecases/get_all_clients_use_case.dart';

part 'clients_event.dart';
part 'clients_state.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {
  final GetAllClientsUseCase _getAllClientsUseCase;

  ClientsBloc(this._getAllClientsUseCase) : super(const ClientsInitial()) {
    on<ClientsFetchRequested>(_onFetchRequested);
  }

  Future<void> _onFetchRequested(
    ClientsFetchRequested event,
    Emitter<ClientsState> emit,
  ) async {
    emit(const ClientsLoading());
    final clients = await _getAllClientsUseCase();
    emit(ClientsLoaded(clients));
  }
}
