import 'package:flutter/material.dart';
import '../../../core/widgets/app_theme.dart';
import '../detail_edukasi.dart';

class DynamicConditionCard extends StatelessWidget {
  final Map<String, dynamic> edukasi;
  const DynamicConditionCard({super.key, required this.edukasi});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppTheme.instance,
      builder: (context, isDark, _) {
        if (isDark) {
          return _buildDarkCard(context);
        }
        return _buildLightCard(context);
      },
    );
  }

  Widget _buildLightCard(BuildContext context) {
    final kategori = edukasi['kategori_gangguan_tidur'] ?? 'healthy';
    final judul = edukasi['judul_artikel'] ?? 'No Title';
    final ringkasan = edukasi['ringkasan'] ?? '';
    final isiArtikel = edukasi['isi_artikel'] ?? '';
    final penulis = edukasi['penulis'] ?? 'Admin Noctura';
    final estimasiWaktu = edukasi['estimasi_waktu_baca'] ?? '5 menit';
    final accent = _getAccentColor(kategori);
    
    String deskripsi = ringkasan.isNotEmpty ? ringkasan : isiArtikel;
    if (deskripsi.length > 100) {
      deskripsi = deskripsi.substring(0, 100) + '...';
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: accent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _getCategoryName(kategori),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: accent,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.chevron_right, size: 20, color: accent),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  judul,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  deskripsi,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF4A5568),
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.person_outline, size: 12, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      penulis,
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.access_time, size: 12, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      estimasiWaktu,
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDarkCard(BuildContext context) {
    final kategori = edukasi['kategori_gangguan_tidur'] ?? 'healthy';
    final judul = edukasi['judul_artikel'] ?? 'No Title';
    final ringkasan = edukasi['ringkasan'] ?? '';
    final isiArtikel = edukasi['isi_artikel'] ?? '';
    final penulis = edukasi['penulis'] ?? 'Admin Noctura';
    final estimasiWaktu = edukasi['estimasi_waktu_baca'] ?? '5 menit';
    final accent = _getAccentColor(kategori);
    
    String deskripsi = ringkasan.isNotEmpty ? ringkasan : isiArtikel;
    if (deskripsi.length > 100) {
      deskripsi = deskripsi.substring(0, 100) + '...';
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accent.withOpacity(0.16),
            const Color(0xFF0F0D22),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withOpacity(0.30), width: 1.0),
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.22),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: accent.withOpacity(0.45), width: 1.0),
                  ),
                  child: Text(
                    _getCategoryName(kategori),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  judul,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  deskripsi,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFFCBD5E1),
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.person_outline, size: 12, color: Colors.grey[400]),
                    const SizedBox(width: 4),
                    Text(
                      penulis,
                      style: TextStyle(fontSize: 11, color: Colors.grey[400]),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.access_time, size: 12, color: Colors.grey[400]),
                    const SizedBox(width: 4),
                    Text(
                      estimasiWaktu,
                      style: TextStyle(fontSize: 11, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getCategoryName(String kategori) {
    switch (kategori) {
      case 'insomnia': return 'INSOMNIA';
      case 'sleep_apnea': return 'SLEEP APNEA';
      case 'healthy': return 'TIDUR SEHAT';
      default: return kategori.toUpperCase();
    }
  }

  Color _getAccentColor(String kategori) {
    switch (kategori) {
      case 'insomnia': return const Color(0xFFEF5350);
      case 'sleep_apnea': return const Color(0xFF3B82F6);
      case 'healthy': return const Color(0xFF10B981);
      default: return const Color(0xFF8B5CF6);
    }
  }
}