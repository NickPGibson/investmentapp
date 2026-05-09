part of 'asset_detail_bloc.dart';

sealed class AssetDetailState extends Equatable {
  const AssetDetailState();
  @override
  List<Object?> get props => [];
}

class AssetDetailInitial extends AssetDetailState {
  const AssetDetailInitial();
}

class AssetDetailLoading extends AssetDetailState {
  const AssetDetailLoading();
}

class AssetDetailLoaded extends AssetDetailState {
  final Map<Client, int> clients;
  const AssetDetailLoaded(this.clients);
  @override
  List<Object?> get props => [clients];
}

class AssetDetailError extends AssetDetailState {
  const AssetDetailError();
}
