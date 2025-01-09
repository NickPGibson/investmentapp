import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'assets_event.dart';
part 'assets_state.dart';

class AssetsBloc extends Bloc<AssetsEvent, AssetsState> {
  AssetsBloc() : super(AssetsInitial()) {
    on<AssetsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
