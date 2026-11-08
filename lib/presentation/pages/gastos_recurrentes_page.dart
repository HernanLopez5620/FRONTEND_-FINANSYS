// presentation/pages/gastos_recurrentes_page.dart
// Lista y gestiona los gastos/ingresos que se repiten (arriendo, suscripciones, salario...).

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/utils/formatters.dart';
import '../../domain/entities/categoria_entity.dart';
import '../../domain/entities/gasto_recurrente_entity.dart';
import '../../l10n/l10n.dart';
import '../components/ui/app_empty_state.dart';
import '../components/ui/app_spinner.dart';
import '../providers/categoria_provider.dart';
import '../providers/gasto_provider.dart';
import '../providers/gasto_recurrente_provider.dart';

String _frecuenciaTexto(BuildContext context, String f) {
  switch (f) {
    case 'semanal':
      return context.l10n.recurFreqWeekly;
    case 'anual':
      return context.l10n.recurFreqYearly;
    default:
      return context.l10n.recurFreqMonthly;
  }
}

class GastosRecurrentesPage extends StatefulWidget {
  const GastosRecurrentesPage({super.key});

  @override
  State<GastosRecurrentesPage> createState() => _GastosRecurrentesPageState();
}

class _GastosRecurrentesPageState extends State<GastosRecurrentesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // El GET del backend registra los movimientos vencidos antes de listar
      await context.read<GastoRecurrenteProvider>().loadAll();
      if (mounted) context.read<GastoProvider>().loadAll();
    });
  }

  Future<void> _abrirFormulario() async {
    final generados = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const _RecurrenteForm(),
    );
    if (generados == null || !mounted) return;
    if (generados > 0) {
      context.read<GastoProvider>().loadAll();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.recurGenerated(generados))),
      );
    }
  }

  Future<void> _confirmarEliminar(GastoRecurrenteEntity r) async {
    final nombre = r.descripcion.isEmpty ? r.categoria : r.descripcion;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(context.l10n.recurDeleteConfirm(nombre)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(context.l10n.commonCancel)),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(context.l10n.commonDelete)),
        ],
      ),
    );
    if (ok == true && mounted) {
      await context.read<GastoRecurrenteProvider>().eliminar(r.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<GastoRecurrenteProvider>();
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: Text(context.l10n.recurTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _abrirFormulario,
        backgroundColor: cs.primary,
        icon: Icon(Icons.add_rounded, color: cs.onPrimary),
        label:
            Text(context.l10n.recurNew, style: TextStyle(color: cs.onPrimary)),
      ),
      body: _cuerpo(context, p),
    );
  }

  Widget _cuerpo(BuildContext context, GastoRecurrenteProvider p) {
    if (p.loading && p.reglas.isEmpty) return const AppSpinner();
    if (p.error != null && p.reglas.isEmpty) {
      return AppEmptyState(
        icon: Icons.error_outline,
        title: p.error!,
        actionLabel: context.l10n.commonAccept,
        onAction: p.loadAll,
      );
    }
    if (p.reglas.isEmpty) {
      return AppEmptyState(
        icon: Icons.repeat_rounded,
        title: context.l10n.recurEmptyTitle,
        subtitle: context.l10n.recurEmptySubtitle,
      );
    }
    final cs = Theme.of(context).colorScheme;
    return RefreshIndicator(
      color: cs.primary,
      onRefresh: p.loadAll,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
        itemCount: p.reglas.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, i) => _tarjeta(context, p, p.reglas[i]),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, GastoRecurrenteProvider p,
      GastoRecurrenteEntity r) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final signo = r.esGasto ? '-' : '+';
    final colorMonto = r.esGasto ? cs.error : cs.primary;
    final nombre = r.descripcion.isEmpty ? r.categoria : r.descripcion;

    final detalle = <String>[
      _frecuenciaTexto(context, r.frecuencia),
      if (r.activo)
        context.l10n.recurNext(Formatters.toFullDate(r.proximaFecha))
      else
        context.l10n.recurPaused,
      if (r.fechaFin != null)
        context.l10n.recurEnds(Formatters.toFullDate(r.fechaFin!)),
    ];

    return Opacity(
      opacity: r.activo ? 1 : 0.55,
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: theme.dividerColor, width: 0.5),
        ),
        padding: const EdgeInsets.fromLTRB(14, 12, 6, 12),
        child: Row(children: [
          Text(r.icono, style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 12),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(nombre,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Text(detalle.join(' · '),
                  style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
            ]),
          ),
          Text('$signo${Formatters.toCurrency(r.monto)}',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: colorMonto)),
          PopupMenuButton<String>(
            onSelected: (v) async {
              if (v == 'toggle') {
                await p.cambiarActivo(r, !r.activo);
              } else if (v == 'delete') {
                await _confirmarEliminar(r);
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                  value: 'toggle',
                  child: Text(r.activo
                      ? context.l10n.recurPause
                      : context.l10n.recurResume)),
              PopupMenuItem(
                  value: 'delete', child: Text(context.l10n.commonDelete)),
            ],
          ),
        ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Formulario (hoja inferior). Devuelve cuántos movimientos se registraron al crear.
