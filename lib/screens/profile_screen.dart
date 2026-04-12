import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic>? user;
  const ProfileScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgPage,
      appBar: AppBar(title: const Text('Mi perfil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [

          // Avatar
          const SizedBox(height: 10),
          CircleAvatar(
            radius: 48,
            backgroundColor: AppTheme.primary,
            child: Text(
              (user?['username'] ?? 'U')
                  .toString()
                  .substring(0, 1)
                  .toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 14),
          Text(user?['username'] ?? 'Usuario',
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textDark)),
          Text(user?['email'] ?? '',
              style: const TextStyle(
                  fontSize: 14, color: AppTheme.textGrey)),

          const SizedBox(height: 28),

          // Datos
          _InfoCard(
            items: [
              _InfoRow(
                icon: Icons.badge_outlined,
                label: 'ID de usuario',
                value: user?['id']?.toString() ?? '-',
              ),
              _InfoRow(
                icon: Icons.person_outline,
                label: 'Username',
                value: user?['username'] ?? '-',
              ),
              _InfoRow(
                icon: Icons.email_outlined,
                label: 'Correo electrónico',
                value: user?['email'] ?? '-',
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Estado de cuenta
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppTheme.border),
            ),
            child: Row(children: [
              const Icon(Icons.verified_rounded,
                  color: AppTheme.primary, size: 22),
              const SizedBox(width: 10),
              const Text('Cuenta activa y verificada',
                  style: TextStyle(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 14)),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<_InfoRow> items;
  const _InfoCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.border, width: 0.5),
      ),
      child: Column(
        children: items.asMap().entries.map((e) {
          final isLast = e.key == items.length - 1;
          return Column(children: [
            e.value,
            if (!isLast)
              const Divider(height: 1, indent: 54, color: AppTheme.border),
          ]);
        }).toList(),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(children: [
        Icon(icon, color: AppTheme.primary, size: 20),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 11, color: AppTheme.textGrey)),
              const SizedBox(height: 2),
              Text(value,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textDark)),
            ],
          ),
        ),
      ]),
    );
  }
}
