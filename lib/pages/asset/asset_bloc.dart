import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:investmentapp/repository/models/client.dart';
import 'package:investmentapp/repository/repository.dart';

part 'asset_event.dart';
part 'asset_state.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {

  final Repository _repository;

  AssetBloc(this._repository) : super(AssetInitial()) {
    on<AssetEvent>((event, emit) async {
      switch(event) {
        case FetchClients():
          emit(AssetLoading());
          final assets = await _repository.getClientsOf(assetUuid: event.assetIsin);
          emit(AssetLoaded(assets));
      }
    });
  }
}
