part of 'asset_bloc.dart';

sealed class AssetState extends Equatable {
  const AssetState();
}

final class AssetInitial extends AssetState {
  @override
  List<Object> get props => [];
}
