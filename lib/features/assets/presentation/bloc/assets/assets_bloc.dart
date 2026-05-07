import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investmentapp/features/assets/domain/entities/asset.dart';
import 'package:investmentapp/features/assets/domain/usecases/get_all_assets_use_case.dart';

part 'assets_event.dart';
part 'assets_state.dart';

class AssetsBloc extends Bloc<AssetsEvent, AssetsState> {
  final GetAllAssetsUseCase _getAllAssetsUseCase;

  AssetsBloc(this._getAllAssetsUseCase) : super(const AssetsInitial()) {
    on<AssetsFetchRequested>(_onFetchRequested);
  }

  Future<void> _onFetchRequested(
    AssetsFetchRequested event,
    Emitter<AssetsState> emit,
  ) async {
    emit(const AssetsLoading());
    final assets = await _getAllAssetsUseCase();
    emit(AssetsLoaded(assets));
  }
}
