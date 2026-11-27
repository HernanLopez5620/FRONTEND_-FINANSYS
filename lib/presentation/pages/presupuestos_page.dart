// presentation/pages/presupuestos_page.dart
// SOLID-SRP: única responsabilidad — listar y crear presupuestos.

import 'package:flutter/material.dart';
import '../../l10n/l10n.dart';
import 'package:provider/provider.dart';
import '../providers/presupuesto_provider.dart';
import '../providers/categoria_provider.dart';
import '../components/ui/app_spinner.dart';
import '../components/ui/app_empty_state.dart';
import '../components/charts/budget_bar_widget.dart';
import '../components/modals/presupuesto_form_modal.dart';
import 'metas_ahorro_page.dart';

class PresupuestosPage extends StatefulWidget {
  const PresupuestosPage({super.key});

  @override
  State<PresupuestosPage> createState() => _PresupuestosPageState();
}

class _PresupuestosPageState extends State<PresupuestosPage> {
  final _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PresupuestoProvider>().loadBudgets(_now.month, _now.year);
      context.read<CategoriaProvider>().loadCategories();
    });
  }

  void _showAdd() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => PresupuestoFormModal(mes: _now.month, anio: _now.year),
    );
  }

  @override
  Widget build(BuildContext context) {
    final presuP = context.watch<PresupuestoProvider>();

    // Obtenemos los colores dinámicos del tema actual
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // ← Dinámico
      floatingActionButton: FloatingActionButton(
        onPressed: _showAdd,
        backgroundColor: cs.primary, // ← Dinámico
        child: Icon(Icons.add_rounded, color: cs.onPrimary),
      ),
      body: Column(children: [
        const _AccesoMetas(),
        Expanded(
          child: presuP.loading
              ? const AppSpinner()
              : presuP.presupuestos.isEmpty
                  ? AppEmptyState(
                      icon: Icons.savings_outlined,
                      title: context.l10n.budgetEmptyTitle,
                      subtitle: context.l10n.budgetEmptySubtitle,
                      actionLabel: context.l10n.budgetCreate,
                      onAction: _showAdd,
                    )
                  : ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.cardColor, // ← Dinámico
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: theme.dividerColor,
                                width: 0.5), // ← Dinámico
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.l10n.budgetMonthTitle,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: cs.onSurface)), // ← Dinámico
                              const SizedBox(height: 16),
                              ...presuP.presupuestos.map(
                                (p) => BudgetBarWidget(item: p),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
        ),
      ]),
    );
  }
}

/// Acceso a las metas de ahorro, arriba de la lista de presupuestos.
class _AccesoMetas extends StatelessWidget {
  const _AccesoMetas();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Material(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const MetasAhorroPage()),
          ),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.dividerColor, width: 0.5),
            ),
            child: Row(children: [
              const Text('🎯', style: TextStyle(fontSize: 26)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.l10n.goalsTitle,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(context.l10n.goalsAccessSubtitle,
                          style: TextStyle(
                              fontSize: 12, color: cs.onSurfaceVariant)),
                    ]),
              ),
              Icon(Icons.chevron_right_rounded, color: cs.onSurfaceVariant),
            ]),
          ),
        ),
      ),
    );
  }
}
