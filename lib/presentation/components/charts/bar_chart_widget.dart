// presentation/components/charts/bar_chart_widget.dart
// SOLID-SRP: única responsabilidad — renderizar gráfico de barras mensual.

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../domain/entities/comparacion_mensual_entity.dart';

class BarChartWidget extends StatelessWidget {
  final List<ComparacionMensualEntity> data;
  const BarChartWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final inColor = Colors.green.shade400;
    final gasColor = Colors.red.shade400;
    final textColor = cs.onSurface.withOpacity(0.6);

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _maxY(),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              // Se eliminó 'getTooltipColor' para evitar el conflicto con la versión de fl_chart
              getTooltipItem: (group, gi, rod, ri) {
                final label = ri == 0 ? 'Ingresos' : 'Gastos';
                return BarTooltipItem(
                  '$label\n\$${rod.toY.toStringAsFixed(0)}',
                  TextStyle(
                      color: ri == 0 ? inColor : gasColor,
                      fontWeight: FontWeight.w600),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, m) {
                  final i = v.toInt();
                  if (i < 0 || i >= data.length) return const SizedBox();
                  return Text(data[i].mesLabel,
                      style: TextStyle(fontSize: 10, color: textColor));
                },
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) => FlLine(
              color: cs.onSurface.withOpacity(0.08),
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: data.asMap().entries.map((e) {
            final i = e.key;
            final d = e.value;
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                    toY: d.ingresos,
                    color: inColor,
                    width: 8,
                    borderRadius: BorderRadius.circular(4)),
                BarChartRodData(
                    toY: d.gastos,
                    color: gasColor,
                    width: 8,
                    borderRadius: BorderRadius.circular(4)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  double _maxY() {
    double max = 0;
    for (final d in data) {
      if (d.ingresos > max) max = d.ingresos;
      if (d.gastos > max) max = d.gastos;
    }
    return max * 1.2;
  }
}
