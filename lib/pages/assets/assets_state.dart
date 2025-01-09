part of 'assets_bloc.dart';

sealed class AssetsState extends Equatable {
  const AssetsState();
}

final class AssetsInitial extends AssetsState {
  @override
  List<Object> get props => [];
}
