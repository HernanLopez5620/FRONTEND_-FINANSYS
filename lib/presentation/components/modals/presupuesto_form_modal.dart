// presentation/components/modals/presupuesto_form_modal.dart
// SOLID-SRP: única responsabilidad — formulario para crear presupuesto.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/categoria_provider.dart';
import '../../providers/presupuesto_provider.dart';

class PresupuestoFormModal extends StatefulWidget {
  final int mes;
  final int anio;

  const PresupuestoFormModal(
      {super.key, required this.mes, required this.anio});

  @override
  State<PresupuestoFormModal> createState() => _PresupuestoFormModalState();
}

class _PresupuestoFormModalState extends State<PresupuestoFormModal> {
  final _montoCtrl = TextEditingController();
  int? _selectedCategoriaId;
  bool _saving = false;

  @override
  void dispose() {
    _montoCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_selectedCategoriaId == null || _montoCtrl.text.isEmpty) return;
    final monto = double.tryParse(_montoCtrl.text);
    if (monto == null || monto <= 0) return;

    setState(() => _saving = true);
    final ok = await context.read<PresupuestoProvider>().saveBudget(
          categoriaId: _selectedCategoriaId!,
          mes: widget.mes,
          anio: widget.anio,
          montoLimite: monto,
        );
    setState(() => _saving = false);
    if (ok && mounted) Navigator.pop(context);
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
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nuevo presupuesto',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Categoría'),
              value: _selectedCategoriaId,
              items: cats
                  .map((c) => DropdownMenuItem(
                        value: c.id,
                        child: Row(children: [
                          Text(c.icono),
                          const SizedBox(width: 8),
                          Text(c.nombre),
                        ]),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _selectedCategoriaId = v),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _montoCtrl,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Monto límite',
                prefixText: '\$ ',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2.5))
                  : const Text('Guardar presupuesto'),
            ),
          ]),
    );
  }
}
