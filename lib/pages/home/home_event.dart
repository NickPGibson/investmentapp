part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class InitialiseApp extends HomeEvent {
  const InitialiseApp();

  @override
  List<Object> get props => [];
}