import 'package:flutter/material.dart';

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
    
    // 🔥 PAKAI IP KOMPUTER
    final String imageUrl = 'http://192.168.1.130:8000/storage/edukasi/5cjxsph4ah8rosh1oZN8LxXsin3UCIZW21w8X5Hl.jpg';
    
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
            Image.network(
              imageUrl,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print('Error: $error');
                return Container(
                  height: 220,
                  color: Colors.grey[300],
                  child: const Center(child: Text('Gambar tidak tersedia')),
                );
              },
            ),
            const SizedBox(height: 20),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getAccentColor(kategori).withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _getCategoryName(kategori),
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _getAccentColor(kategori)),
              ),
            ),
            const SizedBox(height: 16),
            Text(judul, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
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
            
            if (tipsPenanganan.isNotEmpty) ...[
              const Text('Tips Penanganan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              ...tipsPenanganan.map((tip) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(children: [Text('• ', style: TextStyle(color: _getAccentColor(kategori))), Expanded(child: Text(tip))]),
              )),
              const SizedBox(height: 20),
            ],
            
            const Text('Materi Edukasi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            Text(isiArtikel, style: const TextStyle(height: 1.7)),
            const SizedBox(height: 20),
            
            if (saranKonsultasi.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: _getAccentColor(kategori).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Row(children: [Icon(Icons.medical_information, size: 16, color: _getAccentColor(kategori)), const SizedBox(width: 8), Text('Saran Konsultasi', style: TextStyle(fontWeight: FontWeight.bold))]),
                    const SizedBox(height: 6),
                    Text(saranKonsultasi),
                  ],
                ),
              ),
            ],
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