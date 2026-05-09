part of 'client_detail_bloc.dart';

sealed class ClientDetailState extends Equatable {
  const ClientDetailState();
  @override
  List<Object?> get props => [];
}

class ClientDetailInitial extends ClientDetailState {
  const ClientDetailInitial();
}

class ClientDetailLoading extends ClientDetailState {
  const ClientDetailLoading();
}

class ClientDetailLoaded extends ClientDetailState {
  final Map<Asset, int> assets;
  const ClientDetailLoaded(this.assets);
  @override
  List<Object?> get props => [assets];
}

class ClientDetailError extends ClientDetailState {
  const ClientDetailError();
}