// ─────────────────────────────────────────────
class _RecurrenteForm extends StatefulWidget {
  const _RecurrenteForm();

  @override
  State<_RecurrenteForm> createState() => _RecurrenteFormState();
}

class _RecurrenteFormState extends State<_RecurrenteForm> {
  final _montoCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  String _tipo = 'gasto';
  String _frecuencia = 'mensual';
  CategoriaEntity? _categoria;
  DateTime _inicio = DateTime.now();
  DateTime? _fin;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<CategoriaProvider>().loadCategories());
  }

  @override
  void dispose() {
    _montoCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _elegirFecha({required bool esInicio}) async {
    final base = esInicio ? _inicio : (_fin ?? _inicio);
    final picked = await showDatePicker(
      context: context,
      initialDate: base,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() => esInicio ? _inicio = picked : _fin = picked);
  }

  Future<void> _guardar() async {
    final monto = double.tryParse(_montoCtrl.text.replaceAll(',', '.'));
    if (monto == null || monto <= 0 || _categoria == null) {
      setState(() => _error = context.l10n.recurInvalidForm);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    final p = context.read<GastoRecurrenteProvider>();
    final generados = await p.crear(
      categoriaId: _categoria!.id,
      monto: monto,
      descripcion: _descCtrl.text.trim(),
      tipo: _tipo,
      frecuencia: _frecuencia,
      fechaInicio: Formatters.toApiDate(_inicio),
      fechaFin: _fin == null ? null : Formatters.toApiDate(_fin!),
    );
    if (!mounted) return;
    if (generados < 0) {
      setState(() {
        _saving = false;
        _error = p.error;
      });
      return;
    }
    Navigator.pop(context, generados);
  }

  @override
  Widget build(BuildContext context) {
    final cats = context.watch<CategoriaProvider>().categorias;
    final cs = Theme.of(context).colorScheme;
    final l = context.l10n;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(l.recurNew,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 16),
            SegmentedButton<String>(
              segments: [
                ButtonSegment(
                    value: 'gasto', label: Text(l.gastosFilterExpenses)),
                ButtonSegment(
                    value: 'ingreso', label: Text(l.gastosFilterIncome)),
              ],
              selected: {_tipo},
              onSelectionChanged: (s) => setState(() => _tipo = s.first),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _montoCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))
              ],
              decoration:
                  InputDecoration(labelText: l.recurAmount, prefixText: '\$ '),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descCtrl,
              maxLength: 255,
              decoration: InputDecoration(
                  labelText: l.recurDescription, counterText: ''),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<CategoriaEntity>(
              value: _categoria,
              isExpanded: true,
              decoration: InputDecoration(labelText: l.recurCategory),
              items: cats
                  .map((c) => DropdownMenuItem(
                      value: c,
                      child: Text('${c.icono} ${c.nombre}',
                          overflow: TextOverflow.ellipsis)))
                  .toList(),
              onChanged: (c) => setState(() => _categoria = c),
            ),
            const SizedBox(height: 14),
            Text(l.recurFrequency,
                style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
            const SizedBox(height: 6),
            Wrap(spacing: 8, children: [
              for (final f in const ['semanal', 'mensual', 'anual'])
                ChoiceChip(
                  label: Text(_frecuenciaTexto(context, f)),
                  selected: _frecuencia == f,
                  onSelected: (_) => setState(() => _frecuencia = f),
                ),
            ]),
            const SizedBox(height: 14),
            Row(children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _elegirFecha(esInicio: true),
                  icon: const Icon(Icons.event_rounded, size: 18),
                  label: Text(
                      '${l.recurStartDate}: ${Formatters.toFullDate(_inicio)}',
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _elegirFecha(esInicio: false),
                  icon: const Icon(Icons.event_busy_rounded, size: 18),
                  label: Text(
                      _fin == null
                          ? l.recurNoEnd
                          : '${l.recurEndDate}: ${Formatters.toFullDate(_fin!)}',
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              if (_fin != null)
                IconButton(
                  tooltip: l.recurClearEnd,
                  onPressed: () => setState(() => _fin = null),
                  icon: const Icon(Icons.close_rounded),
                ),
            ]),
            if (_error != null) ...[
              const SizedBox(height: 10),
              Text(_error!, style: TextStyle(color: cs.error, fontSize: 13)),
            ],
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _saving ? null : _guardar,
                child: _saving
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : Text(l.commonSave),
              ),
            ),
          ]),
    );
  }
}
