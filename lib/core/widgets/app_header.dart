import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final VoidCallback? onThemeToggle;
  final VoidCallback? onHistoryTap;
  final bool isDarkMode;

  const AppHeader({
    super.key,
    this.onThemeToggle,
    this.onHistoryTap,
    this.isDarkMode = false,
  });

  static const _lightBg = Color(0xFFF8FAFC);
  static const _darkBg = Color(0xFF1E293B);

  static const _lightBorder = Color(0xFFE2E8F0);
  static const _darkBorder = Color(0xFF475569);

  static const _textPrimary = Color(0xFF0F172A);
  static const _textSecondary = Color(0xFF64748B);

  static const _notifRed = Color(0xFFEF5350);
  static const _onlineGreen = Color(0xFF22C55E);
  static const _blue = Color(0xFF2563EB);
  static const _blueSoft = Color(0xFFEAF2FF);

  @override
  Widget build(BuildContext context) {
    final greeting = _getGreeting();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const _Avatar(),
                  const SizedBox(width: 12),
                  _TitleSection(greeting: greeting),
                ],
              ),
              Row(
                children: [
                  _CircleButton(
                    isDarkMode: isDarkMode,
                    icon: isDarkMode
                        ? Icons.light_mode_outlined
                        : Icons.dark_mode_outlined,
                    onTap: onThemeToggle,
                  ),
                  const SizedBox(width: 8),
                  _HistoryButton(
                    isDarkMode: isDarkMode,
                    onTap: onHistoryTap,
                  ),
                  const SizedBox(width: 8),
                  const _NotificationButton(),
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: _lightBorder.withOpacity(0.75),
          thickness: 0.6,
          height: 0.6,
        ),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Selamat pagi';
    if (hour < 15) return 'Selamat siang';
    if (hour < 18) return 'Selamat sore';
    return 'Selamat malam';
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFEAF2FF),
                  Color(0xFFDCEBFF),
                ],
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.85),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2563EB).withOpacity(0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Color(0xFF2563EB),
              size: 22,
            ),
          ),
          Positioned(
            bottom: 1,
            right: 1,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: AppHeader._onlineGreen,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  final String greeting;

  const _TitleSection({required this.greeting});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Noctura',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppHeader._textPrimary,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          greeting,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppHeader._textSecondary,
          ),
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  final bool isDarkMode;
  final IconData icon;
  final VoidCallback? onTap;

  const _CircleButton({
    required this.isDarkMode,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isDarkMode ? AppHeader._darkBg : AppHeader._lightBg;
    final border =
        isDarkMode ? AppHeader._darkBorder : AppHeader._lightBorder;
    final iconColor =
        isDarkMode ? Colors.white : const Color(0xFF334155);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          border: Border.all(color: border, width: 1),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F172A).withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, size: 18, color: iconColor),
      ),
    );
  }
}

class _HistoryButton extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback? onTap;

  const _HistoryButton({
    required this.isDarkMode,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final border =
        isDarkMode ? AppHeader._darkBorder : AppHeader._lightBorder;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppHeader._blue,
              Color(0xFF4F7DF3),
            ],
          ),
          shape: BoxShape.circle,
          border: Border.all(
            color: border.withOpacity(0.35),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppHeader._blue.withOpacity(0.22),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.history_rounded,
          size: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFFFFF),
                  AppHeader._blueSoft,
                ],
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppHeader._lightBorder,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F172A).withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.notifications_outlined,
              size: 18,
              color: Color(0xFF334155),
            ),
          ),
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppHeader._notifRed,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
