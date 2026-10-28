// presentation/pages/gastos_page.dart
// SOLID-SRP: única responsabilidad — listar y gestionar movimientos.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/gasto_provider.dart';
import '../components/ui/app_spinner.dart';
import '../components/ui/app_empty_state.dart';
import '../components/modals/gasto_form_modal.dart';

class GastosPage extends StatefulWidget {
  const GastosPage({super.key});

  @override
  State<GastosPage> createState() => _GastosPageState();
}

class _GastosPageState extends State<GastosPage> {
  String _filter = 'todos';

  @override
  Widget build(BuildContext context) {
    final gastoP = context.watch<GastoProvider>();
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final filtered = _filter == 'todos'
        ? gastoP.gastos
        : gastoP.gastos.where((g) => g.tipo == _filter).toList();

    return RefreshIndicator(
      color: cs.primary, // ← Dinámico
      onRefresh: () => gastoP.loadAll(),
      child: Column(
        children: [
          // ── Filtros ──
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Row(
              children: ['todos', 'gasto', 'ingreso'].map((f) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _filter = f),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: _filter == f
                            ? cs.primary
                            : theme.cardColor, // ← Dinámico
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _filter == f
                              ? cs.primary
                              : theme.dividerColor, // ← Dinámico
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        f == 'todos'
                            ? 'Todos'
                            : f == 'gasto'
                                ? 'Gastos'
                                : 'Ingresos',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: _filter == f
                              ? cs.onPrimary
                              : cs.onSurfaceVariant, // ← Dinámico
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // ── Lista ──
          Expanded(
            child: _buildList(context, gastoP, filtered),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, GastoProvider gastoP, List filtered) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    if (gastoP.loading) {
      return const AppSpinner();
    }

    if (filtered.isEmpty) {
      return const AppEmptyState(
        icon: Icons.receipt_long_outlined,
        title: 'Sin movimientos',
        subtitle: 'Toca + para registrar uno',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
      itemCount: filtered.length,
      separatorBuilder: (_, __) => const SizedBox(height: 2),
      itemBuilder: (_, i) {
        final g = filtered[i];
        return Dismissible(
          key: Key('gasto_${g.id}'),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: cs.errorContainer, // ← Dinámico
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.delete_outline_rounded,
              color: cs.error, // ← Dinámico
            ),
          ),
          confirmDismiss: (_) async => await showDialog<bool>(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Eliminar movimiento'),
              content: Text(
                  '¿Seguro que quieres eliminar "${g.descripcion.isNotEmpty ? g.descripcion : g.categoria ?? 'este movimiento'}"?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(
                    'Eliminar',
                    style: TextStyle(color: cs.error), // ← Dinámico
                  ),
                ),
              ],
            ),
          ),
          onDismissed: (_) => gastoP.deleteExpense(g.id),
          child: GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) => GastoFormModal(gasto: g),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: theme.cardColor, // ← Dinámico
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: theme.dividerColor, width: 0.5), // ← Dinámico
              ),
              child: Row(children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: g.esGasto
                        ? cs.errorContainer // ← Dinámico
                        : (cs.surfaceVariant ?? theme.cardColor), // ← Dinámico
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Center(
                    child: Text(
                      g.icono ?? '📦',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        g.descripcion.isNotEmpty
                            ? g.descripcion
                            : g.categoria ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: cs.onSurface, // ← Dinámico
                        ),
                      ),
                      Text(
                        '${g.fecha.day}/${g.fecha.month}/${g.fecha.year}',
                        style: TextStyle(
                          fontSize: 11,
                          color: cs.onSurfaceVariant, // ← Dinámico
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${g.esGasto ? '-' : '+'}${g.monto.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: g.esGasto ? cs.error : cs.primary, // ← Dinámico
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
