import 'package:flutter/material.dart';
import '../../data/form_data.dart';
import '../../widgets/prediction_card.dart';
import '../../widgets/prediction_textfield.dart';
import '../../widgets/custom_slider.dart';
import '../../widgets/gender_card.dart';
import '../../widgets/dropdown/dropdown_field.dart';
import '../../widgets/dropdown/dropdown_model.dart';

class Step1Profile extends StatelessWidget {
  final UserFormData formData;
  final void Function(VoidCallback) onUpdate;

  const Step1Profile({
    super.key,
    required this.formData,
    required this.onUpdate,
  });

  static final List<DropdownItem> _jobItems = [
    DropdownItem(
      value: 'Dokter',
      label: 'Dokter',
      subtitle: 'Tenaga kesehatan',
      icon: Icons.medical_services_outlined,
      iconBg: Color(0xFFFCEBEB),
      iconColor: Color(0xFFA32D2D),
    ),
    DropdownItem(
      value: 'Guru',
      label: 'Guru',
      subtitle: 'Pendidikan',
      icon: Icons.menu_book_outlined,
      iconBg: Color(0xFFFAEEDA),
      iconColor: Color(0xFF854F0B),
    ),
    DropdownItem(
      value: 'Software Engineer',
      label: 'Software Engineer',
      subtitle: 'Teknologi',
      icon: Icons.code_rounded,
      iconBg: Color(0xFFEEEDFE),
      iconColor: Color(0xFF534AB7),
    ),
    DropdownItem(
      value: 'Pengacara',
      label: 'Pengacara',
      subtitle: 'Hukum',
      icon: Icons.balance_outlined,
      iconBg: Color(0xFFE1F5EE),
      iconColor: Color(0xFF0F6E56),
    ),
    DropdownItem(
      value: 'Insinyur',
      label: 'Insinyur',
      subtitle: 'Teknik',
      icon: Icons.engineering_outlined,
      iconBg: Color(0xFFE6F1FB),
      iconColor: Color(0xFF185FA5),
    ),
    DropdownItem(
      value: 'Akuntan',
      label: 'Akuntan',
      subtitle: 'Keuangan',
      icon: Icons.bar_chart_rounded,
      iconBg: Color(0xFFEAF3DE),
      iconColor: Color(0xFF3B6D11),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const ValueKey(1),
      child: Column(
        children: [
          AssessmentCard(
            title: 'Data Pribadi',
            icon: Icons.person_outline_rounded,
            iconBg: const Color(0xFFE6F1FB),
            iconColor: const Color(0xFF185FA5),
            child: Column(
              children: [
                // Gender
                Row(
                  children: [
                    Expanded(
                      child: GenderCard(
                        label: 'Laki-laki',
                        icon: Icons.male_rounded,
                        selected: formData.gender == 0,
                        onTap: () =>
                            onUpdate(() => formData.gender = 0),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GenderCard(
                        label: 'Perempuan',
                        icon: Icons.female_rounded,
                        selected: formData.gender == 1,
                        onTap: () =>
                            onUpdate(() => formData.gender = 1),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // 🔥 FIX HEIGHT SAMA
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 70, // 🔥 termasuk label + field
                        child: AssessmentTextField(
                          label: 'Usia',
                          hint: '25',
                          type: TextInputType.number,
                          onSaved: (v) =>
                              formData.age = int.tryParse(v!) ?? 0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 70, // 🔥 sama persis
                        child: AssessmentDropdown(
                          label: 'Pekerjaan',
                          value: formData.job.isEmpty
                              ? null
                              : formData.job,
                          items: _jobItems,
                          onChanged: (v) =>
                              onUpdate(() => formData.job = v ?? ''),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Sleep duration
          AssessmentCard(
            title: 'Durasi Tidur',
            icon: Icons.bedtime_outlined,
            iconBg: const Color(0xFFEEEDFE),
            iconColor: const Color(0xFF534AB7),
            child: StatefulBuilder(
              builder: (_, s) => CustomSlider(
                value: formData.sleepDuration,
                min: 0,
                max: 12,
                divisions: 24,
                unit: 'jam',
                onChanged: (v) =>
                    s(() => formData.sleepDuration = v),
                activeColor: const Color(0xFF534AB7),
                showLabelsUnderAxis: true,
                labels: const ['0j', '3j', '6j', '9j', '12j'],
              ),
            ),
          ),
        ],
      ),
    );
  }
}