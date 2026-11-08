// presentation/pages/recuperar_contrasena.dart
// 1) Diálogo "¿Olvidaste tu contraseña?" (pide el correo)
// 2) Pantalla "Nueva contraseña" a la que llega el enlace del correo (?token=...)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/l10n.dart';
import '../components/ui/app_toast.dart';
import '../providers/auth_provider.dart';

final _correoValido = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

/// Abre el diálogo para pedir el enlace de recuperación.
Future<void> mostrarOlvideMiContrasena(BuildContext context,
    {String correoInicial = ''}) {
  return showDialog<void>(
    context: context,
    builder: (_) => _OlvideDialog(correoInicial: correoInicial),
  );
}

class _OlvideDialog extends StatefulWidget {
  final String correoInicial;
  const _OlvideDialog({required this.correoInicial});

  @override
  State<_OlvideDialog> createState() => _OlvideDialogState();
}

class _OlvideDialogState extends State<_OlvideDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailCtrl;
  bool _enviando = false;
  bool _enviado = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    // Si en el login escribió un correo, se reutiliza (si escribió un usuario, no)
    _emailCtrl = TextEditingController(
        text: _correoValido.hasMatch(widget.correoInicial)
            ? widget.correoInicial
            : '');
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _enviar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _enviando = true;
      _error = null;
    });
    final error = await context
        .read<AuthProvider>()
        .solicitarRecuperacion(_emailCtrl.text.trim());
    if (!mounted) return;
    setState(() {
      _enviando = false;
      _error = error;
      _enviado = error == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final cs = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(l.forgotTitle),
      content: SizedBox(
        width: 380,
        child: _enviado
            ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(Icons.mark_email_read_outlined, color: cs.primary),
                const SizedBox(width: 12),
                Expanded(child: Text(l.forgotSent)),
              ])
            : Form(
                key: _formKey,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.forgotIntro),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: l.forgotEmailLabel,
                          prefixIcon: const Icon(Icons.mail_outline, size: 20),
                        ),
                        validator: (v) =>
                            (v == null || !_correoValido.hasMatch(v.trim()))
                                ? l.authEmailInvalid
                                : null,
                        onFieldSubmitted: (_) => _enviar(),
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 10),
                        Text(_error!,
                            style: TextStyle(color: cs.error, fontSize: 13)),
                      ],
                    ]),
              ),
      ),
      actions: [
        if (_enviado)
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l.commonAccept))
        else ...[
          TextButton(
              onPressed: _enviando ? null : () => Navigator.pop(context),
              child: Text(l.commonCancel)),
          FilledButton(
            onPressed: _enviando ? null : _enviar,
            child: _enviando
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : Text(l.forgotSend),
          ),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Pantalla a la que llega el enlace del correo
// ─────────────────────────────────────────────
class ResetPasswordPage extends StatefulWidget {
  final String token;
  final VoidCallback onDone; // volver al login (con o sin éxito)

  const ResetPasswordPage(
      {super.key, required this.token, required this.onDone});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscure = true;
  bool _guardando = false;
  String? _error;

  @override
  void dispose() {
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _guardando = true;
      _error = null;
    });
    final error = await context
        .read<AuthProvider>()
        .restablecerContrasena(widget.token, _passCtrl.text);
    if (!mounted) return;
    if (error != null) {
      setState(() {
        _guardando = false;
        _error = error;
      });
      return;
    }
    AppToast.show(context, context.l10n.resetSuccess, type: ToastType.success);
    widget.onDone();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(Icons.lock_reset_rounded, size: 56, color: cs.primary),
                    const SizedBox(height: 12),
                    Text(l.resetTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _passCtrl,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        labelText: l.resetNewPassword,
                        prefixIcon: const Icon(Icons.lock_outline, size: 20),
                        suffixIcon: IconButton(
                          icon: Icon(
                              _obscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                      validator: (v) => (v == null || v.length < 6)
                          ? l.authPasswordMin
                          : null,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _confirmCtrl,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        labelText: l.resetConfirm,
                        prefixIcon: const Icon(Icons.lock_outline, size: 20),
                      ),
                      validator: (v) =>
                          v != _passCtrl.text ? l.authPasswordsMismatch : null,
                      onFieldSubmitted: (_) => _guardar(),
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 12),
                      Text(_error!,
                          style: TextStyle(color: cs.error, fontSize: 13)),
                    ],
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: _guardando ? null : _guardar,
                      child: _guardando
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2))
                          : Text(l.resetSave),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                        onPressed: _guardando ? null : widget.onDone,
                        child: Text(l.resetBackToLogin)),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
