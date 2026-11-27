// presentation/providers/importacion_provider.dart
// SOLID-SRP: estado de la importación de movimientos desde CSV/Excel.

import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../domain/entities/categoria_entity.dart';
import '../../domain/entities/importacion_entity.dart';
import '../../container.dart';
import '../../infrastructure/files/file_picker_web.dart';
import '../errors/error_translator.dart';

class ImportacionProvider extends ChangeNotifier {
  String? _nombreArchivo;
  ImportPreviewEntity? _preview;
  bool _leyendo = false;
  bool _importando = false;
  String? _error;
  CategoriaEntity? _categoriaPorDefecto;
  bool _incluirDuplicadas = false;

  String? get nombreArchivo => _nombreArchivo;
  ImportPreviewEntity? get preview => _preview;
  bool get leyendo => _leyendo;
  bool get importando => _importando;
  String? get error => _error;
  CategoriaEntity? get categoriaPorDefecto => _categoriaPorDefecto;
  bool get incluirDuplicadas => _incluirDuplicadas;

  void reiniciar() {
    _nombreArchivo = null;
    _preview = null;
    _error = null;
    _categoriaPorDefecto = null;
    _incluirDuplicadas = false;
    _leyendo = false;
    _importando = false;
    notifyListeners();
  }

  void setCategoriaPorDefecto(CategoriaEntity? c) {
    _categoriaPorDefecto = c;
    notifyListeners();
  }

  void setIncluirDuplicadas(bool v) {
    _incluirDuplicadas = v;
    notifyListeners();
  }

  /// Abre el selector de archivos y lee el elegido. Si el usuario cancela, no cambia nada.
  Future<void> elegirArchivo() async {
    final archivo = await FilePickerWeb.elegir();
    if (archivo == null) return;

    _leyendo = true;
    _error = null;
    notifyListeners();
    try {
      _preview = await Container.previsualizarImportacionUseCase.execute(
        nombreArchivo: archivo.nombre,
        contenidoBase64: base64Encode(archivo.bytes),
      );
      _nombreArchivo = archivo.nombre;
      _categoriaPorDefecto = null;
      _incluirDuplicadas = false;
    } catch (e) {
      _preview = null;
      _nombreArchivo = null;
      _error = ErrorTranslator.message(e);
    } finally {
      _leyendo = false;
      notifyListeners();
    }
  }

  /// Filas que se van a guardar según las opciones elegidas:
  ///  - sin errores (y no duplicadas, salvo que se pida incluirlas), o
  ///  - cuyo único problema es la categoría, si se eligió una categoría por defecto.
  List<Map<String, dynamic>> get filasAImportar {
    final p = _preview;
    if (p == null) return [];
    final out = <Map<String, dynamic>>[];
    for (final f in p.filas) {
      if (f.duplicada && !_incluirDuplicadas) continue;
      int? categoriaId;
      if (f.valida) {
        categoriaId = f.categoriaId;
      } else if (f.soloCategoriaDesconocida && _categoriaPorDefecto != null) {
        categoriaId = _categoriaPorDefecto!.id;
      }
      if (categoriaId == null || f.fecha == null || f.monto == null) continue;
      out.add({
        'fecha': f.fecha,
        'monto': f.monto,
        'tipo': f.tipo,
        'categoria_id': categoriaId,
        'descripcion': f.descripcion,
      });
    }
    return out;
  }

  /// Devuelve cuántos movimientos se importaron, o -1 si falló.
  Future<int> confirmar() async {
    final filas = filasAImportar;
    if (filas.isEmpty) return -1;
    _importando = true;
    _error = null;
    notifyListeners();
    try {
      final n = await Container.confirmarImportacionUseCase.execute(filas);
      _importando = false;
      notifyListeners();
      return n;
    } catch (e) {
      _error = ErrorTranslator.message(e);
      _importando = false;
      notifyListeners();
      return -1;
    }
  }
}
