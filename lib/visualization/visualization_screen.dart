import 'package:flutter/material.dart';
import 'prediction_stats.dart';
import '../service/visualisasi_service.dart';
import 'widgets/stat_card.dart';
import 'widgets/disorder_donut_chart.dart';
import 'widgets/monthly_bar_chart.dart';
import 'widgets/horizontal_rank_chart.dart';

class VisualizationScreen extends StatefulWidget {
  const VisualizationScreen({super.key});

  @override
  State<VisualizationScreen> createState() => _VisualizationScreenState();
}

class _VisualizationScreenState extends State<VisualizationScreen> {
  late Future<PredictionStats> _futureStats;
  
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  
  void _loadData() {
    _futureStats = ApiService().getPredictionStats(); // ✅ Tidak perlu userId manual
  }
  
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _loadData();
        });
        await _futureStats;
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: FutureBuilder<PredictionStats>(
          future: _futureStats,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      Icon(Icons.error_outline, size: 48, color: Colors.grey[400]),
                      const SizedBox(height: 12),
                      Text(
                        'Gagal memuat data',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        snapshot.error.toString(),
                        style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _loadData();
                          });
                        },
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                ),
              );
            }
            
            final data = snapshot.data!;
            
            if (data.gangguan.total == 0) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      Icon(Icons.inbox, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'Belum ada data prediksi',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Lakukan prediksi terlebih dahulu',
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
              );
            }
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Statistik Tidurku',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ringkasan dari semua riwayat prediksi',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 20),
                
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        label: 'TOTAL PREDIKSI',
                        value: data.gangguan.total.toString(),
                        unit: 'kali',
                        badge: 'Semua waktu',
                        badgeColor: const Color(0xFFE8F8F2),
                        badgeTextColor: const Color(0xFF085041),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: StatCard(
                        label: 'TERBANYAK',
                        value: data.rank.mostCommonLabel,
                        unit: '',
                        badge: 'Peringkat 1',
                        badgeColor: const Color(0xFFFFF0EE),
                        badgeTextColor: const Color(0xFF993C1D),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                DisorderDonutChart(data: data.gangguan),
                const SizedBox(height: 16),
                
                MonthlyBarChart(data: data.tren),
                const SizedBox(height: 16),
                
                HorizontalRankChart(data: data.rank),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}