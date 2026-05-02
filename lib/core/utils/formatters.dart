// core/utils/formatters.dart
// SOLID-SRP: única responsabilidad — formatear valores para la UI.

import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  // ── Moneda COP completa ──
  static String toCurrency(double amount) {
    return NumberFormat.currency(
      locale: 'es_CO',
      symbol: '\$',
      decimalDigits: 0,
    ).format(amount);
  }

  // ── Moneda COP compacta ──
  static String toShortCurrency(double amount) {
    if (amount >= 1000000) {
      return '\$${(amount / 1000000).toStringAsFixed(1)}M';
    }
    if (amount >= 1000) {
      return '\$${(amount / 1000).toStringAsFixed(0)}K';
    }
    return '\$$amount';
  }

  // ── Mes y año completo ──
  static String toMonthYear(DateTime date) {
    return DateFormat('MMMM yyyy', 'es').format(date);
  }

  // ── Mes corto para gráficos ──
  static String toShortMonth(DateTime date) {
    return DateFormat('MMM', 'es').format(date).toUpperCase();
  }

  // ── Día y mes ──
  static String toDayMonth(DateTime date) {
    return DateFormat('d MMM', 'es').format(date);
  }

  // ── Fecha completa ──
  static String toFullDate(DateTime date) {
    return DateFormat('d MMM yyyy', 'es').format(date);
  }

  // ── Fecha para la API (YYYY-MM-DD) ──
  static String toApiDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // ── Porcentaje ──
  static String toPercent(double value) {
    return '${value.toStringAsFixed(1)}%';
  }
}
