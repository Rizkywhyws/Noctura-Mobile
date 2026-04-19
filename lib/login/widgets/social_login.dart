import 'package:flutter/material.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          _buildDivider(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialButton(
                icon: Icons.g_mobiledata,
                label: 'Google',
                iconColor: const Color(0xFF4285F4),
              ),
              const SizedBox(width: 20),
              _SocialButton(
                icon: Icons.facebook,
                label: 'Facebook',
                iconColor: const Color(0xFF1877F2),
              ),
              const SizedBox(width: 20),
              _SocialButton(
                icon: Icons.flutter_dash,
                label: 'Twitter',
                iconColor: const Color(0xFF1DA1F2),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(height: 0.5, color: const Color(0xFFE0E0E0)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'ATAU',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF9E9E9E),
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Container(height: 0.5, color: const Color(0xFFE0E0E0)),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            // ✅ Senada dengan field — biru muda dengan border
            color: const Color(0xFFEEF4FF),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFC7D9F8), width: 1),
          ),
          child: Icon(icon, size: 26, color: iconColor),
        ),
        const SizedBox(height: 7),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF757575),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}