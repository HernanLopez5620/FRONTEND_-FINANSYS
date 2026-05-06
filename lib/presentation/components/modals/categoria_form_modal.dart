// presentation/components/modals/categoria_form_modal.dart
// SOLID-SRP: única responsabilidad — formulario para crear categoría.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/categoria_entity.dart';
import '../../providers/categoria_provider.dart';

class CategoriaFormModal extends StatefulWidget {
  const CategoriaFormModal({super.key});

  @override
  State<CategoriaFormModal> createState() => _CategoriaFormModalState();
}

class _CategoriaFormModalState extends State<CategoriaFormModal> {
  final _nombreCtrl = TextEditingController();
  String _selectedIcon = '📦';
  String _selectedTipo = 'gasto';
  int _selectedColor = 0;
  bool _saving = false;

  static const _iconos = [
    '🏠',
    '⚡',
    '💧',
    '📱',
    '🌐',
    '🚗',
    '🏥',
    '📚',
    '🍔',
    '☕',
    '✈️',
    '🎬',
    '👗',
    '💊',
    '📦',
    '🛒',
    '💼',
    '🎮',
    '🐾',
    '🎁',
  ];

  @override
  void dispose() {
    _nombreCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_nombreCtrl.text.isEmpty) return;
    setState(() => _saving = true);

    final color = AppTheme.categoryColors[_selectedColor];
    final colorHex =
        '#${color.value.toRadixString(16).substring(2).toUpperCase()}';

    final ok = await context.read<CategoriaProvider>().createCategory(
          CategoriaEntity(
            id: 0,
            nombre: _nombreCtrl.text.trim(),
            icono: _selectedIcon,
            color: colorHex,
            tipo: _selectedTipo,
          ),
        );

    setState(() => _saving = false);
    if (ok && mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
            const Text('Nueva categoría',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),

            TextFormField(
              controller: _nombreCtrl,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                prefixIcon: Icon(Icons.label_outline,
                    size: 20, color: AppTheme.textGrey),
              ),
            ),
            const SizedBox(height: 14),

            // Tipo
            const Text('Tipo',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textGrey)),
            const SizedBox(height: 8),
            Row(
                children: ['gasto', 'ingreso']
                    .map((t) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedTipo = t),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: _selectedTipo == t
                                      ? AppTheme.surface
                                      : AppTheme.bgCard,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: _selectedTipo == t
                                        ? AppTheme.primary
                                        : AppTheme.border,
                                    width: _selectedTipo == t ? 1.5 : 0.5,
                                  ),
                                ),
                                child: Center(
                                    child: Text(t,
                                        style: TextStyle(
                                          color: _selectedTipo == t
                                              ? AppTheme.primary
                                              : AppTheme.textDark,
                                          fontWeight: FontWeight.w500,
                                        ))),
                              ),
                            ),
                          ),
                        ))
                    .toList()),
            const SizedBox(height: 14),

            // Ícono
            const Text('Ícono',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textGrey)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _iconos
                  .map((ico) => GestureDetector(
                        onTap: () => setState(() => _selectedIcon = ico),
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: _selectedIcon == ico
                                ? AppTheme.surface
                                : AppTheme.bgInput,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: _selectedIcon == ico
                                  ? AppTheme.primary
                                  : AppTheme.border,
                              width: _selectedIcon == ico ? 1.5 : 0.5,
                            ),
                          ),
                          child: Center(
                              child: Text(ico,
                                  style: const TextStyle(fontSize: 18))),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 14),

            // Color
            const Text('Color',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textGrey)),
            const SizedBox(height: 8),
            Row(
              children: AppTheme.categoryColors
                  .asMap()
                  .entries
                  .map((e) => GestureDetector(
                        onTap: () => setState(() => _selectedColor = e.key),
                        child: Container(
                          width: 28,
                          height: 28,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: e.value,
                            shape: BoxShape.circle,
                            border: _selectedColor == e.key
                                ? Border.all(
                                    color: AppTheme.textDark, width: 2.5)
                                : null,
                          ),
                          child: _selectedColor == e.key
                              ? const Icon(Icons.check_rounded,
                                  color: Colors.white, size: 14)
                              : null,
                        ),
                      ))
                  .toList(),
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
                  : const Text('Crear categoría'),
            ),
          ]),
    );
  }
}
