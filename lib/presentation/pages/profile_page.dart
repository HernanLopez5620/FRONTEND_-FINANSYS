// presentation/pages/profile_page.dart
// SOLID-SRP: única responsabilidad — ver y editar el perfil del usuario.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/tema_provider.dart';
import '../components/ui/app_toast.dart';
import '../widgets/inactividad_overlay.dart';
import 'terminos_page.dart';
import 'politica_datos_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreCtrl;
  late final TextEditingController _usernameCtrl;
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthProvider>().user;
    _nombreCtrl = TextEditingController(text: user?.nombre ?? '');
    _usernameCtrl = TextEditingController(text: user?.username ?? '');
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _usernameCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();
    final user = auth.user;
    final nombre = _nombreCtrl.text.trim();
    final username = _usernameCtrl.text.trim();
    final password = _passCtrl.text;

    // Solo enviamos lo que realmente cambió
    final ok = await auth.updateProfile(
      nombre: nombre != user?.nombre ? nombre : null,
      username: username != user?.username ? username : null,
      password: password.isNotEmpty ? password : null,
    );

    if (!mounted) return;
    if (ok) {
      _passCtrl.clear();
      _confirmCtrl.clear();
      AppToast.show(context, 'Perfil actualizado', type: ToastType.success);
    } else {
      AppToast.show(context, auth.error ?? 'No se pudo actualizar el perfil',
          type: ToastType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final auth = context.watch<AuthProvider>();

    // Si la sesión se cerró (p. ej. por inactividad), volvemos al inicio
    if (!auth.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) Navigator.of(context).popUntil((r) => r.isFirst);
      });
    }

    final user = auth.user;

    return InactividadOverlay(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Mi perfil'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Avatar y datos básicos ──
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: cs.primary,
                    child: Text(
                      _inicial(user?.nombre, user?.username),
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: cs.onPrimary),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    user?.email ?? '',
                    style: TextStyle(
                        fontSize: 14, color: cs.onSurface.withOpacity(0.6)),
                  ),
                ),
                const SizedBox(height: 28),

                // ── Datos editables ──
                _titulo(context, 'Datos personales'),
                TextFormField(
                  controller: _nombreCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    prefixIcon: Icon(Icons.badge_outlined),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Ingresa tu nombre'
                      : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _usernameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Usuario',
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Ingresa un nombre de usuario'
                      : null,
                ),
                const SizedBox(height: 24),

                // ── Cambio de contraseña (opcional) ──
                _titulo(context, 'Cambiar contraseña (opcional)'),
                TextFormField(
                  controller: _passCtrl,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: 'Nueva contraseña',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(_obscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return null;
                    return v.length < 6 ? 'Mínimo 6 caracteres' : null;
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _confirmCtrl,
                  obscureText: _obscure,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar contraseña',
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                  ),
                  validator: (v) => (v != _passCtrl.text)
                      ? 'Las contraseñas no coinciden'
                      : null,
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: auth.loading ? null : _guardar,
                  child: auth.loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5))
                      : const Text('Guardar cambios'),
                ),
                const SizedBox(height: 32),

                // ── Tema ──
                _titulo(context, 'Apariencia'),
                Consumer<TemaProvider>(
                  builder: (_, temaP, __) => Wrap(
                    spacing: 8,
                    children: [
                      _chipTema(temaP, 'claro', 'Claro'),
                      _chipTema(temaP, 'oscuro', 'Oscuro'),
                      _chipTema(temaP, 'operagx', 'Gamer'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // ── Legal ──
                _titulo(context, 'Información legal'),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.description_outlined, color: cs.primary),
                  title: const Text('Términos y Condiciones'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const TerminosPage()),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.privacy_tip_outlined, color: cs.primary),
                  title: const Text('Política de tratamiento de datos'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const PoliticaDatosPage()),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _chipTema(TemaProvider temaP, String valor, String etiqueta) {
    return ChoiceChip(
      label: Text(etiqueta),
      selected: temaP.tema == valor,
      onSelected: (_) => temaP.setTema(valor),
    );
  }

  Widget _titulo(BuildContext context, String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        texto,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  String _inicial(String? nombre, String? username) {
    final base = (nombre != null && nombre.trim().isNotEmpty)
        ? nombre.trim()
        : (username ?? '').trim();
    return base.isEmpty ? '?' : base[0].toUpperCase();
  }
}
