// lib/features/auth/screens/reset_password_screen.dart

import 'package:flutter/material.dart';
import '../../service/auth_service.dart';
import './widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey            = GlobalKey<FormState>();
  final _passwordCtrl       = TextEditingController();
  final _confirmCtrl        = TextEditingController();

  bool _obscurePassword     = true;
  bool _obscureConfirm      = true;
  bool _autoValidate        = false;
  bool _isLoading           = false;

  late String _email;
  bool _argInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_argInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments
          as Map<String, dynamic>?;
      _email = args?['email'] ?? '';
      _argInitialized = true;
    }
  }

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleReset() async {
    setState(() => _autoValidate = true);
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final result = await AuthService.resetPassword(
      email:                 _email,
      password:              _passwordCtrl.text,
      passwordConfirmation:  _confirmCtrl.text,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (result['success'] == true) {
      // Hapus seluruh stack — user harus login ulang
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (route) => false,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Kata sandi berhasil diperbarui. Silakan login.'),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Gagal reset kata sandi'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Tidak ada back button — user tidak boleh kembali ke step OTP
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                _buildHeader(),
                const SizedBox(height: 32),
                CustomTextField(
                  label: 'Kata Sandi Baru',
                  hint: 'Minimal 6 karakter',
                  icon: Icons.lock_outline_rounded,
                  isPassword: true,
                  obscureText: _obscurePassword,
                  onTogglePassword: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  controller: _passwordCtrl,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Kata sandi wajib diisi';
                    if (v.length < 6) return 'Kata sandi minimal 6 karakter';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Konfirmasi Kata Sandi',
                  hint: 'Ulangi kata sandi baru',
                  icon: Icons.lock_outline_rounded,
                  isPassword: true,
                  obscureText: _obscureConfirm,
                  onTogglePassword: () =>
                      setState(() => _obscureConfirm = !_obscureConfirm),
                  controller: _confirmCtrl,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Konfirmasi kata sandi wajib diisi';
                    if (v != _passwordCtrl.text) return 'Kata sandi tidak cocok';
                    return null;
                  },
                ),
                const SizedBox(height: 28),
                _buildResetButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 72, height: 72,
          decoration: BoxDecoration(
            color: const Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.shield_outlined,
            color: Color(0xFF000080),
            size: 36,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Buat Kata Sandi Baru',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color(0xFF000080),
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Pastikan kata sandi baru kamu\ncukup kuat dan mudah diingat.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade500,
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildResetButton() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF000080), Color(0xFF1565C0)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1565C0).withOpacity(0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(26),
          onTap: _isLoading ? null : _handleReset,
          child: Center(
            child: _isLoading
                ? const SizedBox(
                    width: 22, height: 22,
                    child: CircularProgressIndicator(
                        strokeWidth: 2.5, color: Colors.white),
                  )
                : const Text(
                    'SIMPAN KATA SANDI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}