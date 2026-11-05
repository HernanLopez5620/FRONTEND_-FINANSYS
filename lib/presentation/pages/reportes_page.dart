// presentation/pages/reportes_page.dart
// SOLID-SRP: única responsabilidad — mostrar reportes y comparativas.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/l10n.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../providers/gasto_provider.dart';
import '../providers/reporte_provider.dart';
import '../components/ui/app_toast.dart';
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
        child: Row(children: [
          Expanded(
            child: TabBar(
              controller: _tabCtrl,
              labelColor: cs.primary, // ← Dinámico
              unselectedLabelColor: cs.onSurfaceVariant, // ← Dinámico
              indicatorColor: cs.primary, // ← Dinámico
              indicatorWeight: 2.5,
              tabs: [
                Tab(text: context.l10n.reportTabByCategory),
                Tab(text: context.l10n.reportTabMonthly),
              ],
            ),
          ),
          // Descarga del reporte del mes que está seleccionado arriba
          _BotonExportar(mes: gastoP.selectedMonth),
        ]),
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
                            Text(context.l10n.reportDistribution,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: cs.onSurface)), // ← Dinámico
                            const SizedBox(height: 16),
                            gastoP.porCategoria.isEmpty
                                ? AppEmptyState(
                                    icon: Icons.pie_chart_outline,
                                    title: context.l10n.reportNoDataMonth,
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
                              Text(context.l10n.reportDetailByCategory,
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
                            Text(context.l10n.reportIncomeVsExpenses,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: cs.onSurface)), // ← Dinámico
                            const SizedBox(height: 16),
                            gastoP.comparacion.isEmpty
                                ? AppEmptyState(
                                    icon: Icons.bar_chart_outlined,
                                    title: context.l10n.reportNoData,
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
                              Text(context.l10n.reportMonthlyComparison,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: cs.onSurface)), // ← Dinámico
                              const SizedBox(height: 12),
                              // Header
                              Row(children: [
                                const SizedBox(width: 48),
                                Expanded(
                                    child: Text(context.l10n.reportIncome,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: cs
                                                .onSurfaceVariant, // ← Dinámico
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.right)),
                                const SizedBox(width: 12),
                                Expanded(
                                    child: Text(context.l10n.reportExpenses,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: cs
                                                .onSurfaceVariant, // ← Dinámico
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.right)),
                                const SizedBox(width: 12),
                                Expanded(
                                    child: Text(context.l10n.reportBalance,
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

// ── Botón "Exportar" (PDF / Excel) del mes seleccionado ──
class _BotonExportar extends StatelessWidget {
  final DateTime mes;
  const _BotonExportar({required this.mes});

  Future<void> _exportar(BuildContext context, String formato) async {
    final p = context.read<ReporteProvider>();
    final ok = await p.exportar(
      formato: formato,
      mes: mes.month,
      anio: mes.year,
      idioma: Localizations.localeOf(context).languageCode,
      prefijoArchivo: context.l10n.reportFilePrefix,
    );
    if (!context.mounted) return;
    AppToast.show(
      context,
      ok
          ? context.l10n.reportDownloaded(formato == 'pdf' ? 'PDF' : 'Excel')
          : (p.error ?? context.l10n.reportExportFailed),
      type: ok ? ToastType.success : ToastType.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Consumer<ReporteProvider>(
      builder: (_, p, __) {
        if (p.exportando) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2.5),
            ),
          );
        }
        return PopupMenuButton<String>(
          tooltip: context.l10n.reportExportTooltip,
          icon: Icon(Icons.file_download_outlined, color: cs.primary),
          onSelected: (formato) => _exportar(context, formato),
          itemBuilder: (_) => [
            PopupMenuItem<String>(
              enabled: false,
              child: Text(
                  context.l10n.reportOfMonth(Formatters.toMonthYear(mes)),
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
            const PopupMenuDivider(),
            PopupMenuItem<String>(
              value: 'pdf',
              child: Row(children: [
                const Icon(Icons.picture_as_pdf_outlined, size: 18),
                const SizedBox(width: 10),
                Text(context.l10n.reportDownloadPdf),
              ]),
            ),
            PopupMenuItem<String>(
              value: 'xlsx',
              child: Row(children: [
                const Icon(Icons.table_chart_outlined, size: 18),
                const SizedBox(width: 10),
                Text(context.l10n.reportDownloadExcel),
              ]),
            ),
          ],
        );
      },
    );
  }
}
