// infrastructure/api/backup_api_adapter.dart
// Adaptador REAL — descarga la copia de seguridad desde el backend.

import 'dart:typed_data';
import '../../domain/ports/backup_port.dart';
import 'http_client.dart';

class BackupApiAdapter implements BackupPort {
  final HttpClient _http;
  BackupApiAdapter(this._http);

  @override
  Future<Uint8List> descargar({required String locale}) =>
      _http.getBytes('/users/backup?locale=$locale');
}
