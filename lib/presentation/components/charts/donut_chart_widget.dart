// presentation/components/charts/donut_chart_widget.dart
// SOLID-SRP: única responsabilidad — renderizar gráfico de dona por categoría.

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/gasto_categoria_entity.dart';

class DonutChartWidget extends StatefulWidget {
  final List<GastoCategoriaEntity> data;

  const DonutChartWidget({super.key, required this.data});

  @override
  State<DonutChartWidget> createState() => _DonutChartWidgetState();
}

class _DonutChartWidgetState extends State<DonutChartWidget> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const Center(
        child: Text('Sin datos este mes',
            style: TextStyle(color: AppTheme.textGrey)),
      );
    }

    final total = widget.data.fold(0.0, (sum, e) => sum + e.total);
    final dataList = widget.data.toList();

    return Row(children: [
      SizedBox(
        width: 130,
        height: 130,
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (_, response) {
                setState(() {
                  _touchedIndex =
                      response?.touchedSection?.touchedSectionIndex ?? -1;
                });
              },
            ),
            borderData: FlBorderData(show: false),
            sectionsSpace: 2,
            centerSpaceRadius: 38,
            sections: List.generate(dataList.length, (index) {
              final color = AppTheme
                  .categoryColors[index % AppTheme.categoryColors.length];
              final isTouched = index == _touchedIndex;
              return PieChartSectionData(
                color: color,
                value: dataList[index].total,
                title: '',
                radius: isTouched ? 32 : 26,
              );
            }),
          ),
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Formatters.toCurrency(total),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 2),
            const Text('Total este mes',
                style: TextStyle(fontSize: 11, color: AppTheme.textGrey)),
            const SizedBox(height: 10),
            ...List.generate(
              dataList.take(5).length,
              (index) {
                final item = dataList[index];
                final color = AppTheme
                    .categoryColors[index % AppTheme.categoryColors.length];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        item.nombre,
                        style: const TextStyle(
                            fontSize: 12, color: AppTheme.textGrey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      Formatters.toShortCurrency(item.total),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textDark,
                      ),
                    ),
                  ]),
                );
              },
            ),
          ],
        ),
      ),
    ]);
  }
}
