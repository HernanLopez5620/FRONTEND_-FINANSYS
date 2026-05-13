// presentation/pages/divisas_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
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
    if (nombre.isEmpty || conversion == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Completa el nombre y realiza una conversión primero'),
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
        content: Text(ok ? '✅ Compra guardada' : '❌ Error al guardar'),
        backgroundColor: ok ? AppTheme.primary : Colors.red,
      ),
    );
    if (ok) _nombreCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final divisaP = context.watch<DivisaProvider>();
    final compraP = context.watch<CompraExtranjeraProvider>();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // ── Calculadora ──
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.bgCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.border, width: 0.5),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Calculadora de divisas',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textDark)),
            const SizedBox(height: 4),
            const Text('El resultado se actualiza automáticamente',
                style: TextStyle(fontSize: 11, color: AppTheme.textHint)),
            const SizedBox(height: 16),

            // Moneda origen + monto
            Row(children: [
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  value: _monedaOrigen,
                  decoration: InputDecoration(
                    labelText: 'De',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: _monedas
                      .map((m) => DropdownMenuItem(
                            value: m['code'],
                            child: Text(m['label']!,
                                style: const TextStyle(fontSize: 13)),
                          ))
                      .toList(),
                  onChanged: (v) {
                    setState(() => _monedaOrigen = v!);
                    _onMonedaChanged();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _montoCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    labelText: 'Monto',
                    prefixIcon: const Icon(Icons.attach_money_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    suffixIcon: divisaP.loading
                        ? const Padding(
                            padding: EdgeInsets.all(12),
                            child: SizedBox(
                                width: 16,
                                height: 16,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2)))
                        : null,
                  ),
                  onChanged: _onMontoChanged,
                ),
              ),
            ]),

            const SizedBox(height: 12),

            // Botón intercambiar
            Center(
              child: GestureDetector(
                onTap: _intercambiarMonedas,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: AppTheme.primary.withOpacity(0.3)),
                  ),
                  child: const Icon(Icons.swap_vert_rounded,
                      color: AppTheme.primary, size: 22),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Moneda destino + resultado
            Row(children: [
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  value: _monedaDestino,
                  decoration: InputDecoration(
                    labelText: 'A',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: _monedas
                      .map((m) => DropdownMenuItem(
                            value: m['code'],
                            child: Text(m['label']!,
                                style: const TextStyle(fontSize: 13)),
                          ))
                      .toList(),
                  onChanged: (v) {
                    setState(() => _monedaDestino = v!);
                    _onMonedaChanged();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: divisaP.conversion != null
                      ? Text(
                          divisaP.conversion!.montoConvertido
                              .toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primary),
                        )
                      : const Text('0.00',
                          style: TextStyle(
                              fontSize: 20, color: AppTheme.textHint)),
                ),
              ),
            ]),

            // Tasa de cambio
            if (divisaP.conversion != null) ...[
              const SizedBox(height: 8),
              Center(
                child: Text(
                  '1 ${divisaP.conversion!.monedaOrigen} = ${divisaP.conversion!.tasa.toStringAsFixed(4)} ${divisaP.conversion!.monedaDestino}',
                  style:
                      const TextStyle(fontSize: 11, color: AppTheme.textHint),
                ),
              ),
              const SizedBox(height: 16),

              // Guardar compra
              TextField(
                controller: _nombreCtrl,
                decoration: InputDecoration(
                  labelText: 'Nombre de la compra (ej: Camiseta Nike)',
                  prefixIcon: const Icon(Icons.shopping_bag_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
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
                    foregroundColor: AppTheme.primary,
                    side: const BorderSide(color: AppTheme.primary),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ]),
        ),

        const SizedBox(height: 24),

        // ── Lista de compras guardadas ──
        const Text('Compras guardadas',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark)),
        const SizedBox(height: 12),

        if (compraP.loading)
          const Center(child: CircularProgressIndicator())
        else if (compraP.compras.isEmpty)
          Container(
            padding: const EdgeInsets.all(32),
            alignment: Alignment.center,
            child: const Column(children: [
              Icon(Icons.shopping_cart_outlined,
                  size: 48, color: AppTheme.textHint),
              SizedBox(height: 8),
              Text('Sin compras guardadas',
                  style: TextStyle(color: AppTheme.textGrey)),
            ]),
          )
        else
          ...compraP.compras.map((c) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(14),
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
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Center(
                        child: Text('🛍️', style: TextStyle(fontSize: 18))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c.nombre,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textDark)),
                      Text(
                        '${c.montoOrigen.toStringAsFixed(2)} ${c.monedaOrigen} → ${c.montoCop.toStringAsFixed(0)} COP',
                        style: const TextStyle(
                            fontSize: 11, color: AppTheme.textGrey),
                      ),
                    ],
                  )),
                  GestureDetector(
                    onTap: () => compraP.eliminar(c.id),
                    child: const Icon(Icons.close_rounded,
                        size: 16, color: AppTheme.textHint),
                  ),
                ]),
              )),

        const SizedBox(height: 80),
      ],
    );
  }
}
