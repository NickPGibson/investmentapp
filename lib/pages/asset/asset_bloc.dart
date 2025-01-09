import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_event.dart';
part 'asset_state.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  AssetBloc() : super(AssetInitial()) {
    on<AssetEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
