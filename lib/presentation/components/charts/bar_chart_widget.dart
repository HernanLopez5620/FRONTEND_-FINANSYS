// presentation/components/charts/bar_chart_widget.dart
// SOLID-SRP: única responsabilidad — renderizar gráfico de barras mensual.

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/comparacion_mensual_entity.dart';

class BarChartWidget extends StatelessWidget {
  final List<ComparacionMensualEntity> data;

  const BarChartWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(
        child: Text('Sin datos', style: TextStyle(color: AppTheme.textGrey)),
      );
    }

    final maxY = data
        .map((e) => e.ingresos > e.gastos ? e.ingresos : e.gastos)
        .reduce((a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Leyenda
        Row(children: [
          _LegendDot(color: AppTheme.primary, label: 'Ingresos'),
          const SizedBox(width: 16),
          _LegendDot(color: AppTheme.primaryLight, label: 'Gastos'),
        ]),
        const SizedBox(height: 14),
        SizedBox(
          height: 160,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: maxY * 1.2,
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: AppTheme.primaryDark,
                  getTooltipItem: (_, __, rod, ___) => BarTooltipItem(
                    Formatters.toShortCurrency(rod.toY),
                    const TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      final idx = value.toInt();
                      if (idx < 0 || idx >= data.length)
                        return const SizedBox();
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          data[idx].mesLabel,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppTheme.textGrey,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (_) =>
                    const FlLine(color: AppTheme.border, strokeWidth: 0.5),
              ),
              borderData: FlBorderData(show: false),
              barGroups: data.asMap().entries.map((entry) {
                return BarChartGroupData(
                  x: entry.key,
                  barsSpace: 4,
                  barRods: [
                    BarChartRodData(
                      toY: entry.value.ingresos,
                      color: AppTheme.primary, // verde oscuro
                      width: 10,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(4),
                      ),
                    ),
                    BarChartRodData(
                      toY: entry.value.gastos,
                      color: AppTheme.primaryLight, // ✅ verde brillante
                      width: 10,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(4),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      const SizedBox(width: 5),
      Text(
        label,
        style: const TextStyle(fontSize: 11, color: AppTheme.textGrey),
      ),
    ]);
  }
}
