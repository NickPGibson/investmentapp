import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:investmentapp/repository/repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final Repository _repository;

  HomeBloc(this._repository) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      switch(event) {
        case InitialiseApp():
          emit(HomeLoading());
          await _repository.initialise();
          emit(HomeLoaded());
      }
    });
  }
}
