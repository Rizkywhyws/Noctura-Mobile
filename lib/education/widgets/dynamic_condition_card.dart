import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/widgets/app_theme.dart';
import '../../../config/api_config.dart';
import '../detail_edukasi.dart';

class DynamicConditionCard extends StatelessWidget {
  final Map<String, dynamic> edukasi;
  const DynamicConditionCard({super.key, required this.edukasi});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppTheme.instance,
      builder: (context, isDark, _) {
        return _buildCard(context, isDark);
      },
    );
  }

  Widget _buildCard(BuildContext context, bool isDark) {
    final kategori = edukasi['kategori_gangguan_tidur'] ?? 'healthy';
    final judul = edukasi['judul_artikel'] ?? 'No Title';
    final penulis = edukasi['penulis'] ?? 'Admin Noctura';
    final estimasiWaktu = edukasi['estimasi_waktu_baca'] ?? '5 menit';
    final gambarArtikel = edukasi['gambar_artikel'] ?? '';
    final accent = _getAccentColor(kategori);

    final String imageUrl = ApiConfig.getImageUrl(gambarArtikel);
    final bool hasImage = imageUrl.isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isDark ? const Color(0xFF1C1836) : Colors.white,
        border: Border.all(
          color: isDark ? accent.withOpacity(0.25) : accent.withOpacity(0.12),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(isDark ? 0.07 : 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailEdukasiScreen(edukasi: edukasi),
              ),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Gambar — hanya tampil jika ada, tidak ada placeholder
              if (hasImage)
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 180,
                        color: accent.withOpacity(0.08),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: accent,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                ),

              // Konten bawah
              Padding(
                padding: EdgeInsets.fromLTRB(16, hasImage ? 14 : 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge kategori — Inter Tight
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: accent.withOpacity(isDark ? 0.20 : 0.10),
                        borderRadius: BorderRadius.circular(20),
                        border: isDark
                            ? Border.all(
                                color: accent.withOpacity(0.40), width: 1.0)
                            : null,
                      ),
                      child: Text(
                        _getCategoryName(kategori),
                        style: GoogleFonts.interTight(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: isDark ? accent.withOpacity(0.9) : accent,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Judul + panah — Sora
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            judul,
                            style: GoogleFonts.sora(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF1A237E),
                              height: 1.5,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 13,
                            color: accent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Divider
                    Divider(
                      height: 1,
                      color: isDark
                          ? Colors.white.withOpacity(0.06)
                          : Colors.black.withOpacity(0.06),
                    ),
                    const SizedBox(height: 10),

                    // Penulis & estimasi waktu — Inter Tight
                    Row(
                      children: [
                        Icon(Icons.person_outline_rounded,
                            size: 13,
                            color: isDark
                                ? Colors.grey[400]
                                : Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          penulis,
                          style: GoogleFonts.interTight(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? Colors.grey[400]
                                : Colors.grey[500],
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.schedule_rounded,
                            size: 13,
                            color: isDark
                                ? Colors.grey[400]
                                : Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          estimasiWaktu,
                          style: GoogleFonts.interTight(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? Colors.grey[400]
                                : Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getCategoryName(String kategori) {
    switch (kategori) {
      case 'insomnia':
        return 'INSOMNIA';
      case 'sleep_apnea':
        return 'SLEEP APNEA';
      case 'healthy':
        return 'TIDUR SEHAT';
      default:
        return kategori.toUpperCase();
    }
  }

  Color _getAccentColor(String kategori) {
    switch (kategori) {
      case 'insomnia':
        return const Color(0xFFEF5350);
      case 'sleep_apnea':
        return const Color(0xFF3B82F6);
      case 'healthy':
        return const Color(0xFF10B981);
      default:
        return const Color(0xFF8B5CF6);
    }
  }
}