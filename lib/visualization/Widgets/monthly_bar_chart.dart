import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../prediction_stats.dart';

class MonthlyBarChart extends StatelessWidget {
  final TrenData data;
  
  const MonthlyBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final cardBg = isDark ? const Color(0xFF151225) : Colors.white;
    final borderColor = isDark ? const Color(0xFF2D2650) : const Color(0xFFEDF2F7);
    final titleColor = isDark ? const Color(0xFFB9ABFF) : const Color(0xFF1A237E);
    final gridColor = isDark ? const Color(0xFF1E1A35) : const Color(0xFFF0F4F8);
    final axisColor = isDark ? const Color(0xFF4A4270) : const Color(0xFF94A3B8);
    final barColor = isDark ? const Color(0xFF818CF8) : const Color(0xFF4F6FE8);
    
    // Hitung maxY dengan aman
    double maxY = 5.0;
    if (data.data.isNotEmpty) {
      int maxValue = data.data[0];
      for (int i = 1; i < data.data.length; i++) {
        if (data.data[i] > maxValue) {
          maxValue = data.data[i];
        }
      }
      maxY = (maxValue + 2).toDouble();
    }

    if (data.data.isEmpty || data.labels.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
        ),
        child: const Center(
          child: Text('Belum ada data prediksi'),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Prediksi per Bulan',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                maxY: maxY,
                minY: 0,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: gridColor,
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            fontSize: 9,
                            color: axisColor,
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= data.labels.length) {
                          return const SizedBox();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            data.labels[index],
                            style: TextStyle(
                              fontSize: 9,
                              color: axisColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: List.generate(data.data.length, (index) {
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: data.data[index].toDouble(),
                        color: barColor,
                        width: 24,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  );
                }),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => isDark ? const Color(0xFF2D2650) : const Color(0xFF1A237E),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${rod.toY.toInt()} prediksi',
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}