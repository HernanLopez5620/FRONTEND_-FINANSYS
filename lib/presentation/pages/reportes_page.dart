// presentation/pages/reportes_page.dart
// SOLID-SRP: única responsabilidad — mostrar reportes y comparativas.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../providers/gasto_provider.dart';
import '../components/ui/app_spinner.dart';
import '../components/ui/app_card.dart';
import '../components/ui/app_empty_state.dart';
import '../components/charts/bar_chart_widget.dart';
import '../components/charts/donut_chart_widget.dart';

class ReportesPage extends StatefulWidget {
  const ReportesPage({super.key});

  @override
  State<ReportesPage> createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gastoP = context.watch<GastoProvider>();
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Column(children: [
      // Tabs
      Container(
        color: theme.cardColor, // ← Dinámico
        child: TabBar(
          controller: _tabCtrl,
          labelColor: cs.primary, // ← Dinámico
          unselectedLabelColor: cs.onSurfaceVariant, // ← Dinámico
          indicatorColor: cs.primary, // ← Dinámico
          indicatorWeight: 2.5,
          tabs: const [
            Tab(text: 'Por categoría'),
            Tab(text: 'Mensual'),
          ],
        ),
      ),

      Expanded(
        child: gastoP.loading
            ? const AppSpinner()
            : TabBarView(
                controller: _tabCtrl,
                children: [
                  // ── Tab 1: Por categoría ──
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Distribución de gastos',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: cs.onSurface)), // ← Dinámico
                            const SizedBox(height: 16),
                            gastoP.porCategoria.isEmpty
                                ? const AppEmptyState(
                                    icon: Icons.pie_chart_outline,
                                    title: 'Sin datos este mes',
                                  )
                                : DonutChartWidget(data: gastoP.porCategoria),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (gastoP.porCategoria.isNotEmpty)
                        AppCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Detalle por categoría',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: cs.onSurface)), // ← Dinámico
                              const SizedBox(height: 12),
                              ...gastoP.porCategoria.asMap().entries.map((e) {
                                // Se mantiene la paleta original para los iconos/categorías
                                final color = AppTheme.categoryColors[
                                    e.key % AppTheme.categoryColors.length];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(children: [
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: color.withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(e.value.icono,
                                            style:
                                                const TextStyle(fontSize: 16)),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(e.value.nombre,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  cs.onSurface)), // ← Dinámico
                                    ),
                                    Text(Formatters.toCurrency(e.value.total),
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: cs.onSurface)), // ← Dinámico
                                  ]),
                                );
                              }),
                            ],
                          ),
                        ),
                    ],
                  ),

                  // ── Tab 2: Mensual ──
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ingresos vs. Gastos',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: cs.onSurface)), // ← Dinámico
                            const SizedBox(height: 16),
                            gastoP.comparacion.isEmpty
                                ? const AppEmptyState(
                                    icon: Icons.bar_chart_outlined,
                                    title: 'Sin datos',
                                  )
                                : BarChartWidget(data: gastoP.comparacion),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (gastoP.comparacion.isNotEmpty)
                        AppCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Comparativa mensual',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: cs.onSurface)), // ← Dinámico
                              const SizedBox(height: 12),
                              // Header
                              Row(children: [
                                const SizedBox(width: 48),
                                Expanded(
                                    child: Text('Ingresos',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: cs
                                                .onSurfaceVariant, // ← Dinámico
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.right)),
                                const SizedBox(width: 12),
                                Expanded(
                                    child: Text('Gastos',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: cs
                                                .onSurfaceVariant, // ← Dinámico
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.right)),
                                const SizedBox(width: 12),
                                Expanded(
                                    child: Text('Balance',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: cs
                                                .onSurfaceVariant, // ← Dinámico
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.right)),
                              ]),
                              Divider(
                                  color: theme.dividerColor,
                                  height: 20), // ← Dinámico
                              ...gastoP.comparacion.map((item) {
                                final isPositive = item.balance >= 0;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(children: [
                                    Container(
                                      width: 40,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: cs.surfaceVariant ??
                                            theme.cardColor, // ← Dinámico
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(item.mesLabel,
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: cs.primary), // ← Dinámico
                                          textAlign: TextAlign.center),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                        child: Text(
                                            Formatters.toShortCurrency(
                                                item.ingresos),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: cs.primary, // ← Dinámico
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.right)),
                                    const SizedBox(width: 12),
                                    Expanded(
                                        child: Text(
                                            Formatters.toShortCurrency(
                                                item.gastos),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: cs.error, // ← Dinámico
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.right)),
                                    const SizedBox(width: 12),
                                    Expanded(
                                        child: Text(
                                            '${isPositive ? '+' : ''}${Formatters.toShortCurrency(item.balance)}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: isPositive
                                                    ? cs.primary
                                                    : cs.error), // ← Dinámico
                                            textAlign: TextAlign.right)),
                                  ]),
                                );
                              }),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
      ),
    ]);
  }
}
