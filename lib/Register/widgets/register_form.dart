import 'package:flutter/material.dart';
import 'custom_text_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _nameController     = TextEditingController();
  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController  = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm  = true;
  bool _agreeToTerms    = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    final name     = _nameController.text.trim();
    final email    = _emailController.text.trim();
    final password = _passwordController.text;
    final confirm  = _confirmController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
      _showSnackBar('Semua field harus diisi!');
      return;
    }

    if (password != confirm) {
      _showSnackBar('Kata sandi tidak cocok!');
      return;
    }

    if (!_agreeToTerms) {
      _showSnackBar('Kamu harus menyetujui syarat & ketentuan!');
      return;
    }

    // TODO: tambahkan logika register ke API / Firebase di sini
    _showSnackBar('Registrasi berhasil!');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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

          // Judul
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
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),

          // Field Nama Lengkap
          CustomTextField(
            label: 'Nama Lengkap',
            hintText: 'Masukkan nama lengkap',
            prefixIcon: Icons.person_outline,
            controller: _nameController,
          ),
          const SizedBox(height: 12),

          // Field Email
          CustomTextField(
            label: 'Email',
            hintText: 'Masukkan email',
            prefixIcon: Icons.email_outlined,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),

          // Field Kata Sandi
          CustomTextField(
            label: 'Kata Sandi',
            hintText: 'Masukkan kata sandi',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            controller: _passwordController,
            obscureText: _obscurePassword,
            onToggleObscure: () {
              setState(() => _obscurePassword = !_obscurePassword);
            },
          ),
          const SizedBox(height: 12),

          // Field Konfirmasi Kata Sandi
          CustomTextField(
            label: 'Konfirmasi Kata Sandi',
            hintText: 'Ulangi kata sandi',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            controller: _confirmController,
            obscureText: _obscureConfirm,
            onToggleObscure: () {
              setState(() => _obscureConfirm = !_obscureConfirm);
            },
          ),
          const SizedBox(height: 12),

          // Checkbox Syarat & Ketentuan
          Row(
            children: [
              Checkbox(
                value: _agreeToTerms,
                activeColor: const Color(0xFF3B5BDB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onChanged: (val) {
                  setState(() => _agreeToTerms = val ?? false);
                },
              ),
              const Text(
                'Saya setuju dengan ',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: navigasi ke halaman syarat & ketentuan
                },
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
          const SizedBox(height: 18),

          // Tombol DAFTAR
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

          // Link ke Login
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