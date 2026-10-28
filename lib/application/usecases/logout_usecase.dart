// application/usecases/logout_usecase.dart
// SOLID-SRP: única responsabilidad — cerrar sesión (servidor + token local).

import '../../domain/ports/auth_port.dart';
import '../../domain/ports/storage_port.dart';

class LogoutUseCase {
  final StoragePort _storage;
  final AuthPort _authPort;
  LogoutUseCase(this._storage, this._authPort);

  Future<void> execute() async {
    // Primero avisamos al servidor (necesita el token); si falla, igual cerramos local.
    try {
      await _authPort.logout();
    } catch (_) {}
    await _storage.deleteToken();
  }
}
