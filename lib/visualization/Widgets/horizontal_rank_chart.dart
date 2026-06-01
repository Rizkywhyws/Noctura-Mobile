import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../prediction_stats.dart';
import '../../core/widgets/app_theme.dart'; // pastikan import

class HorizontalRankChart extends StatelessWidget {
  final RankData data;

  const HorizontalRankChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Bungkus dengan ValueListenableBuilder agar ikut rebuild saat toggle
    return ValueListenableBuilder<bool>(
      valueListenable: AppTheme.instance,
      builder: (context, isDark, _) {
        // Palet warna mengikuti AppTheme & BottomNavigation
        final cardBg = isDark ? const Color(0xFF0F172A) : Colors.white;
        final borderColor = isDark
            ? const Color(0xFF4F46E5).withOpacity(0.22)
            : const Color(0xFFD1D5DB);
        final textPrimary = isDark ? Colors.white : const Color(0xFF0D0F1A);
        final textSecondary = isDark
            ? const Color(0xFF6D5FD8).withOpacity(0.70)
            : const Color(0xFF6B7280);

        // Warna bar peringkat tetap (emas, perak, perunggu)
        const barColors = [
          Color(0xFFF59E0B), // emas
          Color(0xFF94A3B8), // perak (diperbaiki agar kontras di dark)
          Color(0xFFB45309), // perunggu (gelap, cocok dark)
        ];
        const rankLabels = ['1st', '2nd', '3rd'];

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
                      color: const Color(0xFFF59E0B).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.emoji_events_rounded,
                        size: 16, color: Color(0xFFF59E0B)),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Urutan gangguan terbanyak',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Highlight most common
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF2D1B69).withOpacity(0.4) // ungu gelap, selaras
                      : const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFF59E0B)
                        .withOpacity(isDark ? 0.35 : 0.3),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome_rounded,
                        size: 15, color: Color(0xFFF59E0B)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Paling sering: ${data.mostCommonLabel}',
                        style: GoogleFonts.mulish(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? const Color(0xFFFCD34D)
                              : const Color(0xFF92400E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              // Daftar peringkat
              ...List.generate(data.items.length, (index) {
                final item = data.items[index];
                final color = barColors[index % barColors.length];

                return Padding(
                  padding: EdgeInsets.only(
                      bottom: index < data.items.length - 1 ? 16 : 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 38,
                            height: 22,
                            decoration: BoxDecoration(
                              color: color.withOpacity(isDark ? 0.2 : 0.1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: color.withOpacity(0.3), width: 1),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              rankLabels[index % rankLabels.length],
                              style: GoogleFonts.nunito(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: color,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              item.label,
                              style: GoogleFonts.mulish(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: textPrimary,
                              ),
                            ),
                          ),
                          Text(
                            '${item.count}x',
                            style: GoogleFonts.mulish(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: textSecondary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${item.percentage.toStringAsFixed(1)}%',
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: color,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      // Progress bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: Stack(
                          children: [
                            Container(
                              height: 8,
                              color: isDark
                                  ? Colors.white.withOpacity(0.07)
                                  : Colors.black.withOpacity(0.06),
                            ),
                            FractionallySizedBox(
                              widthFactor: item.percentage / 100,
                              child: Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(99),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}