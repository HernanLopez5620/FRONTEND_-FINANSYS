// domain/entities/importacion_entity.dart
// Resultado de leer un archivo CSV/Excel antes de importarlo.
// Backend: { filas: [{ fila, fecha, monto, descripcion, tipo, categoria_id, categoria_nombre,
//                      errores: [...], duplicada }],
//            resumen: { total, validas, con_error, duplicadas },
//            categorias_sin_coincidencia: [...] }

class ImportFilaEntity {
  final int fila; // número de fila en el archivo (1 = encabezados)
  final String? fecha; // 'YYYY-MM-DD'
  final double? monto;
  final String descripcion;
  final String tipo; // 'gasto' | 'ingreso'
  final int? categoriaId;
  final String categoriaNombre;
  final List<String>
      errores; // INVALID_DATE, FUTURE_DATE, INVALID_AMOUNT, INVALID_TYPE, UNKNOWN_CATEGORY
  final bool duplicada;

  const ImportFilaEntity({
    required this.fila,
    required this.fecha,
    required this.monto,
    required this.descripcion,
    required this.tipo,
    required this.categoriaId,
    required this.categoriaNombre,
    required this.errores,
    required this.duplicada,
  });

  bool get valida => errores.isEmpty;

  /// Solo falla porque la categoría no existe (se puede resolver con una categoría por defecto).
  bool get soloCategoriaDesconocida =>
      errores.length == 1 && errores.first == 'UNKNOWN_CATEGORY';

  factory ImportFilaEntity.fromJson(Map<String, dynamic> json) {
    return ImportFilaEntity(
      fila: (json['fila'] as num?)?.toInt() ?? 0,
      fecha: json['fecha']?.toString(),
      monto: json['monto'] == null
          ? null
          : double.tryParse(json['monto'].toString()),
      descripcion: json['descripcion'] ?? '',
      tipo: json['tipo'] ?? 'gasto',
      categoriaId: (json['categoria_id'] as num?)?.toInt(),
      categoriaNombre: json['categoria_nombre'] ?? '',
      errores:
          (json['errores'] as List? ?? []).map((e) => e.toString()).toList(),
      duplicada: json['duplicada'] ?? false,
    );
  }
}

class ImportPreviewEntity {
  final List<ImportFilaEntity> filas;
  final int total;
  final int validas;
  final int conError;
  final int duplicadas;
  final List<String> categoriasSinCoincidencia;

  const ImportPreviewEntity({
    required this.filas,
    required this.total,
    required this.validas,
    required this.conError,
    required this.duplicadas,
    required this.categoriasSinCoincidencia,
  });

  factory ImportPreviewEntity.fromJson(Map<String, dynamic> json) {
    final r = (json['resumen'] as Map?)?.cast<String, dynamic>() ?? {};
    int n(String k) => (r[k] as num?)?.toInt() ?? 0;
    return ImportPreviewEntity(
      filas: (json['filas'] as List? ?? [])
          .map((e) => ImportFilaEntity.fromJson(e))
          .toList(),
      total: n('total'),
      validas: n('validas'),
      conError: n('con_error'),
      duplicadas: n('duplicadas'),
      categoriasSinCoincidencia:
          (json['categorias_sin_coincidencia'] as List? ?? [])
              .map((e) => e.toString())
              .toList(),
    );
  }
}
