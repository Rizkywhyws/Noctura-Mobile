import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../prediction_stats.dart';
import '../../core/widgets/app_theme.dart'; // pastikan import

class DisorderDonutChart extends StatelessWidget {
  final GangguanData data;

  const DisorderDonutChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppTheme.instance,
      builder: (context, isDark, _) {
        // Palet warna konsisten dengan AppTheme & BottomNavigation
        final cardBg = isDark ? const Color(0xFF0F172A) : Colors.white;
        final borderColor = isDark
            ? const Color(0xFF4F46E5).withOpacity(0.22)
            : const Color(0xFFD1D5DB);
        final textPrimary = isDark ? Colors.white : const Color(0xFF0D0F1A);
        final textSecondary = isDark
            ? const Color(0xFF6D5FD8).withOpacity(0.70)
            : const Color(0xFF6B7280);

        // Warna pie tetap (sudah kontras di dark)
        const List<Color> colors = [
          Color(0xFF10B981),
          Color(0xFFF59E0B),
          Color(0xFFEF4444),
          Color(0xFF8B5CF6),
        ];

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
                      color: const Color(0xFF8B5CF6).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.donut_large_rounded,
                        size: 16, color: Color(0xFF8B5CF6)),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Riwayat gangguan tidur',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            sectionsSpace: 3,
                            centerSpaceRadius: 44,
                            sections: List.generate(data.labels.length, (i) {
                              return PieChartSectionData(
                                value: data.data[i].toDouble(),
                                color: colors[i % colors.length],
                                radius: 28,
                                showTitle: false,
                              );
                            }),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              data.total.toString(),
                              style: GoogleFonts.nunito(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: textPrimary,
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'total',
                              style: GoogleFonts.mulish(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(data.labels.length, (i) {
                        final color = colors[i % colors.length];
                        final pct =
                            (data.data[i] / data.total * 100).toStringAsFixed(1);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  data.labels[i],
                                  style: GoogleFonts.mulish(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: textSecondary,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '$pct%',
                                    style: GoogleFonts.nunito(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      color: color,
                                    ),
                                  ),
                                  Text(
                                    '${data.data[i]}x',
                                    style: GoogleFonts.mulish(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}