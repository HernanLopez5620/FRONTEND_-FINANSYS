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

    _nombreCtrl = TextEditingController(
      text: user?.nombre ?? '',
    );

    _usernameCtrl = TextEditingController(
      text: user?.username ?? '',
    );
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

    // Solo enviamos lo que realmente cambió.
    final ok = await auth.updateProfile(
      nombre: nombre != user?.nombre ? nombre : null,
      username: username != user?.username ? username : null,
      password: password.isNotEmpty ? password : null,
    );

    if (!mounted) return;

    if (ok) {
      _passCtrl.clear();
      _confirmCtrl.clear();

      AppToast.show(
        context,
        'Perfil actualizado',
        type: ToastType.success,
      );
    } else {
      AppToast.show(
        context,
        auth.error ?? 'No se pudo actualizar el perfil',
        type: ToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final auth = context.watch<AuthProvider>();

    // Si la sesión se cerró, por ejemplo por inactividad,
    // volvemos al inicio.
    if (!auth.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.of(context).popUntil((r) => r.isFirst);
        }
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
                // ─────────────────────────────
                // Avatar y datos básicos
                // ─────────────────────────────
                Center(
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: cs.primary,
                    child: Text(
                      _inicial(
                        user?.nombre,
                        user?.username,
                      ),
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: cs.onPrimary,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Nombre
                Center(
                  child: Text(
                    user?.nombre ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                // Username
                Center(
                  child: Text(
                    '@${user?.username ?? ''}',
                    style: TextStyle(
                      fontSize: 13,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                // Email
                Center(
                  child: Text(
                    user?.email ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Estado de la cuenta
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: user?.activo == true
                          ? Colors.green.withOpacity(0.12)
                          : Colors.red.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      user?.activo == true
                          ? '✅ Cuenta activa'
                          : '❌ Cuenta inactiva',
                      style: TextStyle(
                        color: user?.activo == true
                            ? Colors.green.shade600
                            : Colors.red.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                if (user?.createdAt != null) ...[
                  const SizedBox(height: 6),
                  Center(
                    child: Text(
                      'Miembro desde ${_formatDate(user!.createdAt!)}',
                      style: TextStyle(
                        color: cs.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 28),

                // ─────────────────────────────
                // Datos personales
                // ─────────────────────────────
                _titulo(
                  context,
                  'Datos personales',
                ),

                TextFormField(
                  controller: _nombreCtrl,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Nombre completo',
                    prefixIcon: const Icon(
                      Icons.badge_outlined,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Ingresa tu nombre';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 14),

                TextFormField(
                  controller: _usernameCtrl,
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    prefixIcon: const Icon(
                      Icons.person_outline_rounded,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Ingresa un nombre de usuario';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // ─────────────────────────────
                // Cambio de contraseña
                // ─────────────────────────────
                _titulo(
                  context,
                  'Cambiar contraseña (opcional)',
                ),

                TextFormField(
                  controller: _passCtrl,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: 'Nueva contraseña',
                    prefixIcon: const Icon(
                      Icons.lock_outline_rounded,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return null;
                    }

                    if (v.length < 6) {
                      return 'Mínimo 6 caracteres';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 14),

                TextFormField(
                  controller: _confirmCtrl,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: 'Confirmar contraseña',
                    prefixIcon: const Icon(
                      Icons.lock_outline_rounded,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (v) {
                    if (_passCtrl.text.isEmpty && (v == null || v.isEmpty)) {
                      return null;
                    }

                    if (v != _passCtrl.text) {
                      return 'Las contraseñas no coinciden';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // ─────────────────────────────
                // Guardar cambios
                // ─────────────────────────────
                ElevatedButton(
                  onPressed: auth.loading ? null : _guardar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: auth.loading
                      ? SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: cs.onPrimary,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text(
                          'Guardar cambios',
                        ),
                ),

                const SizedBox(height: 32),

                // ─────────────────────────────
                // Apariencia
                // ─────────────────────────────
                _titulo(
                  context,
                  'Apariencia',
                ),

                Consumer<TemaProvider>(
                  builder: (_, temaP, __) {
                    return Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _chipTema(
                          temaP,
                          'claro',
                          'Claro',
                        ),
                        _chipTema(
                          temaP,
                          'oscuro',
                          'Oscuro',
                        ),
                        _chipTema(
                          temaP,
                          'operagx',
                          'Gamer',
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 32),

                // ─────────────────────────────
                // Información legal
                // ─────────────────────────────
                _titulo(
                  context,
                  'Información legal',
                ),

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.description_outlined,
                    color: cs.primary,
                  ),
                  title: const Text(
                    'Términos y Condiciones',
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const TerminosPage(),
                      ),
                    );
                  },
                ),

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.privacy_tip_outlined,
                    color: cs.primary,
                  ),
                  title: const Text(
                    'Política de tratamiento de datos',
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const PoliticaDatosPage(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _chipTema(
    TemaProvider temaP,
    String valor,
    String etiqueta,
  ) {
    return ChoiceChip(
      label: Text(etiqueta),
      selected: temaP.tema == valor,
      onSelected: (_) => temaP.setTema(valor),
    );
  }

  Widget _titulo(
    BuildContext context,
    String texto,
  ) {
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

  String _inicial(
    String? nombre,
    String? username,
  ) {
    final base = (nombre != null && nombre.trim().isNotEmpty)
        ? nombre.trim()
        : (username ?? '').trim();

    return base.isEmpty ? '?' : base[0].toUpperCase();
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
