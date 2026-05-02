// application/usecases/get_profile_usecase.dart
// SOLID-SRP: única responsabilidad — obtener perfil del usuario autenticado.

import '../../domain/entities/user_entity.dart';
import '../../domain/ports/auth_port.dart';
import '../../domain/ports/storage_port.dart';

class GetProfileUseCase {
  final AuthPort _authPort;
  final StoragePort _storage;

  GetProfileUseCase(this._authPort, this._storage);

  Future<UserEntity?> execute() async {
    final hasToken = await _storage.hasToken();
    if (!hasToken) return null;
    return _authPort.getProfile();
  }
}
