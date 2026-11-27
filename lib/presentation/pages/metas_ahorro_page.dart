// presentation/pages/metas_ahorro_page.dart
// Metas de ahorro: crear una meta, aportar / retirar y ver el historial.
// No afectan los gastos ni el balance del mes: es un ahorro aparte.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../domain/entities/meta_ahorro_entity.dart';
import '../../l10n/l10n.dart';
import '../components/ui/app_empty_state.dart';
import '../components/ui/app_spinner.dart';
import '../providers/meta_ahorro_provider.dart';

/// Convierte lo que escribió el usuario ("1.000.000", "1500,50", "2500.5") en número.
double? _parseMonto(String texto) {
  var t = texto.trim().replaceAll(' ', '');
  if (t.isEmpty) return null;
  if (t.contains(',')) {
    // La coma es el decimal; los puntos son miles.
    t = t.replaceAll('.', '').replaceAll(',', '.');
  } else if (RegExp(r'^\d{1,3}(\.\d{3})+$').hasMatch(t)) {
    // Solo puntos de miles: 1.000.000
    t = t.replaceAll('.', '');
  }
  return double.tryParse(t);
}

class MetasAhorroPage extends StatefulWidget {
  const MetasAhorroPage({super.key});

  @override
  State<MetasAhorroPage> createState() => _MetasAhorroPageState();
}

class _MetasAhorroPageState extends State<MetasAhorroPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<MetaAhorroProvider>().loadAll());
  }

  Future<void> _abrirFormulario([MetaAhorroEntity? meta]) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _MetaForm(meta: meta),
    );
  }

  Future<void> _movimiento(MetaAhorroEntity meta, String tipo) async {
    final antes = meta.completada;
    final ok = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _AporteForm(meta: meta, tipo: tipo),
    );
    if (ok != true || !mounted) return;
    final despues = context.read<MetaAhorroProvider>().porId(meta.id);
    if (!antes && despues != null && despues.completada) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('🎉 ${context.l10n.goalsCompleted}')),
      );
    }
  }

  Future<void> _historial(MetaAhorroEntity meta) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _Historial(meta: meta),
    );
  }

  Future<void> _confirmarEliminar(MetaAhorroEntity m) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(context.l10n.goalsDeleteConfirm(m.nombre)),
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
      await context.read<MetaAhorroProvider>().eliminar(m.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<MetaAhorroProvider>();
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: Text(context.l10n.goalsTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirFormulario(),
        backgroundColor: cs.primary,
        icon: Icon(Icons.add_rounded, color: cs.onPrimary),
        label:
            Text(context.l10n.goalsNew, style: TextStyle(color: cs.onPrimary)),
      ),
      body: _cuerpo(context, p),
    );
  }

  Widget _cuerpo(BuildContext context, MetaAhorroProvider p) {
    if (p.loading && p.metas.isEmpty) return const AppSpinner();
    if (p.error != null && p.metas.isEmpty) {
      return AppEmptyState(
        icon: Icons.error_outline,
        title: p.error!,
        actionLabel: context.l10n.commonRetry,
        onAction: p.loadAll,
      );
    }
    if (p.metas.isEmpty) {
      return AppEmptyState(
        icon: Icons.savings_outlined,
        title: context.l10n.goalsEmptyTitle,
        subtitle: context.l10n.goalsEmptySubtitle,
      );
    }
    final cs = Theme.of(context).colorScheme;
    return RefreshIndicator(
      color: cs.primary,
      onRefresh: p.loadAll,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
        itemCount: p.metas.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) => _tarjeta(context, p.metas[i]),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, MetaAhorroEntity m) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l = context.l10n;
    final color = m.vencida ? AppTheme.warning : cs.primary;

    // Línea de estado: cumplida, vencida o cuánto ahorrar al mes
    String? estado;
    if (m.completada) {
      estado = '🎉 ${l.goalsCompleted}';
    } else if (m.vencida) {
      estado = l.goalsOverdue;
    } else if (m.sugeridoMensual != null) {
      estado = l.goalsSuggested(Formatters.toCurrency(m.sugeridoMensual!));
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 6, 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor, width: 0.5),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(m.icono, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(m.nombre,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Text(
                m.fechaLimite == null
                    ? l.goalsNoDeadline
                    : l.goalsDeadline(Formatters.toFullDate(m.fechaLimite!)),
                style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
              ),
            ]),
          ),
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'history') {
                _historial(m);
              } else if (v == 'edit') {
                _abrirFormulario(m);
              } else if (v == 'delete') {
                _confirmarEliminar(m);
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(value: 'history', child: Text(l.goalsHistory)),
              PopupMenuItem(value: 'edit', child: Text(l.commonEdit)),
              PopupMenuItem(value: 'delete', child: Text(l.commonDelete)),
            ],
          ),
        ]),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: m.porcentaje / 100,
              minHeight: 8,
              backgroundColor: cs.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l.goalsProgress(Formatters.toCurrency(m.ahorrado),
              Formatters.toCurrency(m.montoObjetivo), m.porcentaje),
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        if (estado != null) ...[
          const SizedBox(height: 2),
          Text(estado,
              style: TextStyle(
                  fontSize: 12,
                  color: m.vencida ? AppTheme.warning : cs.onSurfaceVariant)),
        ],
        const SizedBox(height: 8),
        Row(children: [
          FilledButton.tonalIcon(
            onPressed: () => _movimiento(m, 'aporte'),
            icon: const Icon(Icons.add_rounded, size: 18),
            label: Text(l.goalsDeposit),
          ),
          const SizedBox(width: 8),
          OutlinedButton.icon(
            onPressed: m.ahorrado > 0 ? () => _movimiento(m, 'retiro') : null,
            icon: const Icon(Icons.remove_rounded, size: 18),
            label: Text(l.goalsWithdraw),
          ),
        ]),
      ]),
    );
  }
}

