import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investmentapp/repository/models/asset.dart';
import 'package:investmentapp/repository/models/client.dart';
import 'package:investmentapp/repository/repository.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {

  final Repository _repository;

  ClientBloc(this._repository) : super(ClientInitial()) {
    on<ClientEvent>((event, emit) async {
      switch (event) {
        case FetchAssets():
          emit(ClientLoading());
          final assets = (await _repository.getAssetsOf(clientUuid: event.client.uuid));
          emit(ClientReady(assets: assets));
      }
    });
  }
}
