// presentation/providers/admin_logs_controller.dart
// Controlador de UNA lista de logs (todos los usuarios, o uno solo si se da [uid]).
// Cada vista de logs crea el suyo, así la pestaña "Actividad" y el detalle de un
// usuario pueden convivir sin pisarse los filtros.

import 'package:flutter/foundation.dart';
import '../../container.dart';
import '../../domain/entities/admin_entities.dart';

class LogsController extends ChangeNotifier {
  static const _porPagina = 30;

  final int? uid;
  LogsController({this.uid});

  List<LogEntry> _logs = [];
  int _total = 0;
  int _page = 1;
  bool _cargando = false;
  String? _error;
  String? _metodo;
  bool _soloErrores = false;
  int _gen = 0; // descarta respuestas viejas al cambiar filtros

  List<LogEntry> get logs => _logs;
  int get total => _total;
  bool get cargando => _cargando;
  String? get error => _error;
  String? get metodo => _metodo;
  bool get soloErrores => _soloErrores;
  bool get hayMas => _logs.length < _total;

  void setMetodo(String? m) {
    if (_metodo == m) return;
    _metodo = m;
    cargar();
  }

  void setSoloErrores(bool v) {
    if (_soloErrores == v) return;
    _soloErrores = v;
    cargar();
  }

  /// Vuelve a la primera página con los filtros actuales.
  Future<void> cargar() => _traer(pagina: 1);

  Future<void> cargarMas() {
    if (_cargando || !hayMas) return Future.value();
    return _traer(pagina: _page + 1);
  }

  Future<void> _traer({required int pagina}) async {
    final gen = ++_gen;
    _cargando = true;
    _error = null;
    if (pagina == 1) _logs = [];
    notifyListeners();
    try {
      final res = await Container.listarLogsAdminUseCase.execute(
        uid: uid,
        metodo: _metodo,
        soloErrores: _soloErrores,
        page: pagina,
        limit: _porPagina,
      );
      if (gen != _gen) return;
      _page = res.page;
      _total = res.total;
      _logs = pagina == 1 ? res.logs : [..._logs, ...res.logs];
    } catch (e) {
      if (gen != _gen) return;
      _error = e.toString();
    } finally {
      if (gen == _gen) {
        _cargando = false;
        notifyListeners();
      }
    }
  }
}
