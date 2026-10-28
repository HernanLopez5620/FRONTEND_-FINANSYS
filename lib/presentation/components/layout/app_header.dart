// presentation/components/layout/app_header.dart
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
  final VoidCallback? onVerAdmin; // solo se envía a cuentas administradoras

  const AppHeader({
    super.key,
    required this.resumen,
    required this.selectedMonth,
    required this.username,
    required this.onMonthChanged,
    required this.onLogout,
    this.onVerPerfil,
    this.onVerAdmin,
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
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: [
        PopupMenuItem(
          value: 'perfil',
          child: Row(children: [
            Icon(Icons.person_outline_rounded,
                size: 18, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 10),
            Text('Ver perfil',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface)),
          ]),
        ),
        if (onVerAdmin != null)
          PopupMenuItem(
            value: 'admin',
            child: Row(children: [
              Icon(Icons.admin_panel_settings_outlined,
                  size: 18, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 10),
              Text('Administración',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface)),
            ]),
          ),
        PopupMenuItem(
          value: 'logout',
          child: Row(children: [
            const Icon(Icons.logout_rounded, size: 18, color: Colors.red),
            const SizedBox(width: 10),
            const Text('Cerrar sesión', style: TextStyle(color: Colors.red)),
          ]),
        ),
      ],
    ).then((value) {
      if (value == 'perfil')
        onVerPerfil?.call();
      else if (value == 'admin')
        onVerAdmin?.call();
      else if (value == 'logout') _confirmarLogout(context);
    });
  }

  void _confirmarLogout(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Cerrar sesión', style: TextStyle(color: cs.onSurface)),
        content: Text('¿Estás seguro que deseas cerrar sesión?',
            style: TextStyle(color: cs.onSurface.withOpacity(0.7))),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancelar', style: TextStyle(color: cs.primary)),
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
    final cs = Theme.of(context).colorScheme;
    final hc = Theme.of(context).extension<AppHeaderColors>();
    final headerBg = hc?.background ?? cs.primary;
    final onHeader = hc?.foreground ?? cs.onPrimary;
    final balance = resumen?.balance ?? 0;

    return Container(
      color: headerBg,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // ── Top row ──
        Row(children: [
          Icon(Icons.account_balance_wallet_rounded, color: onHeader, size: 20),
          const SizedBox(width: 8),
          Text('FinanSys',
              style: TextStyle(
                  color: onHeader, fontSize: 18, fontWeight: FontWeight.w700)),
          const Spacer(),
          Builder(
            builder: (ctx) => GestureDetector(
              onTap: () => _mostrarMenu(ctx),
              child: CircleAvatar(
                radius: 17,
                backgroundColor: onHeader.withOpacity(0.2),
                child: Text(
                  username.isNotEmpty ? username[0].toUpperCase() : 'U',
                  style: TextStyle(
                      color: onHeader,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ]),

        const SizedBox(height: 14),

        // ── Selector de mes ──
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            icon: Icon(Icons.chevron_left_rounded, color: onHeader),
            onPressed: () => onMonthChanged(
                DateTime(selectedMonth.year, selectedMonth.month - 1)),
          ),
          Text(
            Formatters.toMonthYear(selectedMonth),
            style: TextStyle(
                color: onHeader, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right_rounded, color: onHeader),
            onPressed: selectedMonth.month == DateTime.now().month &&
                    selectedMonth.year == DateTime.now().year
                ? null
                : () => onMonthChanged(
                    DateTime(selectedMonth.year, selectedMonth.month + 1)),
          ),
        ]),

        // ── Balance ──
        Center(
          child: Column(children: [
            Text('Balance disponible',
                style:
                    TextStyle(color: onHeader.withOpacity(0.7), fontSize: 12)),
            const SizedBox(height: 4),
            Text(
              Formatters.toCurrency(balance),
              style: TextStyle(
                color: balance < 0 ? Colors.red.shade300 : onHeader,
                fontSize: 30,
                fontWeight: FontWeight.w700,
                letterSpacing: -1,
              ),
            ),
            if (balance < 0) ...[
              const SizedBox(height: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.shade700,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.warning_rounded,
                      color: Colors.white, size: 12),
                  const SizedBox(width: 4),
                  const Text('Tienes deudas este mes',
                      style: TextStyle(color: Colors.white, fontSize: 11)),
                ]),
              ),
            ],
          ]),
        ),

        const SizedBox(height: 16),

        // ── Pills ──
        Row(children: [
          _StatPill(
            icon: Icons.arrow_upward_rounded,
            label: 'Ingresos',
            value: Formatters.toShortCurrency(resumen?.ingresos ?? 0),
            color: const Color(0xFF2ECC71),
            onHeader: onHeader,
          ),
          const SizedBox(width: 8),
          _StatPill(
            icon: Icons.arrow_downward_rounded,
            label: 'Gastos',
            value: Formatters.toShortCurrency(resumen?.gastos ?? 0),
            color: const Color(0xFFFF6B6B),
            onHeader: onHeader,
          ),
          const SizedBox(width: 8),
          _StatPill(
            icon: Icons.savings_outlined,
            label: 'Ahorro',
            value: '${(resumen?.savingsPercent ?? 0).toStringAsFixed(0)}%',
            color: const Color(0xFFFFD166),
            onHeader: onHeader,
          ),
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
  final Color onHeader;

  const _StatPill({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.onHeader,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: onHeader.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(height: 5),
          Text(value,
              style: TextStyle(
                  color: onHeader, fontSize: 13, fontWeight: FontWeight.w600)),
          Text(label,
              style: TextStyle(color: onHeader.withOpacity(0.6), fontSize: 9)),
        ]),
      ),
    );
  }
}
