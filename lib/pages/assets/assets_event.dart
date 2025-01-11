part of 'assets_bloc.dart';

sealed class AssetsEvent extends Equatable {
  const AssetsEvent();
}

class FetchAllAssets extends AssetsEvent {
  @override
  List<Object> get props => [];
}