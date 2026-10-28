// presentation/providers/inactividad_provider.dart
import 'dart:async';
import 'package:flutter/material.dart';

enum EstadoSesion { activa, advertencia, cerrada, bloqueada }

class InactividadProvider extends ChangeNotifier {
  static const _tiempoAviso = Duration(minutes: 2, seconds: 30);
  static const _tiempoCierre = Duration(minutes: 2, seconds: 30);
  static const _tiempoBloqueo = Duration(seconds: 30);

  Timer? _timerAviso;
  Timer? _timerCierre;
  Timer? _timerBloqueo;
  Timer? _timerContador;

  EstadoSesion _estado = EstadoSesion.activa;
  int _segundosRestantes = 150; // 2:30 en segundos
  int _segundosBloqueo = 30;

  EstadoSesion get estado => _estado;
  int get segundosRestantes => _segundosRestantes;
  int get segundosBloqueo => _segundosBloqueo;

  VoidCallback? onCerrarSesion;

  void iniciar(VoidCallback cerrarSesion) {
    onCerrarSesion = cerrarSesion;
    _reiniciar();
  }

  /// Detiene el control de inactividad (al salir del dashboard).
  /// No interrumpe el bloqueo de 30 s que sigue a un cierre por inactividad.
  void detener() {
    if (_estado == EstadoSesion.bloqueada || _estado == EstadoSesion.cerrada) {
      return;
    }
    _cancelarTimers();
    onCerrarSesion = null;
    _estado = EstadoSesion.activa;
    _segundosRestantes = 150;
    notifyListeners();
  }

  void registrarActividad() {
    if (_estado == EstadoSesion.bloqueada) return;
    if (_estado == EstadoSesion.cerrada) return;
    _reiniciar();
  }

  void _reiniciar() {
    _cancelarTimers();
    _estado = EstadoSesion.activa;
    _segundosRestantes = 150;
    notifyListeners();
    _timerAviso = Timer(_tiempoAviso, _mostrarAviso);
  }

  void _mostrarAviso() {
    _estado = EstadoSesion.advertencia;
    _segundosRestantes = 150;
    notifyListeners();

    // Contador visual regresivo
    _timerContador = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_segundosRestantes > 0) {
        _segundosRestantes--;
        notifyListeners();
      } else {
        t.cancel();
      }
    });

    _timerCierre = Timer(_tiempoCierre, _cerrarSesion);
  }

  void _cerrarSesion() {
    _cancelarTimers();
    _estado = EstadoSesion.cerrada;
    _segundosBloqueo = 30;
    notifyListeners();
    onCerrarSesion?.call();

    // Bloqueo de 30 segundos
    _estado = EstadoSesion.bloqueada;
    notifyListeners();

    _timerContador = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_segundosBloqueo > 0) {
        _segundosBloqueo--;
        notifyListeners();
      } else {
        t.cancel();
        _estado = EstadoSesion.activa;
        _segundosBloqueo = 30;
        notifyListeners();
      }
    });

    _timerBloqueo = Timer(_tiempoBloqueo, () {
      _estado = EstadoSesion.activa;
      notifyListeners();
    });
  }

  void extenderSesion() {
    if (_estado == EstadoSesion.advertencia) {
      _reiniciar();
    }
  }

  void _cancelarTimers() {
    _timerAviso?.cancel();
    _timerCierre?.cancel();
    _timerBloqueo?.cancel();
    _timerContador?.cancel();
  }

  @override
  void dispose() {
    _cancelarTimers();
    super.dispose();
  }
}
