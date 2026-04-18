import 'package:flutter/material.dart';

class StepHeader extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onBack;

  const StepHeader({
    super.key,
    required this.currentStep,
    this.totalSteps = 3,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Tombol kembali
              GestureDetector(
                onTap: onBack ?? () => Navigator.maybePop(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back_ios_new_rounded, size: 13, color: Color(0xFF6B7280)),
                      SizedBox(width: 4),
                      Text(
                        'Kembali',
                        style: TextStyle(fontSize: 13, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),

              // Step pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F1FB),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Langkah $currentStep / $totalSteps',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF185FA5),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Progress bar dengan gradient
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Container(height: 5, color: const Color(0xFFE5E7EB)),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  height: 5,
                  width: MediaQuery.of(context).size.width *
                      (currentStep / totalSteps) *
                      0.9,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4A90C7), Color(0xFF7C3AED)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}