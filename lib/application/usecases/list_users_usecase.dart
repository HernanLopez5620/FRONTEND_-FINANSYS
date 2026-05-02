// application/usecases/list_users_usecase.dart
// SOLID-SRP: única responsabilidad — listar todos los usuarios.
// Correlacionado con GET /api/v1/users/

import '../../domain/entities/user_entity.dart';
import '../../domain/ports/auth_port.dart';

class ListUsersUseCase {
  final AuthPort _authPort;
  ListUsersUseCase(this._authPort);

  Future<List<UserEntity>> execute() => _authPort.getUsers();
}
