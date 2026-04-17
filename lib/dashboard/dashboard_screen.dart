import 'package:flutter/material.dart';
import 'widgets/app_header.dart';
import 'widgets/sleep_card.dart';
import 'widgets/prediction_button.dart';
import 'widgets/feature_grid.dart';
import 'widgets/insight_card.dart';
import 'widgets/bottom_navigation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() => _isDarkMode = !_isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final hPadding = size.width * 0.05;
    final vGap = size.height * 0.020;

    // 🔥 Responsive check
    final isSmallScreen = size.height < 700 || size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AppHeader(
              isDarkMode: _isDarkMode,
              onThemeToggle: _toggleTheme,
            ),

            Expanded(
              child: isSmallScreen
                  // 🔥 Kalau layar kecil → pakai scroll (hindari overflow)
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: hPadding,
                        vertical: 16,
                      ),
                      child: _buildContent(vGap),
                    )
                  // 🔥 Kalau layar normal → no scroll (full layout)
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: hPadding,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _buildChildren(vGap),
                      ),
                    ),
            ),

            SafeArea(
              top: false,
              child: BottomNavigation(
                selectedIndex: _selectedIndex,
                onTabTapped: (index) =>
                    setState(() => _selectedIndex = index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔥 Untuk mode scroll
  Widget _buildContent(double vGap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _buildChildren(vGap),
    );
  }

  // 🔥 Reusable children
  List<Widget> _buildChildren(double vGap) {
    return [
      const SleepCard(),
      SizedBox(height: vGap),
      const PredictionButton(),
      SizedBox(height: vGap),
      const FeatureGrid(),
      SizedBox(height: vGap),
      const InsightCard(),
    ];
  }
}