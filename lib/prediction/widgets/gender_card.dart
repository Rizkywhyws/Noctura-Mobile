import 'package:flutter/material.dart';

class GenderCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const GenderCard({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? const Color(0xFF4A90C7) : const Color(0xFFE5E7EB),
            width: selected ? 1.5 : 0.5,
          ),
          color: selected ? const Color(0xFFE6F1FB) : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 26,
              color: selected
                  ? const Color(0xFF185FA5)
                  : (label == 'Perempuan'
                      ? const Color(0xFFD4537E)
                      : const Color(0xFF378ADD)),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                color: selected
                    ? const Color(0xFF185FA5)
                    : const Color(0xFF374151),
              ),
            ),
          ],
        ),
      ),
    );
  }
}