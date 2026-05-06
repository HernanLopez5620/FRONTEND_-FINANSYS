// application/usecases/logout_usecase.dart
// SOLID-SRP: única responsabilidad — cerrar sesión eliminando el token.

import '../../domain/ports/storage_port.dart';

class LogoutUseCase {
  final StoragePort _storage;
  LogoutUseCase(this._storage);

  Future<void> execute() => _storage.deleteToken();
}
