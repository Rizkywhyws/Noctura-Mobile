import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/api_config.dart';
import '../core/widgets/app_theme.dart';

class DetailEdukasiScreen extends StatelessWidget {
  final Map<String, dynamic> edukasi;

  const DetailEdukasiScreen({super.key, required this.edukasi});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppTheme.instance,
      builder: (context, isDark, _) {
        return _buildScreen(context, isDark);
      },
    );
  }

  Widget _buildScreen(BuildContext context, bool isDark) {
    final kategori = edukasi['kategori_gangguan_tidur'] ?? 'healthy';
    final judul = edukasi['judul_artikel'] ?? 'Detail Edukasi';
    final ringkasan = edukasi['ringkasan'] ?? '';
    final isiArtikel = edukasi['isi_artikel'] ?? 'Konten tidak tersedia';
    final penulis = edukasi['penulis'] ?? 'Admin Noctura';
    final estimasiWaktu = edukasi['estimasi_waktu_baca'] ?? '5 menit';
    final tipsPenanganan = edukasi['tips_penanganan'] ?? [];
    final saranKonsultasi = edukasi['saran_konsultasi'] ?? '';
    final gambarArtikel = edukasi['gambar_artikel'] ?? '';

    final String imageUrl = ApiConfig.getImageUrl(gambarArtikel);
    final bool hasImage = imageUrl.isNotEmpty;

    final accent = _getAccentColor(kategori);
    final bgColor = isDark ? const Color(0xFF0F0E1A) : const Color(0xFFF8F9FC);
    final surfaceColor = isDark ? const Color(0xFF1C1836) : Colors.white;
    final textPrimary = isDark ? Colors.white : const Color(0xFF0D0F1A);
    final textSecondary = isDark ? const Color(0xFF9E9AB8) : const Color(0xFF6B7280);

    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        slivers: [
          // ── SliverAppBar dengan gambar hero ──
          SliverAppBar(
            expandedHeight: hasImage ? 300 : 120,
            pinned: true,
            stretch: true,
            backgroundColor: isDark ? const Color(0xFF0F0E1A) : accent,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.3),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      size: 16, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gambar hero
                  if (hasImage)
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Container(color: accent.withOpacity(0.3));
                      },
                      errorBuilder: (_, __, ___) =>
                          Container(color: accent.withOpacity(0.2)),
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            accent,
                            accent.withOpacity(0.6),
                          ],
                        ),
                      ),
                    ),

                  // Gradient overlay dari bawah
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.65),
                          ],
                          stops: const [0.4, 1.0],
                        ),
                      ),
                    ),
                  ),

                  // Badge + judul di dalam hero
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBadge(kategori, accent, isDark: false, onDark: true),
                        const SizedBox(height: 10),
                        Text(
                          judul,
                          style: GoogleFonts.sora(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.4,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Body konten ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Meta: penulis & waktu baca
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: accent.withOpacity(isDark ? 0.2 : 0.1),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        _metaChip(
                          icon: Icons.person_outline_rounded,
                          label: penulis,
                          accent: accent,
                          textColor: textSecondary,
                        ),
                        Container(
                          width: 1,
                          height: 20,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          color: isDark
                              ? Colors.white.withOpacity(0.08)
                              : Colors.black.withOpacity(0.08),
                        ),
                        _metaChip(
                          icon: Icons.schedule_rounded,
                          label: estimasiWaktu,
                          accent: accent,
                          textColor: textSecondary,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Ringkasan
                  if (ringkasan.isNotEmpty) ...[
                    _sectionLabel('Ringkasan', accent),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: accent.withOpacity(isDark ? 0.10 : 0.06),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: accent.withOpacity(isDark ? 0.25 : 0.15),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        ringkasan,
                        style: GoogleFonts.interTight(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? Colors.white.withOpacity(0.85)
                              : textPrimary.withOpacity(0.8),
                          height: 1.65,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],

                  // Tips Penanganan
                  if (tipsPenanganan.isNotEmpty) ...[
                    _sectionLabel('Tips Penanganan', accent),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withOpacity(0.07)
                              : Colors.black.withOpacity(0.06),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: List.generate(tipsPenanganan.length, (i) {
                          final isLast = i == tipsPenanganan.length - 1;
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 13),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      margin: const EdgeInsets.only(
                                          top: 1, right: 12),
                                      decoration: BoxDecoration(
                                        color: accent.withOpacity(
                                            isDark ? 0.25 : 0.12),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${i + 1}',
                                          style: GoogleFonts.sora(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: accent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        tipsPenanganan[i].toString(),
                                        style: GoogleFonts.interTight(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: textPrimary,
                                          height: 1.55,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (!isLast)
                                Divider(
                                  height: 1,
                                  indent: 16,
                                  endIndent: 16,
                                  color: isDark
                                      ? Colors.white.withOpacity(0.06)
                                      : Colors.black.withOpacity(0.06),
                                ),
                            ],
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],

                  // Materi Edukasi
                  _sectionLabel('Materi Edukasi', accent),
                  const SizedBox(height: 12),
                  Text(
                    isiArtikel,
                    style: GoogleFonts.interTight(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: textPrimary,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Saran Konsultasi
                  if (saranKonsultasi.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: isDark
                            ? accent.withOpacity(0.12)
                            : accent.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: accent.withOpacity(isDark ? 0.35 : 0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: accent.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.medical_information_rounded,
                                  size: 18,
                                  color: accent,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Saran Konsultasi',
                                style: GoogleFonts.sora(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: accent,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            saranKonsultasi,
                            style: GoogleFonts.interTight(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: isDark
                                  ? Colors.white.withOpacity(0.8)
                                  : textPrimary.withOpacity(0.75),
                              height: 1.65,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String kategori, Color accent,
      {bool isDark = false, bool onDark = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: onDark
            ? Colors.white.withOpacity(0.15)
            : accent.withOpacity(isDark ? 0.20 : 0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: onDark
              ? Colors.white.withOpacity(0.3)
              : accent.withOpacity(isDark ? 0.40 : 0.2),
          width: 1,
        ),
      ),
      child: Text(
        _getCategoryName(kategori),
        style: GoogleFonts.interTight(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: onDark ? Colors.white : accent,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _sectionLabel(String label, Color accent) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 16,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.sora(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  Widget _metaChip({
    required IconData icon,
    required String label,
    required Color accent,
    required Color textColor,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: accent),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.interTight(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ],
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