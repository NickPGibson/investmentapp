part of 'assets_bloc.dart';

sealed class AssetsState extends Equatable {
  const AssetsState();
}

final class AssetsInitial extends AssetsState {
  @override
  List<Object> get props => [];
}

final class AssetsLoading extends AssetsState {
  @override
  List<Object?> get props => [];
}

final class AssetsLoaded extends AssetsState {
  final List<Asset> assets;

  const AssetsLoaded(this.assets);

  @override
  List<Object?> get props => [assets];
}
