part of 'client_bloc.dart';

sealed class ClientState extends Equatable {
  const ClientState();
}

final class ClientInitial extends ClientState {
  @override
  List<Object> get props => [];
}

final class ClientLoading extends ClientState {
  @override
  List<Object> get props => [];
}

final class ClientReady extends ClientState {
  final Map<Asset, int> assets;

  const ClientReady({required this.assets});

  @override
  List<Object?> get props => [assets];
}
