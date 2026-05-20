import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../prediction_stats.dart';

class DisorderDonutChart extends StatelessWidget {
  final GangguanData data;
  
  const DisorderDonutChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final cardBg = isDark ? const Color(0xFF151225) : Colors.white;
    final borderColor = isDark ? const Color(0xFF2D2650) : const Color(0xFFEDF2F7);
    final titleColor = isDark ? const Color(0xFFB9ABFF) : const Color(0xFF1A237E);
    
    final List<Color> colors = [
      const Color(0xFF10B981), // Healthy - Hijau
      const Color(0xFFF59E0B), // Insomnia - Orange
      const Color(0xFFEF4444), // Sleep Apnea - Merah
      const Color(0xFF8B5CF6), // Lainnya - Ungu
    ];

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
            'Riwayat Gangguan Tidur',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: Row(
              children: [
                SizedBox(
                  width: 130,
                  height: 130,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 35,
                      sections: List.generate(data.labels.length, (index) {
                        return PieChartSectionData(
                          value: data.data[index].toDouble(),
                          color: colors[index % colors.length],
                          radius: 18,
                          showTitle: false,
                        );
                      }),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(data.labels.length, (index) {
                      final percent = (data.data[index] / data.total * 100).toStringAsFixed(1);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: colors[index % colors.length],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                data.labels[index],
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                                ),
                              ),
                            ),
                            Text(
                              '$percent%',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Total ${data.total} prediksi',
              style: TextStyle(
                fontSize: 11,
                color: isDark ? Colors.grey[500] : Colors.grey[500],
              ),
            ),
          ),
        ],
      ),
    );
  }
}