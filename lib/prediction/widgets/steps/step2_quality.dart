import 'package:flutter/material.dart';
import '../../data/form_data.dart';
import '../../widgets/prediction_card.dart';
import '../../widgets/custom_slider.dart';

class Step2Quality extends StatelessWidget {
  final UserFormData formData;
  final void Function(VoidCallback) onUpdate;

  const Step2Quality({
    super.key,
    required this.formData,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const ValueKey(2),
      child: Column(
        children: [
          AssessmentCard(
            title: 'Kualitas Tidur',
            icon: Icons.star_outline_rounded,
            iconBg: const Color(0xFFFAEEDA),
            iconColor: const Color(0xFF854F0B),
            child: CustomSlider(
              value: formData.sleepQuality.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (v) =>
                  onUpdate(() => formData.sleepQuality = v.toInt()),
              activeColor: const Color(0xFFBA7517),
              showLabelsUnderAxis: true,
              labels: const ['Buruk', 'Sedang', 'Sangat Baik'],
            ),
          ),

          AssessmentCard(
            title: 'Tingkat Stres',
            icon: Icons.psychology_outlined,
            iconBg: const Color(0xFFFCEBEB),
            iconColor: const Color(0xFFA32D2D),
            child: CustomSlider(
              value: formData.stressLevel.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (v) =>
                  onUpdate(() => formData.stressLevel = v.toInt()),
              activeColor: formData.stressLevel > 6
                  ? const Color(0xFFE24B4A)
                  : formData.stressLevel > 3
                      ? const Color(0xFFBA7517)
                      : const Color(0xFF3B6D11),
              showLabelsUnderAxis: true,
              labels: const ['Rendah', 'Sedang', 'Tinggi'],
            ),
          ),
        ],
      ),
    );
  }
}