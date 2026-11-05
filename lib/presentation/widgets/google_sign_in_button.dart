// presentation/widgets/google_sign_in_button.dart
// Botón oficial "Continuar con Google" (Google Identity Services, solo Flutter Web).
// Google devuelve un ID token; el backend lo verifica y crea/abre la cuenta.
// Si no hay GOOGLE_CLIENT_ID configurado, el botón simplemente no se muestra.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:google_sign_in_web/web_only.dart' as web;
import 'package:provider/provider.dart';

import '../../core/env/app_env.dart';
import '../../l10n/l10n.dart';
import '../components/ui/app_toast.dart';
import '../providers/auth_provider.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  StreamSubscription<GoogleSignInUserData?>? _sub;
  Future<void>? _init;

  bool get _configurado => AppEnv.googleClientId.isNotEmpty;

  @override
  void initState() {
    super.initState();
    if (_configurado) _init = _iniciar();
  }

  Future<void> _iniciar() async {
    final plataforma = GoogleSignInPlatform.instance;
    await plataforma.initWithParams(
      const SignInInitParameters(
        clientId: AppEnv.googleClientId,
        scopes: <String>['email', 'profile'],
      ),
    );
    _sub = plataforma.userDataEvents?.listen(_alRecibirUsuario);
  }

  Future<void> _alRecibirUsuario(GoogleSignInUserData? datos) async {
    final idToken = datos?.idToken;
    if (datos == null || idToken == null || !mounted) return;

    final auth = context.read<AuthProvider>();
    final ok = await auth.loginConGoogle(idToken);

    if (!ok && mounted) {
      AppToast.show(
        context,
        auth.error ?? context.l10n.authGoogleLoginError,
        type: ToastType.error,
      );
    }

    // Se cierra la sesión de Google en el navegador (la sesión de FinanSys
    // ya quedó abierta); así el botón funciona de nuevo la próxima vez.
    try {
      await GoogleSignInPlatform.instance.signOut();
    } catch (_) {}
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_configurado) return const SizedBox.shrink();

    final cs = Theme.of(context).colorScheme;

    return FutureBuilder<void>(
      future: _init,
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const SizedBox(height: 44);
        }
        if (snap.hasError) {
          return Text(
            context.l10n.authGoogleLoadError,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
          );
        }
        return Column(
          children: [
            Row(
              children: [
                Expanded(child: Divider(color: cs.outlineVariant)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    context.l10n.authOr,
                    style: TextStyle(color: cs.onSurfaceVariant),
                  ),
                ),
                Expanded(child: Divider(color: cs.outlineVariant)),
              ],
            ),
            const SizedBox(height: 14),
            Center(child: web.renderButton()),
            const SizedBox(height: 8),
            Text(
              context.l10n.authGoogleTermsNotice,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant),
            ),
          ],
        );
      },
    );
  }
}
