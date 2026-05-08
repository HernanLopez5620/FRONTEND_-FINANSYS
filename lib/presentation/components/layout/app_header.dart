// presentation/components/layout/app_header.dart
// SOLID-SRP: única responsabilidad — header del dashboard con balance y mes.

import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/resumen_mes_entity.dart';

class AppHeader extends StatelessWidget {
  final ResumenMesEntity? resumen;
  final DateTime selectedMonth;
  final String username;
  final ValueChanged<DateTime> onMonthChanged;
  final VoidCallback onLogout;
  final VoidCallback? onVerPerfil;

  const AppHeader({
    super.key,
    required this.resumen,
    required this.selectedMonth,
    required this.username,
    required this.onMonthChanged,
    required this.onLogout,
    this.onVerPerfil,
  });

  void _mostrarMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<String>(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: [
        const PopupMenuItem(
          value: 'perfil',
          child: Row(children: [
            Icon(Icons.person_outline_rounded, size: 18),
            SizedBox(width: 10),
            Text('Ver perfil'),
          ]),
        ),
        const PopupMenuItem(
          value: 'logout',
          child: Row(children: [
            Icon(Icons.logout_rounded, size: 18, color: Colors.red),
            SizedBox(width: 10),
            Text('Cerrar sesión', style: TextStyle(color: Colors.red)),
          ]),
        ),
      ],
    ).then((value) {
      if (value == 'perfil') {
        onVerPerfil?.call();
      } else if (value == 'logout') {
        _confirmarLogout(context);
      }
    });
  }

  void _confirmarLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.of(ctx).pop();
              onLogout();
            },
            child: const Text('Cerrar sesión',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primary,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Top row
        Row(children: [
          const Icon(Icons.account_balance_wallet_rounded,
              color: Colors.white, size: 20),
          const SizedBox(width: 8),
          const Text('FinanSys',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700)),
          const Spacer(),
          Builder(
            builder: (ctx) => GestureDetector(
              onTap: () => _mostrarMenu(ctx),
              child: CircleAvatar(
                radius: 17,
                backgroundColor: Colors.white24,
                child: Text(
                  username.isNotEmpty ? username[0].toUpperCase() : 'U',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ]),
        const SizedBox(height: 14),

        // Selector de mes
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            icon: const Icon(Icons.chevron_left_rounded, color: Colors.white),
            onPressed: () => onMonthChanged(
              DateTime(selectedMonth.year, selectedMonth.month - 1),
            ),
          ),
          Text(
            Formatters.toMonthYear(selectedMonth),
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right_rounded, color: Colors.white),
            onPressed: selectedMonth.month == DateTime.now().month &&
                    selectedMonth.year == DateTime.now().year
                ? null
                : () => onMonthChanged(
                    DateTime(selectedMonth.year, selectedMonth.month + 1)),
          ),
        ]),

        // Balance
        Center(
          child: Column(children: [
            const Text('Balance disponible',
                style: TextStyle(color: Colors.white60, fontSize: 12)),
            const SizedBox(height: 4),
            Text(
              Formatters.toCurrency(resumen?.balance ?? 0),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1),
            ),
          ]),
        ),
        const SizedBox(height: 16),

        // Pills ingresos / gastos / ahorro
        Row(children: [
          _StatPill(
              icon: Icons.arrow_upward_rounded,
              label: 'Ingresos',
              value: Formatters.toShortCurrency(resumen?.ingresos ?? 0),
              color: const Color(0xFF2ECC71)),
          const SizedBox(width: 8),
          _StatPill(
              icon: Icons.arrow_downward_rounded,
              label: 'Gastos',
              value: Formatters.toShortCurrency(resumen?.gastos ?? 0),
              color: const Color(0xFFFF6B6B)),
          const SizedBox(width: 8),
          _StatPill(
              icon: Icons.savings_outlined,
              label: 'Ahorro',
              value: '${(resumen?.savingsPercent ?? 0).toStringAsFixed(0)}%',
              color: const Color(0xFFFFD166)),
        ]),
      ]),
    );
  }
}

class _StatPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatPill({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(height: 5),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
          Text(label,
              style: const TextStyle(color: Colors.white54, fontSize: 9)),
        ]),
      ),
    );
  }
}
