import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investmentapp/features/assets/domain/usecases/get_clients_of_asset_use_case.dart';
import 'package:investmentapp/features/clients/domain/entities/client.dart';

part 'asset_detail_event.dart';
part 'asset_detail_state.dart';

class AssetDetailBloc extends Bloc<AssetDetailEvent, AssetDetailState> {
  final GetClientsOfAssetUseCase _getClientsOfAssetUseCase;

  AssetDetailBloc(this._getClientsOfAssetUseCase) : super(const AssetDetailInitial()) {
    on<AssetDetailFetchRequested>(_onFetchRequested);
  }

  Future<void> _onFetchRequested(
    AssetDetailFetchRequested event,
    Emitter<AssetDetailState> emit,
  ) async {
    emit(const AssetDetailLoading());
    final clients = await _getClientsOfAssetUseCase(event.assetIsin);
    emit(AssetDetailLoaded(clients));
  }
}
