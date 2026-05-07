import 'package:investmentapp/features/clients/domain/entities/client.dart';
import 'package:investmentapp/features/clients/domain/repositories/client_repository.dart';

class GetAllClientsUseCase {
  final ClientRepository _repository;
  const GetAllClientsUseCase(this._repository);

  Future<List<Client>> call() => _repository.getAllClients();
}
