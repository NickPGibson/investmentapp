part of 'assets_bloc.dart';

sealed class AssetsState extends Equatable {
  const AssetsState();
  @override
  List<Object?> get props => [];
}

class AssetsInitial extends AssetsState {
  const AssetsInitial();
}

class AssetsLoading extends AssetsState {
  const AssetsLoading();
}

class AssetsLoaded extends AssetsState {
  final List<Asset> assets;
  const AssetsLoaded(this.assets);
  @override
  List<Object?> get props => [assets];
}

class AssetsError extends AssetsState {
  const AssetsError();
}
