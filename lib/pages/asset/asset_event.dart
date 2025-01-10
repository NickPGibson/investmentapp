part of 'asset_bloc.dart';

sealed class AssetEvent extends Equatable {
  const AssetEvent();
}

class FetchClients extends AssetEvent {

  final String assetIsin;

  const FetchClients(this.assetIsin);

  @override
  List<Object> get props => [assetIsin];
}
