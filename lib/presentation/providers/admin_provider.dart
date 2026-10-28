// presentation/providers/admin_provider.dart
// SOLID-SRP: estado del panel de administrador (resumen y lista de usuarios).

import 'package:flutter/foundation.dart';
import '../../container.dart';
import '../../domain/entities/admin_entities.dart';

class AdminProvider extends ChangeNotifier {
  AdminResumen? _resumen;
  List<AdminUsuario> _usuarios = [];
  String _busqueda = '';
  bool _cargandoResumen = false;
  bool _cargandoUsuarios = false;
  String? _errorResumen;
  String? _errorUsuarios;
  int _genUsuarios =
      0; // descarta respuestas viejas si el admin sigue escribiendo

  AdminResumen? get resumen => _resumen;
  List<AdminUsuario> get usuarios => _usuarios;
  String get busqueda => _busqueda;
  bool get cargandoResumen => _cargandoResumen;
  bool get cargandoUsuarios => _cargandoUsuarios;
  String? get errorResumen => _errorResumen;
  String? get errorUsuarios => _errorUsuarios;

  Future<void> cargarTodo() => Future.wait([cargarResumen(), cargarUsuarios()]);

  Future<void> cargarResumen() async {
    _cargandoResumen = true;
    _errorResumen = null;
    notifyListeners();
    try {
      _resumen = await Container.resumenAdminUseCase.execute();
    } catch (e) {
      _errorResumen = e.toString();
    } finally {
      _cargandoResumen = false;
      notifyListeners();
    }
  }

  Future<void> buscar(String q) {
    _busqueda = q.trim();
    return cargarUsuarios();
  }

  Future<void> cargarUsuarios() async {
    final gen = ++_genUsuarios;
    _cargandoUsuarios = true;
    _errorUsuarios = null;
    notifyListeners();
    try {
      final lista = await Container.listarUsuariosAdminUseCase
          .execute(q: _busqueda.isEmpty ? null : _busqueda);
      if (gen != _genUsuarios) return;
      _usuarios = lista;
    } catch (e) {
      if (gen != _genUsuarios) return;
      _errorUsuarios = e.toString();
    } finally {
      if (gen == _genUsuarios) {
        _cargandoUsuarios = false;
        notifyListeners();
      }
    }
  }

  /// Borra lo cargado (al salir del panel) para no mostrar datos viejos a otra cuenta.
  void limpiar() {
    _genUsuarios++;
    _resumen = null;
    _usuarios = [];
    _busqueda = '';
    _errorResumen = null;
    _errorUsuarios = null;
    _cargandoResumen = false;
    _cargandoUsuarios = false;
    notifyListeners();
  }
}
