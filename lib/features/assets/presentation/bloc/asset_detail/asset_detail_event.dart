part of 'asset_detail_bloc.dart';

sealed class AssetDetailEvent extends Equatable {
  const AssetDetailEvent();
  @override
  List<Object?> get props => [];
}

class AssetDetailFetchRequested extends AssetDetailEvent {
  final String assetIsin;
  const AssetDetailFetchRequested(this.assetIsin);
  @override
  List<Object?> get props => [assetIsin];
}
