import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? _user;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final res = await ApiService.profile();
      if (res['ok'] == true) {
        setState(() { _user = res['user']; _loading = false; });
      } else {
        setState(() => _loading = false);
      }
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  Future<void> _logout() async {
    await ApiService.deleteToken();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgPage,
      appBar: AppBar(
        title: const Text('FinanSys'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Cerrar sesión',
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Cerrar sesión'),
                content: const Text('¿Estás seguro que deseas salir?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () { Navigator.pop(context); _logout(); },
                    child: const Text('Salir',
                        style: TextStyle(color: AppTheme.danger)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: AppTheme.primary))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ── Bienvenida ──
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white24,
                        child: Text(
                          (_user?['username'] ?? 'U')
                              .toString()
                              .substring(0, 1)
                              .toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Bienvenido,',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 13)),
                            Text(
                              _user?['username'] ?? 'Usuario',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              _user?['email'] ?? '',
                              style: const TextStyle(
                                  color: Colors.white60, fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),

                  const SizedBox(height: 28),
                  const Text('Menú principal',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textDark)),
                  const SizedBox(height: 14),

                  // ── Botones del menú ──
                  _MenuButton(
                    icon: Icons.person_outline_rounded,
                    label: 'Mi perfil',
                    subtitle: 'Ver y editar información de cuenta',
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(
                            builder: (_) => ProfileScreen(user: _user))),
                  ),
                  _MenuButton(
                    icon: Icons.attach_money_rounded,
                    label: 'Mis ingresos',
                    subtitle: 'Registrar y ver ingresos del mes',
                    onTap: () => _showComingSoon(context, 'Mis ingresos'),
                  ),
                  _MenuButton(
                    icon: Icons.receipt_long_outlined,
                    label: 'Mis gastos',
                    subtitle: 'Facturas, servicios y gastos del mes',
                    onTap: () => _showComingSoon(context, 'Mis gastos'),
                  ),
                  _MenuButton(
                    icon: Icons.bar_chart_rounded,
                    label: 'Reportes',
                    subtitle: 'Gráficos y comparativas mensuales',
                    onTap: () => _showComingSoon(context, 'Reportes'),
                  ),
                  _MenuButton(
                    icon: Icons.category_outlined,
                    label: 'Categorías',
                    subtitle: 'Gestionar categorías de gastos',
                    onTap: () => _showComingSoon(context, 'Categorías'),
                  ),
                  _MenuButton(
                    icon: Icons.settings_outlined,
                    label: 'Configuración',
                    subtitle: 'Ajustes de la aplicación',
                    onTap: () => _showComingSoon(context, 'Configuración'),
                  ),

                  const SizedBox(height: 20),

                  // Botón cerrar sesión
                  OutlinedButton.icon(
                    onPressed: _logout,
                    icon: const Icon(Icons.logout_rounded, size: 18),
                    label: const Text('Cerrar sesión'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.danger,
                      side: const BorderSide(color: AppTheme.danger),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  void _showComingSoon(BuildContext context, String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name — próximamente disponible'),
        backgroundColor: AppTheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

// ── Widget botón de menú ──
class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuButton({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.border, width: 0.5),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppTheme.primary, size: 22),
        ),
        title: Text(label,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark)),
        subtitle: Text(subtitle,
            style: const TextStyle(
                fontSize: 12, color: AppTheme.textGrey)),
        trailing: const Icon(Icons.chevron_right_rounded,
            color: AppTheme.textGrey, size: 20),
      ),
    );
  }
}
