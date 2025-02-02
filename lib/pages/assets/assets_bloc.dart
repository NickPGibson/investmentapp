import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investmentapp/repository/models/asset.dart';
import 'package:investmentapp/repository/repository.dart';

part 'assets_event.dart';
part 'assets_state.dart';

class AssetsBloc extends Bloc<AssetsEvent, AssetsState> {

  final Repository _repository;

  AssetsBloc(this._repository) : super(AssetsInitial()) {
    on<AssetsEvent>((event, emit) async {
      switch(event) {
        case FetchAllAssets():
          emit(AssetsLoading());
          final assets = await _repository.getAllAssets();
          emit(AssetsLoaded(assets));
      }
    });
  }
}
