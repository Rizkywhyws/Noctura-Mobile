import 'package:flutter/material.dart';
import '../sleep_condition.dart';

class ConditionCard extends StatelessWidget {
  final SleepCondition condition;
  const ConditionCard({super.key, required this.condition});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: condition.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Dekorasi lingkaran sudut kanan atas
          Positioned(
            top: -16,
            right: -16,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: condition.decoColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: condition.badgeColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(condition.emoji, style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    Text(
                      condition.badge,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: condition.badgeTextColor,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Judul
              Text(
                condition.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: condition.titleColor,
                ),
              ),
              const SizedBox(height: 6),

              // Deskripsi
              Text(
                condition.description,
                style: TextStyle(
                  fontSize: 12,
                  color: condition.descColor,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 12),

              // Label gejala/tanda
              Text(
                condition.id == 'healthy' ? 'TANDA TIDUR SEHAT' : 'GEJALA UMUM',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: condition.descColor,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),

              // Symptom pills
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: condition.symptoms.map((s) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: condition.pillColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      s,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: condition.pillTextColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),

              // Tip box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: condition.tipBoxColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lightbulb_outline, size: 14, color: condition.descColor),
                    const SizedBox(width: 6),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 11, color: condition.descColor, height: 1.6),
                          children: [
                            TextSpan(
                              text: '${condition.tipLabel}: ',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: condition.tip),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}