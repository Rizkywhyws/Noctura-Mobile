import 'package:flutter/material.dart';
import '../../data/form_data.dart';
import '../../widgets/prediction_card.dart';
import '../../widgets/prediction_textfield.dart';
import '../../widgets/activity_card.dart';

class Step3Activity extends StatelessWidget {
  final UserFormData formData;
  final void Function(VoidCallback) onUpdate;

  const Step3Activity({
    super.key,
    required this.formData,
    required this.onUpdate,
  });

  static const _activityData = [
    (
      value: 'SEDENTARY',
      label: 'Sedentary',
      subtitle: '< 3000 langkah',
      icon: Icons.chair_alt_outlined,
    ),
    (
      value: 'LIGHT',
      label: 'Light',
      subtitle: '3000–6000',
      icon: Icons.directions_walk_outlined,
    ),
    (
      value: 'ACTIVE',
      label: 'Active',
      subtitle: '> 6000 langkah',
      icon: Icons.directions_run_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const ValueKey(3),
      child: Column(
        children: [
          AssessmentCard(
            title: 'Aktivitas Fisik Harian',
            icon: Icons.directions_run_rounded,
            iconBg: const Color(0xFFEAF3DE),
            iconColor: const Color(0xFF3B6D11),
            child: Row(
              children: _activityData.map((a) {
                return ActivityCard(
                  label: a.label,
                  subtitle: a.subtitle,
                  icon: a.icon,
                  selected: formData.activityLevel == a.value,
                  onTap: () =>
                      onUpdate(() => formData.activityLevel = a.value),
                );
              }).toList(),
            ),
          ),

          AssessmentCard(
            title: 'Data Fisik (BMI)',
            icon: Icons.monitor_weight_outlined,
            iconBg: const Color(0xFFE1F5EE),
            iconColor: const Color(0xFF0F6E56),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AssessmentTextField(
                        label: 'Tinggi (cm)',
                        hint: '165',
                        type: TextInputType.number,
                        onSaved: (v) => onUpdate(
                          () => formData.heightCm = int.tryParse(v!) ?? 0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AssessmentTextField(
                        label: 'Berat (kg)',
                        hint: '60',
                        type: TextInputType.number,
                        onSaved: (v) => onUpdate(
                          () => formData.weightKg = int.tryParse(v!) ?? 0,
                        ),
                      ),
                    ),
                  ],
                ),
                if (formData.bmi > 0) ...[
                  const SizedBox(height: 14),
                  _BmiResult(
                    bmi: formData.bmi,
                    category: formData.bmiCategory,
                  ),
                ],
              ],
            ),
          ),

          AssessmentCard(
            title: 'Langkah Harian',
            icon: Icons.directions_walk_outlined,
            iconBg: const Color(0xFFEEEDFE),
            iconColor: const Color(0xFF534AB7),
            child: AssessmentTextField(
              label: 'Jumlah Langkah',
              hint: '7000',
              type: TextInputType.number,
              helperText: 'Dapat diisi otomatis dari sensor HP',
              onSaved: (v) =>
                  onUpdate(() => formData.steps = int.tryParse(v!) ?? 0),
            ),
          ),
        ],
      ),
    );
  }
}

class _BmiResult extends StatelessWidget {
  final double bmi;
  final String category;

  const _BmiResult({required this.bmi, required this.category});

  Color get _bgColor => category == 'Normal'
      ? const Color(0xFFEAF3DE)
      : category == 'Kurus'
          ? const Color(0xFFE6F1FB)
          : const Color(0xFFFAEEDA);

  Color get _textColor => category == 'Normal'
      ? const Color(0xFF3B6D11)
      : category == 'Kurus'
          ? const Color(0xFF185FA5)
          : const Color(0xFF854F0B);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BMI: ${bmi.toStringAsFixed(1)}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A202C),
                ),
              ),
              const Text(
                'Nilai kesehatan tubuh',
                style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
              ),
            ],
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _bgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              category,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}