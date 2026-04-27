import 'package:flutter/material.dart';

class AssessmentTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType type;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final String? helperText;

  const AssessmentTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.type,
    this.onSaved,
    this.onChanged,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF9CA3AF),
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          keyboardType: type,
          style: const TextStyle(fontSize: 14, color: Color(0xFF1A202C)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFD1D5DB)),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Color(0xFFE5E7EB), width: 0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Color(0xFFE5E7EB), width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Color(0xFF4A90C7), width: 1.5),
            ),
            helperText: helperText,
            helperStyle:
                const TextStyle(fontSize: 10, color: Color(0xFF4A90C7)),
          ),
          onSaved: onSaved,
          onChanged: onChanged,
        ),
      ],
    );
  }
}