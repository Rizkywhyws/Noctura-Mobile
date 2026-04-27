import 'package:flutter/material.dart';
import 'custom_text_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreeToTerms = false;

  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmError;
  String? _termsError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmController.text;

    setState(() {
      _nameError = name.isEmpty ? 'Nama lengkap wajib diisi' : null;

      if (email.isEmpty) {
        _emailError = 'Email wajib diisi';
      } else if (!_isValidEmail(email)) {
        _emailError = 'Format email tidak valid';
      } else {
        _emailError = null;
      }

      if (password.isEmpty) {
        _passwordError = 'Kata sandi wajib diisi';
      } else if (password.length < 6) {
        _passwordError = 'Kata sandi minimal 6 karakter';
      } else {
        _passwordError = null;
      }

      if (confirm.isEmpty) {
        _confirmError = 'Konfirmasi kata sandi wajib diisi';
      } else if (password != confirm) {
        _confirmError = 'Kata sandi tidak cocok';
      } else {
        _confirmError = null;
      }

      _termsError =
          !_agreeToTerms ? 'Kamu harus menyetujui syarat & ketentuan' : null;
    });

    final hasError = _nameError != null ||
        _emailError != null ||
        _passwordError != null ||
        _confirmError != null ||
        _termsError != null;

    if (hasError) return;

    _showSnackBar('Registrasi berhasil!');
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Buat Akun!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Center(
            child: Text(
              'Daftar untuk memulai',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Nama Lengkap',
            hintText: 'Masukkan nama lengkap',
            prefixIcon: Icons.person_outline,
            controller: _nameController,
            errorText: _nameError,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Email',
            hintText: 'Masukkan email',
            prefixIcon: Icons.email_outlined,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            errorText: _emailError,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Kata Sandi',
            hintText: 'Masukkan kata sandi',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            controller: _passwordController,
            obscureText: _obscurePassword,
            errorText: _passwordError,
            onToggleObscure: () {
              setState(() => _obscurePassword = !_obscurePassword);
            },
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Konfirmasi Kata Sandi',
            hintText: 'Ulangi kata sandi',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            controller: _confirmController,
            obscureText: _obscureConfirm,
            errorText: _confirmError,
            onToggleObscure: () {
              setState(() => _obscureConfirm = !_obscureConfirm);
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Checkbox(
                value: _agreeToTerms,
                activeColor: const Color(0xFF3B5BDB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onChanged: (val) {
                  setState(() {
                    _agreeToTerms = val ?? false;
                    if (_agreeToTerms) {
                      _termsError = null;
                    }
                  });
                },
              ),
              const Text(
                'Saya setuju dengan ',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Syarat & Ketentuan',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF3B5BDB),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (_termsError != null) ...[
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                _termsError!,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFE53935),
                  height: 1.3,
                ),
              ),
            ),
          ],
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A237E), Color(0xFF1E88E5)],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton(
                onPressed: _handleRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'DAFTAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sudah punya akun? ',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF3B5BDB),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
