import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'prediction_stats.dart';
import '../service/visualisasi_service.dart';
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
    _futureStats = ApiService().getPredictionStats();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF0F0E1A) : const Color(0xFFF5F6FA);

    return Scaffold(
      backgroundColor: bgColor,
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() => _loadData());
          await _futureStats;
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Statistik Tidurku',
                      style: GoogleFonts.nunito(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                        color: isDark ? Colors.white : const Color(0xFF0D0F1A),
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Ringkasan dari semua riwayat prediksi',
                      style: GoogleFonts.mulish(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? const Color(0xFF9E9AB8)
                            : const Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              sliver: SliverToBoxAdapter(
                child: FutureBuilder<PredictionStats>(
                  future: _futureStats,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildLoading(isDark);
                    }
                    if (snapshot.hasError) {
                      return _buildError(snapshot.error, isDark);
                    }
                    final data = snapshot.data!;
                    if (data.gangguan.total == 0) {
                      return _buildEmpty(isDark);
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HorizontalRankChart(data: data.rank),
                        const SizedBox(height: 16),
                        DisorderDonutChart(data: data.gangguan),
                        const SizedBox(height: 16),
                        MonthlyBarChart(data: data.tren),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading(bool isDark) {
    return SizedBox(
      height: 400,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 36,
              height: 36,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Color(0xFF10B981),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Memuat data...',
              style: GoogleFonts.mulish(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? const Color(0xFF9E9AB8)
                    : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(Object? error, bool isDark) {
    return SizedBox(
      height: 400,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.wifi_off_rounded,
                  size: 36, color: Color(0xFFEF4444)),
            ),
            const SizedBox(height: 16),
            Text(
              'Gagal memuat data',
              style: GoogleFonts.nunito(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF0D0F1A),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              error.toString(),
              style: GoogleFonts.mulish(
                fontSize: 11,
                color: isDark
                    ? const Color(0xFF9E9AB8)
                    : const Color(0xFF6B7280),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () => setState(() => _loadData()),
              icon: const Icon(Icons.refresh_rounded, size: 16),
              label: Text(
                'Coba Lagi',
                style: GoogleFonts.mulish(fontWeight: FontWeight.w700),
              ),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF10B981),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Color(0xFF10B981), width: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(bool isDark) {
    return SizedBox(
      height: 400,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1C1836)
                    : const Color(0xFFECFDF5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.nights_stay_outlined,
                  size: 40, color: Color(0xFF10B981)),
            ),
            const SizedBox(height: 20),
            Text(
              'Belum ada data prediksi',
              style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF0D0F1A),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Lakukan prediksi terlebih dahulu',
              style: GoogleFonts.mulish(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? const Color(0xFF9E9AB8)
                    : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}