// presentation/pages/importar_page.dart
// Importar movimientos desde un archivo CSV o Excel (.xlsx):
// 1) se elige el archivo, 2) se revisa qué filas son válidas, con error o duplicadas, 3) se importa.

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../domain/entities/importacion_entity.dart';
import '../../infrastructure/files/file_saver.dart';
import '../../l10n/l10n.dart';
import '../components/ui/app_spinner.dart';
import '../providers/categoria_provider.dart';
import '../providers/gasto_provider.dart';
import '../providers/importacion_provider.dart';
import '../providers/presupuesto_provider.dart';

const _maxFilasVisibles = 100;

class ImportarPage extends StatefulWidget {
  const ImportarPage({super.key});

  @override
  State<ImportarPage> createState() => _ImportarPageState();
}

class _ImportarPageState extends State<ImportarPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ImportacionProvider>().reiniciar();
      context.read<CategoriaProvider>().loadCategories();
    });
  }

  /// CSV de ejemplo con tus propias categorías (con BOM para que Excel respete las tildes).
  void _descargarPlantilla() {
    final cats = context.read<CategoriaProvider>().categorias;
    final c1 = cats.isNotEmpty ? cats.first.nombre : 'Alimentación';
    final c2 = cats.length > 1 ? cats[1].nombre : c1;
    final csv = 'fecha,monto,descripcion,categoria,tipo\n'
        '2026-11-01,25000,Almuerzo,$c1,gasto\n'
        '2026-11-02,12000,Bus,$c2,gasto\n'
        '2026-11-03,1500000,Pago,$c1,ingreso\n';
    final bytes = Uint8List.fromList([0xEF, 0xBB, 0xBF, ...utf8.encode(csv)]);
    FileSaver.guardar(
        bytes, 'plantilla_finansys.csv', 'text/csv;charset=utf-8');
  }

  Future<void> _importar() async {
    final p = context.read<ImportacionProvider>();
    final n = await p.confirmar();
    if (!mounted) return;
    if (n < 0) {
      if (p.error != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(p.error!)));
      }
      return;
    }
    context.read<GastoProvider>().loadAll();
    context.read<PresupuestoProvider>().loadAlertas();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(context.l10n.importDone(n))));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<ImportacionProvider>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: Text(context.l10n.importTitle)),
      body: p.leyendo
          ? const AppSpinner()
          : p.preview == null
              ? _inicio(context, p)
              : _revision(context, p),
    );
  }

  // ── Paso 1: elegir archivo ──
  Widget _inicio(BuildContext context, ImportacionProvider p) {
    final cs = Theme.of(context).colorScheme;
    final l = context.l10n;
    return ListView(padding: const EdgeInsets.all(20), children: [
      Icon(Icons.upload_file_rounded, size: 56, color: cs.primary),
      const SizedBox(height: 12),
      Text(l.importIntro,
          textAlign: TextAlign.center, style: const TextStyle(fontSize: 14)),
      const SizedBox(height: 8),
      Text(l.importColumns,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
      if (p.error != null) ...[
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cs.error.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12),
          ),
          child:
              Text(p.error!, style: TextStyle(color: cs.error, fontSize: 13)),
        ),
      ],
      const SizedBox(height: 24),
      FilledButton.icon(
        onPressed: p.elegirArchivo,
        icon: const Icon(Icons.folder_open_rounded),
        label: Text(l.importPick),
      ),
      const SizedBox(height: 10),
      OutlinedButton.icon(
        onPressed: _descargarPlantilla,
        icon: const Icon(Icons.download_rounded),
        label: Text(l.importTemplate),
      ),
    ]);
  }

  // ── Paso 2: revisar y confirmar ──
  Widget _revision(BuildContext context, ImportacionProvider p) {
    final cs = Theme.of(context).colorScheme;
    final l = context.l10n;
    final prev = p.preview!;
    final cats = context.watch<CategoriaProvider>().categorias;
    final aImportar = p.filasAImportar.length;
    final idsCats = cats.map((c) => c.id).toSet();
    final valorCat = p.categoriaPorDefecto != null &&
            idsCats.contains(p.categoriaPorDefecto!.id)
        ? p.categoriaPorDefecto!.id
        : null;
    final visibles = prev.filas.take(_maxFilasVisibles).toList();

    return Column(children: [
      Expanded(
        child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            children: [
              Row(children: [
                const Icon(Icons.description_outlined, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(p.nombreArchivo ?? '',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis),
                ),
                TextButton(
                    onPressed: p.elegirArchivo,
                    child: Text(l.importPickAnother)),
              ]),
              const SizedBox(height: 6),
              Wrap(spacing: 8, runSpacing: 6, children: [
                _chip(context, l.importSummaryReady(prev.validas), cs.primary),
                if (prev.conError > 0)
                  _chip(
                      context, l.importSummaryErrors(prev.conError), cs.error),
                if (prev.duplicadas > 0)
                  _chip(context, l.importSummaryDuplicates(prev.duplicadas),
                      AppTheme.warning),
              ]),
              if (prev.categoriasSinCoincidencia.isNotEmpty) ...[
                const SizedBox(height: 14),
                Text(
                  l.importUnmatched(prev.categoriasSinCoincidencia.join(', ')),
                  style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 6),
                DropdownButton<int?>(
                  value: valorCat,
                  isExpanded: true,
                  hint: Text(l.importFallbackLabel),
                  items: [
                    DropdownMenuItem<int?>(
                        value: null, child: Text(l.importFallbackNone)),
                    ...cats.map((c) => DropdownMenuItem<int?>(
                        value: c.id,
                        child: Text('${c.icono} ${c.nombre}',
                            overflow: TextOverflow.ellipsis))),
                  ],
                  onChanged: (id) => p.setCategoriaPorDefecto(
                      id == null ? null : cats.firstWhere((c) => c.id == id)),
                ),
              ],
              if (prev.duplicadas > 0)
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(l.importIncludeDuplicates(prev.duplicadas)),
                  value: p.incluirDuplicadas,
                  onChanged: p.setIncluirDuplicadas,
                ),
              const Divider(height: 24),
              ...visibles.map((f) => _fila(context, f)),
              if (prev.filas.length > visibles.length)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    l.importMoreRows(prev.filas.length - visibles.length),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                  ),
                ),
            ]),
      ),
      SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: aImportar == 0 || p.importando ? null : _importar,
              child: p.importando
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(l.importConfirm(aImportar)),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget _chip(BuildContext context, String texto, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(texto,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: color)),
    );
  }

  String _textoError(BuildContext context, String codigo) {
    final l = context.l10n;
    switch (codigo) {
      case 'INVALID_DATE':
        return l.importErrInvalidDate;
      case 'FUTURE_DATE':
        return l.importErrFutureDate;
      case 'INVALID_AMOUNT':
        return l.importErrInvalidAmount;
      case 'INVALID_TYPE':
        return l.importErrInvalidType;
      case 'UNKNOWN_CATEGORY':
        return l.importErrUnknownCategory;
      default:
        return codigo;
    }
  }

  Widget _fila(BuildContext context, ImportFilaEntity f) {
    final cs = Theme.of(context).colorScheme;
    final l = context.l10n;

    final IconData icono;
    final Color color;
    if (!f.valida) {
      icono = Icons.error_outline_rounded;
      color = cs.error;
    } else if (f.duplicada) {
      icono = Icons.content_copy_rounded;
      color = AppTheme.warning;
    } else {
      icono = Icons.check_circle_outline_rounded;
      color = cs.primary;
    }

    final fecha =
        f.fecha == null ? '—' : Formatters.toFullDate(DateTime.parse(f.fecha!));
    final detalle = <String>[
      if (f.categoriaNombre.isNotEmpty) f.categoriaNombre,
      if (f.duplicada && f.valida) l.importDuplicateTag,
      ...f.errores.map((e) => _textoError(context, e)),
    ];
    final signo = f.tipo == 'ingreso' ? '+' : '-';

    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icono, color: color),
      title: Text(
          f.descripcion.isEmpty ? '$fecha' : '$fecha · ${f.descripcion}',
          overflow: TextOverflow.ellipsis),
      subtitle: Text(
          '${l.importRowLabel(f.fila)}${detalle.isEmpty ? '' : ' · ${detalle.join(' · ')}'}',
          style: TextStyle(color: f.valida ? cs.onSurfaceVariant : cs.error)),
      trailing: f.monto == null
          ? null
          : Text('$signo${Formatters.toCurrency(f.monto!)}',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: f.tipo == 'ingreso' ? cs.primary : cs.error)),
    );
  }
}
