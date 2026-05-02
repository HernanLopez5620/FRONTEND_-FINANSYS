// presentation/components/modals/gasto_form_modal.dart
// SOLID-SRP: única responsabilidad — formulario para crear/editar gasto.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/gasto_entity.dart';
import '../../../domain/entities/categoria_entity.dart';
import '../../providers/gasto_provider.dart';
import '../../providers/categoria_provider.dart';

class GastoFormModal extends StatefulWidget {
  final GastoEntity? gasto; // null = crear, not null = editar

  const GastoFormModal({super.key, this.gasto});

  @override
  State<GastoFormModal> createState() => _GastoFormModalState();
}

class _GastoFormModalState extends State<GastoFormModal>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  final _montoCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  CategoriaEntity? _selectedCategoria;
  DateTime _fecha = DateTime.now();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
    if (widget.gasto != null) {
      _montoCtrl.text = widget.gasto!.monto.toString();
      _descCtrl.text = widget.gasto!.descripcion;
      _fecha = widget.gasto!.fecha;
      if (widget.gasto!.tipo == 'ingreso') _tabCtrl.index = 1;
    }
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<CategoriaProvider>().loadCategories());
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    _montoCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final monto = double.tryParse(
        _montoCtrl.text.replaceAll('.', '').replaceAll(',', '.'));
    if (monto == null || monto <= 0) return;

    final tipo = _tabCtrl.index == 0 ? 'gasto' : 'ingreso';
    if (tipo == 'gasto' && _selectedCategoria == null) return;

    setState(() => _saving = true);

    final gasto = GastoEntity(
      id: widget.gasto?.id ?? 0,
      monto: monto,
      descripcion: _descCtrl.text.trim(),
      fecha: _fecha,
      tipo: tipo,
      categoriaId: _selectedCategoria?.id,
      categoria: _selectedCategoria?.nombre,
      icono: _selectedCategoria?.icono,
      color: _selectedCategoria?.color,
    );

    bool ok;
    if (widget.gasto != null) {
      ok = await context
          .read<GastoProvider>()
          .updateExpense(widget.gasto!.id, gasto);
    } else {
      ok = await context.read<GastoProvider>().createExpense(gasto);
    }

    setState(() => _saving = false);
    if (ok && mounted) Navigator.pop(context);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fecha,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: AppTheme.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _fecha = picked);
  }

  @override
  Widget build(BuildContext context) {
    final cats = context.watch<CategoriaProvider>().categorias;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          widget.gasto != null ? 'Editar movimiento' : 'Nuevo movimiento',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),

        // Tab gasto / ingreso
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(3),
          child: TabBar(
            controller: _tabCtrl,
            labelColor: Colors.white,
            unselectedLabelColor: AppTheme.primary,
            indicator: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            tabs: const [Tab(text: 'Gasto'), Tab(text: 'Ingreso')],
          ),
        ),
        const SizedBox(height: 16),

        // Monto
        TextFormField(
          controller: _montoCtrl,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[\d.,]'))
          ],
          decoration: const InputDecoration(
            labelText: 'Monto',
            prefixText: '\$ ',
          ),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 14),

        // Descripción
        TextFormField(
          controller: _descCtrl,
          decoration: const InputDecoration(
            labelText: 'Descripción (opcional)',
            prefixIcon:
                Icon(Icons.notes_rounded, size: 20, color: AppTheme.textGrey),
          ),
        ),
        const SizedBox(height: 14),

        // Categorías (solo en tab Gasto)
        AnimatedBuilder(
          animation: _tabCtrl,
          builder: (_, __) {
            if (_tabCtrl.index != 0) return const SizedBox.shrink();
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Categoría',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textGrey)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: cats.map((cat) {
                      final sel = _selectedCategoria?.id == cat.id;
                      Color color;
                      try {
                        color = Color(
                            int.parse(cat.color.replaceFirst('#', '0xFF')));
                      } catch (_) {
                        color = AppTheme.primary;
                      }
                      return GestureDetector(
                        onTap: () => setState(() => _selectedCategoria = cat),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color:
                                sel ? color.withOpacity(0.12) : AppTheme.bgCard,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: sel ? color : AppTheme.border,
                              width: sel ? 1.5 : 0.5,
                            ),
                          ),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Text(cat.icono,
                                style: const TextStyle(fontSize: 15)),
                            const SizedBox(width: 6),
                            Text(cat.nombre,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: sel ? color : AppTheme.textDark,
                                )),
                          ]),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 14),
                ]);
          },
        ),

        // Fecha
        GestureDetector(
          onTap: _pickDate,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppTheme.bgInput,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.border, width: 0.5),
            ),
            child: Row(children: [
              const Icon(Icons.calendar_today_outlined,
                  size: 18, color: AppTheme.textGrey),
              const SizedBox(width: 10),
              Text('${_fecha.day}/${_fecha.month}/${_fecha.year}',
                  style:
                      const TextStyle(fontSize: 15, color: AppTheme.textDark)),
              const Spacer(),
              const Icon(Icons.chevron_right_rounded,
                  size: 18, color: AppTheme.textHint),
            ]),
          ),
        ),
        const SizedBox(height: 20),

        // Botón guardar
        ElevatedButton(
          onPressed: _saving ? null : _save,
          child: _saving
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2.5))
              : Text(widget.gasto != null ? 'Actualizar' : 'Guardar'),
        ),
      ]),
    );
  }
}
