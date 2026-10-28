// core/session/session_events.dart
// Puente entre la capa HTTP y el estado de sesión: cuando el servidor dice que la
// sesión dejó de ser la activa (se abrió en otra ventana/dispositivo), se avisa aquí.

class SessionEvents {
  SessionEvents._();

  /// [code]: 'SESION_REEMPLAZADA' o 'SESION_CERRADA'. [msg]: texto para el usuario.
  static void Function(String code, String msg)? onInvalid;
}
