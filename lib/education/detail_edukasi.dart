import 'package:flutter/material.dart';
import '../config/api_config.dart';

class DetailEdukasiScreen extends StatelessWidget {
  final Map<String, dynamic> edukasi;
  
  const DetailEdukasiScreen({super.key, required this.edukasi});

  @override
  Widget build(BuildContext context) {
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
    
    print('📸 gambar_artikel: $gambarArtikel');
    print('📸 imageUrl: $imageUrl');
    
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GAMBAR
            if (hasImage)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 220,
                        color: Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      print('❌ Image error: $error');
                      print('❌ URL: $imageUrl');
                      return Container(
                        height: 220,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.broken_image, size: 48, color: Colors.grey[400]),
                            const SizedBox(height: 8),
                            Text(
                              'Gambar tidak tersedia',
                              style: TextStyle(color: Colors.grey[600], fontSize: 12),
                            ),
                            Text(
                              imageUrl,
                              style: TextStyle(color: Colors.grey[500], fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            
            const SizedBox(height: 20),
            
            // Category Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getAccentColor(kategori).withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _getCategoryName(kategori),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _getAccentColor(kategori),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Title
            Text(
              judul,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            
            // Author & Read Time
            Row(
              children: [
                Icon(Icons.person_outline, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(penulis, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                const SizedBox(width: 16),
                Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(estimasiWaktu, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
            const SizedBox(height: 20),
            
            // Tips Penanganan
            if (tipsPenanganan.isNotEmpty) ...[
              const Text('Tips Penanganan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              ...tipsPenanganan.map<Widget>((tip) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: _getAccentColor(kategori), fontSize: 14)),
                    Expanded(child: Text(tip.toString(), style: const TextStyle(fontSize: 14))),
                  ],
                ),
              )),
              const SizedBox(height: 20),
            ],
            
            // Ringkasan
            if (ringkasan.isNotEmpty) ...[
              const Text('Ringkasan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              Text(ringkasan, style: const TextStyle(fontSize: 14, height: 1.5)),
              const SizedBox(height: 20),
            ],
            
            // Materi Lengkap
            const Text('Materi Edukasi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            Text(isiArtikel, style: const TextStyle(height: 1.7, fontSize: 14)),
            const SizedBox(height: 20),
            
            // Saran Konsultasi
            if (saranKonsultasi.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _getAccentColor(kategori).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.medical_information, size: 16, color: _getAccentColor(kategori)),
                        const SizedBox(width: 8),
                        Text(
                          'Saran Konsultasi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _getAccentColor(kategori),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(saranKonsultasi, style: const TextStyle(fontSize: 13, height: 1.5)),
                  ],
                ),
              ),
            ],
            
            const SizedBox(height: 30),
          ],
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