// ─────────────────────────────────────────────
// Crear / editar meta
// ─────────────────────────────────────────────
class _MetaForm extends StatefulWidget {
  final MetaAhorroEntity? meta;
  const _MetaForm({this.meta});

  @override
  State<_MetaForm> createState() => _MetaFormState();
}

class _MetaFormState extends State<_MetaForm> {
  static const _iconos = [
    '🎯',
    '✈️',
    '🏠',
    '🚗',
    '💻',
    '🎓',
    '💍',
    '🏖️',
    '🛟',
    '🎁'
  ];

  late final TextEditingController _nombreCtrl;
  late final TextEditingController _montoCtrl;
  late String _icono;
  DateTime? _limite;
  bool _saving = false;
  String? _error;

  bool get _editando => widget.meta != null;

  @override
  void initState() {
    super.initState();
    final m = widget.meta;
    _nombreCtrl = TextEditingController(text: m?.nombre ?? '');
    _montoCtrl = TextEditingController(
        text: m == null ? '' : m.montoObjetivo.toStringAsFixed(0));
    _icono = m?.icono ?? _iconos.first;
    _limite = m?.fechaLimite;
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _montoCtrl.dispose();
    super.dispose();
  }

  Future<void> _elegirFecha() async {
    final hoy = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _limite ?? hoy.add(const Duration(days: 90)),
      firstDate: DateTime(hoy.year, hoy.month, hoy.day),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _limite = picked);
  }

  Future<void> _guardar() async {
    final nombre = _nombreCtrl.text.trim();
    final monto = _parseMonto(_montoCtrl.text);
    if (nombre.isEmpty || monto == null || monto <= 0) {
      setState(() => _error = context.l10n.goalsInvalidForm);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    final p = context.read<MetaAhorroProvider>();
    final fecha = _limite == null ? null : Formatters.toApiDate(_limite!);
    final ok = _editando
        ? await p.actualizar(widget.meta!.id, {
            'nombre': nombre,
            'icono': _icono,
            'monto_objetivo': monto,
            'fecha_limite': fecha,
          })
        : await p.crear(
            nombre: nombre,
            icono: _icono,
            montoObjetivo: monto,
            fechaLimite: fecha,
          );
    if (!mounted) return;
    if (ok) {
      Navigator.pop(context);
    } else {
      setState(() {
        _saving = false;
        _error = p.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              child: Text(_editando ? l.goalsEdit : l.goalsNew,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 16),
            Text(l.goalsIcon,
                style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
            const SizedBox(height: 6),
            Wrap(spacing: 8, runSpacing: 8, children: [
              for (final i in _iconos)
                ChoiceChip(
                  label: Text(i, style: const TextStyle(fontSize: 18)),
                  selected: _icono == i,
                  onSelected: (_) => setState(() => _icono = i),
                ),
            ]),
            const SizedBox(height: 14),
            TextField(
              controller: _nombreCtrl,
              maxLength: 100,
              decoration:
                  InputDecoration(labelText: l.goalsName, counterText: ''),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _montoCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))
              ],
              decoration:
                  InputDecoration(labelText: l.goalsTarget, prefixText: '\$ '),
            ),
            const SizedBox(height: 14),
            Row(children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _elegirFecha,
                  icon: const Icon(Icons.event_rounded, size: 18),
                  label: Text(
                      _limite == null
                          ? l.goalsNoDeadline
                          : l.goalsDeadline(Formatters.toFullDate(_limite!)),
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              if (_limite != null)
                IconButton(
                  tooltip: l.goalsClearDeadline,
                  onPressed: () => setState(() => _limite = null),
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

// ─────────────────────────────────────────────
// Aportar / retirar
// ─────────────────────────────────────────────
class _AporteForm extends StatefulWidget {
  final MetaAhorroEntity meta;
  final String tipo; // 'aporte' | 'retiro'
  const _AporteForm({required this.meta, required this.tipo});

  @override
  State<_AporteForm> createState() => _AporteFormState();
}

class _AporteFormState extends State<_AporteForm> {
  final _montoCtrl = TextEditingController();
  final _notaCtrl = TextEditingController();
  bool _saving = false;
  String? _error;

  bool get _esRetiro => widget.tipo == 'retiro';

  @override
  void dispose() {
    _montoCtrl.dispose();
    _notaCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    final monto = _parseMonto(_montoCtrl.text);
    if (monto == null || monto <= 0) {
      setState(() => _error = context.l10n.errValidationInvalidAmount);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    final p = context.read<MetaAhorroProvider>();
    final ok = await p.registrarAporte(widget.meta,
        monto: monto, tipo: widget.tipo, nota: _notaCtrl.text.trim());
    if (!mounted) return;
    if (ok) {
      Navigator.pop(context, true);
    } else {
      setState(() {
        _saving = false;
        _error = p.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l = context.l10n;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          _esRetiro
              ? l.goalsWithdrawTitle(widget.meta.nombre)
              : l.goalsDepositTitle(widget.meta.nombre),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _montoCtrl,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))
          ],
          decoration:
              InputDecoration(labelText: l.goalsAmount, prefixText: '\$ '),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _notaCtrl,
          maxLength: 255,
          decoration: InputDecoration(labelText: l.goalsNote, counterText: ''),
        ),
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
                : Text(_esRetiro ? l.goalsWithdraw : l.goalsDeposit),
          ),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────
// Historial de movimientos
// ─────────────────────────────────────────────
class _Historial extends StatefulWidget {
  final MetaAhorroEntity meta;
  const _Historial({required this.meta});

  @override
  State<_Historial> createState() => _HistorialState();
}

class _HistorialState extends State<_Historial> {
  List<AporteMetaEntity>? _items;
  String? _error;

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  Future<void> _cargar() async {
    final p = context.read<MetaAhorroProvider>();
    final items = await p.cargarAportes(widget.meta.id);
    if (!mounted) return;
    setState(() {
      _items = items;
      _error = p.error;
    });
  }

  Future<void> _eliminar(AporteMetaEntity a) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(context.l10n.goalsDeleteMovementConfirm),
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
    if (ok != true || !mounted) return;
    final p = context.read<MetaAhorroProvider>();
    final borrado = await p.eliminarAporte(widget.meta.id, a.id);
    if (!mounted) return;
    if (borrado) {
      await _cargar();
    } else if (p.error != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(p.error!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l = context.l10n;

    Widget cuerpo;
    if (_items == null) {
      cuerpo = const Padding(
          padding: EdgeInsets.all(32), child: Center(child: AppSpinner()));
    } else if (_items!.isEmpty) {
      cuerpo = Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Text(_error ?? l.goalsHistoryEmpty,
              style: TextStyle(color: cs.onSurfaceVariant)),
        ),
      );
    } else {
      cuerpo = Flexible(
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: _items!.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (_, i) {
            final a = _items![i];
            final color = a.esRetiro ? cs.error : cs.primary;
            return ListTile(
              dense: true,
              leading: Icon(
                  a.esRetiro
                      ? Icons.arrow_circle_up_rounded
                      : Icons.arrow_circle_down_rounded,
                  color: color),
              title: Text(
                  '${a.esRetiro ? '-' : '+'}${Formatters.toCurrency(a.monto.abs())}',
                  style: TextStyle(fontWeight: FontWeight.w700, color: color)),
              subtitle: Text([
                a.esRetiro ? l.goalsWithdrawal : l.goalsContribution,
                Formatters.toFullDate(a.fecha),
                if (a.nota.isNotEmpty) a.nota,
              ].join(' · ')),
              trailing: IconButton(
                tooltip: l.commonDelete,
                icon: const Icon(Icons.delete_outline_rounded, size: 20),
                onPressed: () => _eliminar(a),
              ),
            );
          },
        ),
      );
    }

    return SafeArea(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Text(
                '${widget.meta.icono} ${widget.meta.nombre} · ${l.goalsHistory}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center),
          ),
          cuerpo,
        ]),
      ),
    );
  }
}
