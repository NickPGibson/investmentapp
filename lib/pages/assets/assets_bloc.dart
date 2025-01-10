import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:investmentapp/repository/models/asset.dart';
import 'package:investmentapp/repository/repository.dart';

part 'assets_event.dart';
part 'assets_state.dart';

class AssetsBloc extends Bloc<AssetsEvent, AssetsState> {

  final Repository _repository;

  AssetsBloc(this._repository) : super(AssetsInitial()) {
    on<AssetsEvent>((event, emit) async {
      switch(event) {
        case FetchAssets():
          emit(AssetsLoading());
          final assets = await _repository.getAllAssets();
          emit(AssetsLoaded(assets));
      }
    });
  }
}
