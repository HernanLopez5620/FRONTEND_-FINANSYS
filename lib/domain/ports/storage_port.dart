// domain/ports/storage_port.dart
// Contrato abstracto para persistencia local del token JWT.

abstract class StoragePort {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
  Future<bool> hasToken();
}
