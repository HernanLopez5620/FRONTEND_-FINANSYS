// infrastructure/api/admin_api_adapter.dart
// Adaptador REAL — implementa AdminPort conectando al backend.

import '../../domain/entities/admin_entities.dart';
import '../../domain/ports/admin_port.dart';
import 'http_client.dart';

class AdminApiAdapter implements AdminPort {
  final HttpClient _http;

  AdminApiAdapter(this._http);

  String _conQuery(
    String path,
    Map<String, String> params,
  ) {
    if (params.isEmpty) return path;

    return Uri(
      path: path,
      queryParameters: params,
    ).toString();
  }

  @override
  Future<AdminResumen> getResumen() async {
    final res = await _http.get(
      '/admin/resumen',
      requiresAuth: true,
    );

    return AdminResumen.fromJson(
      res['resumen'] as Map<String, dynamic>,
    );
  }

  @override
  Future<List<AdminUsuario>> getUsuarios({
    String? q,
  }) async {
    final path = _conQuery(
      '/admin/usuarios',
      {
        if (q != null && q.trim().isNotEmpty) 'q': q.trim(),
      },
    );

    final res = await _http.get(
      path,
      requiresAuth: true,
    );

    final data = res['usuarios'] as List? ?? [];

    return data
        .map(
          (item) => AdminUsuario.fromJson(
            item as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  @override
  Future<LogsPage> getLogs({
    int? uid,
    String? metodo,
    bool soloErrores = false,
    int page = 1,
    int limit = 30,
  }) async {
    final path = _conQuery(
      '/admin/logs',
      {
        if (uid != null) 'uid': '$uid',
        if (metodo != null) 'metodo': metodo,
        if (soloErrores) 'errores': 'true',
        'page': '$page',
        'limit': '$limit',
      },
    );

    final res = await _http.get(
      path,
      requiresAuth: true,
    );

    return LogsPage.fromJson(res);
  }
}
