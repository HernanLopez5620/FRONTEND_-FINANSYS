// presentation/pages/divisas_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/divisa_provider.dart';
import '../providers/compra_extranjera_provider.dart';

class DivisasPage extends StatefulWidget {
  const DivisasPage({super.key});

  @override
  State<DivisasPage> createState() => _DivisasPageState();
}

class _DivisasPageState extends State<DivisasPage> {
  final _montoCtrl = TextEditingController();
  final _nombreCtrl = TextEditingController();

  String _monedaOrigen = 'USD';
  String _monedaDestino = 'COP';

  final List<Map<String, String>> _monedas = [
    {'code': 'USD', 'label': '🇺🇸 USD'},
    {'code': 'EUR', 'label': '🇪🇺 EUR'},
    {'code': 'GBP', 'label': '🇬🇧 GBP'},
    {'code': 'COP', 'label': '🇨🇴 COP'},
    {'code': 'MXN', 'label': '🇲🇽 MXN'},
    {'code': 'BRL', 'label': '🇧🇷 BRL'},
    {'code': 'JPY', 'label': '🇯🇵 JPY'},
    {'code': 'ARS', 'label': '🇦🇷 ARS'},
    {'code': 'CLP', 'label': '🇨🇱 CLP'},
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CompraExtranjeraProvider>().loadAll();
    });
  }

  @override
  void dispose() {
    _montoCtrl.dispose();
    _nombreCtrl.dispose();
    super.dispose();
  }

  void _onMontoChanged(String value) {
    final monto = double.tryParse(value);

    if (monto == null || monto <= 0) {
      context.read<DivisaProvider>().clearConversion();
      return;
    }

    context.read<DivisaProvider>().convertDebounced(
          monto: monto,
          de: _monedaOrigen,
          a: _monedaDestino,
        );
  }

  void _onMonedaChanged() {
    final monto = double.tryParse(_montoCtrl.text);

    if (monto != null && monto > 0) {
      context.read<DivisaProvider>().convertDebounced(
            monto: monto,
            de: _monedaOrigen,
            a: _monedaDestino,
          );
    }
  }

  void _intercambiarMonedas() {
    setState(() {
      final temp = _monedaOrigen;
      _monedaOrigen = _monedaDestino;
      _monedaDestino = temp;
    });

    _onMonedaChanged();
  }

  Future<void> _guardar() async {
    final nombre = _nombreCtrl.text.trim();
    final conversion = context.read<DivisaProvider>().conversion;
    final colorScheme = Theme.of(context).colorScheme;

    if (nombre.isEmpty || conversion == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Completa el nombre y realiza una conversión primero',
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final ok = await context.read<CompraExtranjeraProvider>().guardar(
          nombre: nombre,
          montoOrigen: conversion.montoOriginal,
          monedaOrigen: conversion.monedaOrigen,
          montoCop: conversion.montoConvertido,
          tasa: conversion.tasa,
        );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok ? '✅ Compra guardada' : '❌ Error al guardar',
        ),
        backgroundColor: ok ? colorScheme.primary : colorScheme.error,
      ),
    );

    if (ok) {
      _nombreCtrl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final divisaP = context.watch<DivisaProvider>();
    final compraP = context.watch<CompraExtranjeraProvider>();

    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // ── Calculadora ──
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.dividerColor,
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Calculadora de divisas',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                'El resultado se actualiza automáticamente',
                style: TextStyle(
                  fontSize: 11,
                  color: cs.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 16),

              // Moneda origen + monto
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<String>(
                      value: _monedaOrigen,
                      decoration: InputDecoration(
                        labelText: 'De',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      items: _monedas
                          .map(
                            (m) => DropdownMenuItem(
                              value: m['code'],
                              child: Text(
                                m['label']!,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        if (v == null) return;

                        setState(() {
                          _monedaOrigen = v;
                        });

                        _onMonedaChanged();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _montoCtrl,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Monto',
                        prefixIcon: const Icon(
                          Icons.attach_money_rounded,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: divisaP.loading
                            ? const Padding(
                                padding: EdgeInsets.all(12),
                                child: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : null,
                      ),
                      onChanged: _onMontoChanged,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Botón intercambiar
              Center(
                child: GestureDetector(
                  onTap: _intercambiarMonedas,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: cs.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: cs.primary.withOpacity(0.3),
                      ),
                    ),
                    child: Icon(
                      Icons.swap_vert_rounded,
                      color: cs.primary,
                      size: 22,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Moneda destino + resultado
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<String>(
                      value: _monedaDestino,
                      decoration: InputDecoration(
                        labelText: 'A',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      items: _monedas
                          .map(
                            (m) => DropdownMenuItem(
                              value: m['code'],
                              child: Text(
                                m['label']!,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        if (v == null) return;

                        setState(() {
                          _monedaDestino = v;
                        });

                        _onMonedaChanged();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.dividerColor,
                        ),
                      ),
                      child: divisaP.conversion != null
                          ? Text(
                              divisaP.conversion!.montoConvertido
                                  .toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: cs.primary,
                              ),
                            )
                          : Text(
                              '0.00',
                              style: TextStyle(
                                fontSize: 20,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                    ),
                  ),
                ],
              ),

              // Tasa de cambio
              if (divisaP.conversion != null) ...[
                const SizedBox(height: 8),

                Center(
                  child: Text(
                    '1 ${divisaP.conversion!.monedaOrigen} = '
                    '${divisaP.conversion!.tasa.toStringAsFixed(4)} '
                    '${divisaP.conversion!.monedaDestino}',
                    style: TextStyle(
                      fontSize: 11,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Guardar compra
                TextField(
                  controller: _nombreCtrl,
                  decoration: InputDecoration(
                    labelText: 'Nombre de la compra (ej: Camiseta Nike)',
                    prefixIcon: const Icon(
                      Icons.shopping_bag_outlined,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _guardar,
                    icon: const Icon(Icons.save_outlined),
                    label: const Text('Guardar compra'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: cs.primary,
                      side: BorderSide(
                        color: cs.primary,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: 24),

        // ── Lista de compras guardadas ──
        Text(
          'Compras guardadas',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: cs.onSurface,
          ),
        ),

        const SizedBox(height: 12),

        if (compraP.loading)
          const Center(
            child: CircularProgressIndicator(),
          )
        else if (compraP.compras.isEmpty)
          Container(
            padding: const EdgeInsets.all(32),
            alignment: Alignment.center,
            child: Column(
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 48,
                  color: cs.onSurfaceVariant,
                ),
                const SizedBox(height: 8),
                Text(
                  'Sin compras guardadas',
                  style: TextStyle(
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          )
        else
          ...compraP.compras.map(
            (c) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: theme.dividerColor,
                  width: 0.5,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: cs.surfaceVariant,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Center(
                      child: Text(
                        '🛍️',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.nombre,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: cs.onSurface,
                          ),
                        ),
                        Text(
                          '${c.montoOrigen.toStringAsFixed(2)} '
                          '${c.monedaOrigen} → '
                          '${c.montoCop.toStringAsFixed(0)} COP',
                          style: TextStyle(
                            fontSize: 11,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Eliminar compra con confirmación
                  GestureDetector(
                    onTap: () async {
                      final ok = await showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                          backgroundColor: theme.cardColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          title: Text(
                            'Eliminar compra',
                            style: TextStyle(
                              color: cs.onSurface,
                            ),
                          ),
                          content: Text(
                            '¿Seguro que quieres eliminar '
                            '"${c.nombre}"?',
                            style: TextStyle(
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(
                                'Cancelar',
                                style: TextStyle(
                                  color: cs.primary,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text(
                                'Eliminar',
                                style: TextStyle(
                                  color: cs.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );

                      if (ok == true) {
                        compraP.eliminar(c.id);
                      }
                    },
                    child: Icon(
                      Icons.close_rounded,
                      size: 16,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),

        const SizedBox(height: 80),
      ],
    );
  }
}
