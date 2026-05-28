import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../prediction_stats.dart';
import '../../core/widgets/app_theme.dart';  // pastikan sudah import

class MonthlyBarChart extends StatelessWidget {
  final TrenData data;

  const MonthlyBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Gunakan AppTheme.instance agar ikut rebuild saat toggle
    return ValueListenableBuilder<bool>(
      valueListenable: AppTheme.instance,
      builder: (context, isDark, _) {
        // 🎨 Palet warna sesuai AppTheme & konsisten dengan BottomNavigation
        final cardBg = isDark ? const Color(0xFF0F172A) : Colors.white;
        final borderColor = isDark
            ? const Color(0xFF4F46E5).withOpacity(0.22)
            : const Color(0xFFD1D5DB);
        final textPrimary = isDark ? Colors.white : const Color(0xFF0D0F1A);
        final textSecondary = isDark
            ? const Color(0xFF6D5FD8).withOpacity(0.70)
            : const Color(0xFF6B7280);
        final gridColor = isDark
            ? Colors.white.withOpacity(0.05)
            : Colors.black.withOpacity(0.04);
        final barColor = isDark
            ? const Color(0xFF4F46E5)
            : const Color(0xFF6C63FF);
        final tooltipBg = isDark
            ? const Color(0xFF2D1B69)
            : const Color(0xFF1A237E);

        double maxY = 5.0;
        if (data.data.isNotEmpty) {
          final maxVal = data.data.reduce((a, b) => a > b ? a : b);
          maxY = (maxVal + 2).toDouble();
        }

        if (data.data.isEmpty || data.labels.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: borderColor, width: 1.5),
              boxShadow: [
                if (isDark)
                  BoxShadow(
                    color: const Color(0xFF4F46E5).withOpacity(0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                if (isDark)
                  BoxShadow(
                    color: const Color(0xFF4F46E5).withOpacity(0.06),
                    blurRadius: 40,
                    offset: const Offset(0, 16),
                  ),
                if (isDark)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.9),
                    blurRadius: 0,
                    offset: const Offset(0, 1),
                  ),
              ],
            ),
            child: Center(
              child: Text(
                'Belum ada data prediksi',
                style: GoogleFonts.mulish(fontSize: 13, color: textSecondary),
              ),
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? const Color(0xFF4F46E5).withOpacity(0.15)
                    : const Color(0xFF071A52).withOpacity(0.09),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
              if (isDark)
                BoxShadow(
                  color: const Color(0xFF4F46E5).withOpacity(0.06),
                  blurRadius: 40,
                  offset: const Offset(0, 16),
                ),
              BoxShadow(
                color: (isDark ? Colors.black : Colors.white).withOpacity(0.9),
                blurRadius: 0,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: barColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.bar_chart_rounded, size: 16, color: barColor),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Prediksi per bulan',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: textPrimary,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: barColor.withOpacity(isDark ? 0.15 : 0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: barColor.withOpacity(isDark ? 0.35 : 0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      '2025',
                      style: GoogleFonts.nunito(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: barColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 190,
                child: BarChart(
                  BarChartData(
                    maxY: maxY,
                    minY: 0,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (_) => FlLine(
                        color: gridColor,
                        strokeWidth: 1,
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          getTitlesWidget: (value, _) => Text(
                            value.toInt().toString(),
                            style: GoogleFonts.mulish(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: textSecondary),
                          ),
                        ),
                      ),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          getTitlesWidget: (value, _) {
                            final index = value.toInt();
                            if (index < 0 || index >= data.labels.length) {
                              return const SizedBox();
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                data.labels[index],
                                style: GoogleFonts.mulish(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: textSecondary,
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
                            width: 20,
                            borderRadius: BorderRadius.circular(6),
                            color: barColor,
                          ),
                        ],
                      );
                    }),
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (_) => tooltipBg,
                        tooltipRoundedRadius: 10,
                        getTooltipItem: (group, _, rod, __) => BarTooltipItem(
                          '${rod.toY.toInt()} prediksi',
                          GoogleFonts.mulish(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}