// presentation/pages/dashboard_page.dart
// SOLID-SRP: orquesta las secciones del dashboard principal.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../providers/auth_provider.dart';
import '../providers/gasto_provider.dart';
import '../providers/categoria_provider.dart';
import '../components/layout/app_header.dart';
import '../components/layout/app_nav_bar.dart';
import '../components/ui/app_spinner.dart';
import '../components/ui/app_empty_state.dart';
import '../components/ui/app_card.dart';
import '../components/charts/bar_chart_widget.dart';
import '../components/charts/donut_chart_widget.dart';
import '../components/modals/gasto_form_modal.dart';
import 'gastos_page.dart';
import 'categorias_page.dart';
import 'presupuestos_page.dart';
import 'reportes_page.dart';
import 'profile_page.dart';
import '../../domain/entities/gasto_entity.dart';
import 'divisas_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  Future<void> _loadData() async {
    await Future.wait([
      context.read<GastoProvider>().loadAll(),
      context.read<CategoriaProvider>().loadCategories(),
    ]);
  }

  void _logout() async {
    await context.read<AuthProvider>().logout();
  }

  void _verPerfil() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ProfilePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final gastoP = context.watch<GastoProvider>();

    final pages = [
      _HomeTab(onRefresh: _loadData),
      const GastosPage(),
      const ReportesPage(),
      const CategoriasPage(),
      const PresupuestosPage(),
      const DivisasPage(),
    ];

    return Scaffold(
      backgroundColor: AppTheme.bgPage,
      body: Column(children: [
        SafeArea(
          bottom: false,
          child: AppHeader(
            resumen: gastoP.resumen,
            selectedMonth: gastoP.selectedMonth,
            username: auth.user?.username ?? '',
            onMonthChanged: (m) => gastoP.setMonth(m),
            onLogout: _logout,
            onVerPerfil: _verPerfil,
          ),
        ),
        Expanded(
          child: IndexedStack(index: _currentIndex, children: pages),
        ),
      ]),
      bottomNavigationBar: AppNavBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
      floatingActionButton: _currentIndex == 0 || _currentIndex == 1
          ? FloatingActionButton.extended(
              onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (_) => const GastoFormModal(),
              ),
              backgroundColor: AppTheme.primary,
              icon: const Icon(Icons.add_rounded, color: Colors.white),
              label: const Text('Registrar',
                  style: TextStyle(color: Colors.white)),
            )
          : null,
    );
  }
}

// ── Home Tab ──
class _HomeTab extends StatelessWidget {
  final VoidCallback onRefresh;
  const _HomeTab({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final gastoP = context.watch<GastoProvider>();

    return RefreshIndicator(
      color: AppTheme.primary,
      onRefresh: () async => onRefresh(),
      child: gastoP.loading
          ? const AppSpinner()
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (gastoP.comparacion.isNotEmpty) ...[
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Comparación mensual',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textDark)),
                        const SizedBox(height: 16),
                        BarChartWidget(data: gastoP.comparacion),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (gastoP.porCategoria.isNotEmpty) ...[
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Gastos por categoría',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textDark)),
                        const SizedBox(height: 16),
                        DonutChartWidget(data: gastoP.porCategoria),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Últimos movimientos',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textDark)),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Ver todos'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (gastoP.gastos.isEmpty)
                  const AppEmptyState(
                    icon: Icons.receipt_long_outlined,
                    title: 'Sin movimientos este mes',
                    subtitle: 'Toca + para registrar el primero',
                  )
                else
                  ...gastoP.gastos.take(6).map((g) => _GastoRow(
                        gasto: g,
                        onDelete: () =>
                            context.read<GastoProvider>().deleteExpense(g.id),
                      )),
                const SizedBox(height: 80),
              ],
            ),
    );
  }
}

// ── Fila de gasto en el home ──
class _GastoRow extends StatelessWidget {
  final GastoEntity gasto;
  final VoidCallback onDelete;

  const _GastoRow({required this.gasto, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.border, width: 0.5),
      ),
      child: Row(children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: gasto.esGasto ? AppTheme.dangerSurface : AppTheme.surface,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Center(
              child: Text(gasto.icono ?? '📦',
                  style: const TextStyle(fontSize: 18))),
        ),
        const SizedBox(width: 12),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              gasto.descripcion.isNotEmpty
                  ? gasto.descripcion
                  : gasto.categoria ?? '',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textDark),
            ),
            Text('${gasto.fecha.day}/${gasto.fecha.month}/${gasto.fecha.year}',
                style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
          ],
        )),
        Text(
          '${gasto.esGasto ? '-' : '+'}${gasto.monto.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: gasto.esGasto ? AppTheme.danger : AppTheme.primaryLight,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () async {
            final nombre = gasto.descripcion.isNotEmpty
                ? gasto.descripcion
                : gasto.categoria ?? 'este movimiento';
            final ok = await showDialog<bool>(
              context: context,
              builder: (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                title: const Text('Eliminar movimiento'),
                content: Text('¿Seguro que quieres eliminar "$nombre"?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Eliminar',
                        style: TextStyle(color: AppTheme.danger)),
                  ),
                ],
              ),
            );
            if (ok == true) onDelete();
          },
          child: const Icon(Icons.close_rounded,
              size: 16, color: AppTheme.textHint),
        ),
      ]),
    );
  }
}
