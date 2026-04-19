import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onTogglePassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.obscureText = true,
    this.onTogglePassword,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF424242),
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            // ✅ Background biru muda senada tema
            color: const Color(0xFFEEF4FF),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: const Color(0xFFC7D9F8), width: 1),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: isPassword ? obscureText : false,
            validator: validator,
            style: const TextStyle(fontSize: 14, color: Color(0xFF0B1D51)),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFFBDBDBD), fontSize: 14),
              prefixIcon: Icon(icon, size: 20, color: const Color(0xFF1565C0)),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: const Color(0xFF9E9E9E),
                      ),
                      onPressed: onTogglePassword,
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              // ✅ Error style yang tetap rapi
              errorStyle: const TextStyle(
                fontSize: 11,
                color: Color(0xFFD32F2F),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(color: Color(0xFFEF9A9A), width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}