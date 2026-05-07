part of 'assets_bloc.dart';

sealed class AssetsEvent extends Equatable {
  const AssetsEvent();
  @override
  List<Object?> get props => [];
}

class AssetsFetchRequested extends AssetsEvent {
  const AssetsFetchRequested();
}
