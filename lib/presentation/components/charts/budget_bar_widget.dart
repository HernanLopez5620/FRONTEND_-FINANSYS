// presentation/components/charts/budget_bar_widget.dart
// SOLID-SRP: única responsabilidad — renderizar barra de progreso de presupuesto.

import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/presupuesto_entity.dart';

class BudgetBarWidget extends StatelessWidget {
  final PresupuestoEntity item;

  const BudgetBarWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final color = item.nivel == 2
        ? AppTheme.danger
        : item.nivel == 1
            ? AppTheme.warning
            : Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(children: [
        Row(children: [
          Text(item.icono, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              item.nombre,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppTheme.textDark,
              ),
            ),
          ),
          Text(
            '${Formatters.toShortCurrency(item.gastado)} / ${Formatters.toShortCurrency(item.montoLimite)} · ${item.porcentajeEntero} %',
            style: TextStyle(
              fontSize: 11,
              color: item.nivel > 0 ? color : AppTheme.textGrey,
              fontWeight: item.nivel > 0 ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ]),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: item.porcentaje,
            backgroundColor: AppTheme.bgPage,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ]),
    );
  }
}
