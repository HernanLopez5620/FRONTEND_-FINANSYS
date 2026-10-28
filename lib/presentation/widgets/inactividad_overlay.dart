// presentation/widgets/inactividad_overlay.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/inactividad_provider.dart';

class InactividadOverlay extends StatelessWidget {
  final Widget child;
  const InactividadOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final autenticado = context.watch<AuthProvider>().isAuthenticated;
    return Consumer<InactividadProvider>(
      builder: (context, inact, _) {
        return Stack(
          children: [
            child,

            // ── Aviso de inactividad (solo dentro de la app) ──
            if (autenticado && inact.estado == EstadoSesion.advertencia)
              _ModalAviso(inact: inact),

            // ── Pantalla de bloqueo ──
            if (inact.estado == EstadoSesion.bloqueada)
              _PantallaBloqueo(inact: inact),
          ],
        );
      },
    );
  }
}

class _ModalAviso extends StatelessWidget {
  final InactividadProvider inact;
  const _ModalAviso({required this.inact});

  String _formatTiempo(int segundos) {
    final m = segundos ~/ 60;
    final s = segundos % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(32),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.access_time_rounded,
                  size: 56, color: Colors.orange.shade400),
              const SizedBox(height: 16),
              Text('¿Sigues ahí?',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface)),
              const SizedBox(height: 8),
              Text(
                'Tu sesión se cerrará por inactividad en:',
                style: TextStyle(
                    fontSize: 14, color: cs.onSurface.withOpacity(0.6)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade400.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade400, width: 2),
                ),
                child: Text(
                  _formatTiempo(inact.segundosRestantes),
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade400,
                      letterSpacing: 4),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => inact.extenderSesion(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cs.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Continuar sesión',
                      style: TextStyle(
                          color: cs.onPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PantallaBloqueo extends StatelessWidget {
  final InactividadProvider inact;
  const _PantallaBloqueo({required this.inact});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline_rounded, size: 72, color: cs.primary),
            const SizedBox(height: 24),
            Text('Sesión cerrada',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface)),
            const SizedBox(height: 8),
            Text(
              'Tu sesión fue cerrada por inactividad.',
              style:
                  TextStyle(fontSize: 14, color: cs.onSurface.withOpacity(0.6)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: cs.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: cs.primary.withOpacity(0.3)),
              ),
              child: Column(children: [
                Text('Podrás ingresar en:',
                    style: TextStyle(
                        fontSize: 13, color: cs.onSurface.withOpacity(0.6))),
                const SizedBox(height: 8),
                Text(
                  '${inact.segundosBloqueo}s',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: cs.primary),
                ),
              ]),
            ),
            const SizedBox(height: 8),
            Text(
              'Por tu seguridad debes esperar antes de volver a iniciar sesión.',
              style:
                  TextStyle(fontSize: 12, color: cs.onSurface.withOpacity(0.4)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
