import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investmentapp/features/assets/domain/entities/asset.dart';
import 'package:investmentapp/features/clients/domain/usecases/get_assets_of_client_use_case.dart';

part 'client_detail_event.dart';
part 'client_detail_state.dart';

class ClientDetailBloc extends Bloc<ClientDetailEvent, ClientDetailState> {
  final GetAssetsOfClientUseCase _getAssetsOfClientUseCase;

  ClientDetailBloc(this._getAssetsOfClientUseCase) : super(const ClientDetailInitial()) {
    on<ClientDetailFetchRequested>(_onFetchRequested);
  }

  Future<void> _onFetchRequested(
    ClientDetailFetchRequested event,
    Emitter<ClientDetailState> emit,
  ) async {
    emit(const ClientDetailLoading());
    final assets = await _getAssetsOfClientUseCase(event.clientUuid);
    emit(ClientDetailLoaded(assets));
  }
}
