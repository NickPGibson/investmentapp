part of 'asset_bloc.dart';

sealed class AssetState extends Equatable {
  const AssetState();
}

final class AssetInitial extends AssetState {
  @override
  List<Object> get props => [];
}

final class AssetLoading extends AssetState {
  @override
  List<Object> get props => [];
}

final class AssetLoaded extends AssetState {

  final Map<Client, int> clients;

  const AssetLoaded(this.clients);

  @override
  List<Object> get props => [clients];
}