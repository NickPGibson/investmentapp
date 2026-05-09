part of 'client_detail_bloc.dart';

sealed class ClientDetailEvent extends Equatable {
  const ClientDetailEvent();
  @override
  List<Object?> get props => [];
}

class ClientDetailFetchRequested extends ClientDetailEvent {
  final String clientUuid;
  const ClientDetailFetchRequested(this.clientUuid);
  @override
  List<Object?> get props => [clientUuid];
}
