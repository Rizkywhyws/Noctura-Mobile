import 'package:flutter/material.dart';
import '../core/widgets/app_header.dart';
import '../core/widgets/bottom_navigation.dart';
import 'widgets/condition_card.dart';
import 'sleep_condition.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  // Index 3 = EDUKASI di navbar
  int _selectedIndex = 3;
  bool _isDarkMode = false;

  void _onTabTapped(int index) {
    if (index == _selectedIndex) return;

    // Navigasi ke tab lain — temenmu yang sambungkan ke dashboard
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/prediction');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/history');
        break;
      case 3:
        break; // sudah di halaman ini
      case 4:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }

    setState(() => _selectedIndex = index);
  }

  void _toggleTheme() => setState(() => _isDarkMode = !_isDarkMode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── Header atas persis sama seperti dashboard ──
            AppHeader(
              isDarkMode: _isDarkMode,
              onThemeToggle: _toggleTheme,
            ),

            // ── Konten utama ──
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul halaman
                    const Text(
                      'Edukasi Gangguan Tidur',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A237E),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Kenali kondisi tidurmu dan cara mengatasinya\nuntuk hidup yang lebih sehat dan berkualitas.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF718096),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Kartu kondisi tidur
                    ...sleepConditions.map(
                      (condition) => ConditionCard(condition: condition),
                    ),

                    // Footer info
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFF1A237E).withOpacity(0.15),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(Icons.info_outline, size: 16, color: Color(0xFF1A237E)),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Informasi ini bersifat edukatif dan tidak menggantikan diagnosis medis. Konsultasikan ke dokter untuk penanganan lebih lanjut.',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF1A237E),
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Navbar bawah persis sama seperti dashboard ──
            SafeArea(
              top: false,
              child: BottomNavigation(
                selectedIndex: _selectedIndex,
                onTabTapped: _onTabTapped,
              ),
            ),
          ],
        ),
      ),
    );
  }
}