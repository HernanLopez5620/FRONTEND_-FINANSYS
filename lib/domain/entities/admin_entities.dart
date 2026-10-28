// domain/entities/admin_entities.dart
// Entidades del panel de administrador.
// Ninguna entidad contiene contraseñas.

int _toInt(dynamic value, [int defaultValue = 0]) {
  return int.tryParse('${value ?? ''}') ?? defaultValue;
}

DateTime? _toDate(dynamic value) {
  if (value == null) return null;

  return DateTime.tryParse('$value')?.toLocal();
}

// ─────────────────────────────────────────────
// RESUMEN DEL PANEL DE ADMINISTRADOR
// ─────────────────────────────────────────────

class AdminResumen {
  final int totalUsuarios;
  final int sesionesAbiertas;
  final int nuevos7d;
  final int activos24h;
  final int requests24h;
  final int errores24h;

  const AdminResumen({
    required this.totalUsuarios,
    required this.sesionesAbiertas,
    required this.nuevos7d,
    required this.activos24h,
    required this.requests24h,
    required this.errores24h,
  });

  factory AdminResumen.fromJson(Map<String, dynamic> json) {
    return AdminResumen(
      totalUsuarios: _toInt(json['total_usuarios']),
      sesionesAbiertas: _toInt(json['sesiones_abiertas']),
      nuevos7d: _toInt(json['nuevos_7d']),
      activos24h: _toInt(json['activos_24h']),
      requests24h: _toInt(json['requests24h']),
      errores24h: _toInt(json['errores24h']),
    );
  }
}

// ─────────────────────────────────────────────
// USUARIO DEL PANEL DE ADMINISTRADOR
// ─────────────────────────────────────────────

class AdminUsuario {
  final int uid;
  final String email;
  final String nombre;
  final String username;
  final String rol;
  final bool activo;
  final DateTime? createdAt;
  final bool sesionAbierta;
  final bool enLinea;
  final DateTime? ultimaActividad;
  final int totalAcciones;

  const AdminUsuario({
    required this.uid,
    required this.email,
    required this.nombre,
    required this.username,
    required this.rol,
    required this.activo,
    required this.createdAt,
    required this.sesionAbierta,
    required this.enLinea,
    required this.ultimaActividad,
    required this.totalAcciones,
  });

  bool get esAdmin => rol == 'admin';

  factory AdminUsuario.fromJson(Map<String, dynamic> json) {
    return AdminUsuario(
      uid: _toInt(json['uid']),
      email: json['email'] as String? ?? '',
      nombre: json['nombre'] as String? ?? '',
      username: json['username'] as String? ?? '',
      rol: json['rol'] as String? ?? 'usuario',
      activo: json['activo'] as bool? ?? true,
      createdAt: _toDate(json['created_at']),
      sesionAbierta: json['sesion_abierta'] as bool? ?? false,
      enLinea: json['en_linea'] as bool? ?? false,
      ultimaActividad: _toDate(json['ultima_actividad']),
      totalAcciones: _toInt(json['total_acciones']),
    );
  }
}

// ─────────────────────────────────────────────
// ENTRADA DE LOG
// ─────────────────────────────────────────────

class LogEntry {
  final int id;
  final int? userId;
  final String? username;
  final String? email;
  final String accion;
  final String metodo;
  final String ruta;
  final String? ip;
  final String? userAgent;
  final int? statusCode;
  final int? duracionMs;
  final DateTime? createdAt;

  const LogEntry({
    required this.id,
    required this.userId,
    required this.username,
    required this.email,
    required this.accion,
    required this.metodo,
    required this.ruta,
    required this.ip,
    required this.userAgent,
    required this.statusCode,
    required this.duracionMs,
    required this.createdAt,
  });

  factory LogEntry.fromJson(Map<String, dynamic> json) {
    return LogEntry(
      id: _toInt(json['id']),
      userId: json['user_id'] == null ? null : _toInt(json['user_id']),
      username: json['username'] as String?,
      email: json['email'] as String?,
      accion: json['accion'] as String? ?? '',
      metodo: json['metodo'] as String? ?? '',
      ruta: json['ruta'] as String? ?? '',
      ip: json['ip'] as String?,
      userAgent: json['user_agent'] as String?,
      statusCode:
          json['status_code'] == null ? null : _toInt(json['status_code']),
      duracionMs:
          json['duracion_ms'] == null ? null : _toInt(json['duracion_ms']),
      createdAt: _toDate(json['created_at']),
    );
  }
}

// ─────────────────────────────────────────────
// PÁGINA DE LOGS
// ─────────────────────────────────────────────

class LogsPage {
  final int total;
  final int page;
  final int limit;
  final List<LogEntry> logs;

  const LogsPage({
    required this.total,
    required this.page,
    required this.limit,
    required this.logs,
  });

  factory LogsPage.fromJson(Map<String, dynamic> json) {
    final rawLogs = json['logs'] as List? ?? [];

    return LogsPage(
      total: _toInt(json['total']),
      page: _toInt(json['page'], 1),
      limit: _toInt(json['limit'], 30),
      logs: rawLogs
          .map(
            (item) => LogEntry.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}
