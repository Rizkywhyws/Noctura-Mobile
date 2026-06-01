import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../service/auth_service.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  // 6 controller terpisah — setiap digit independen
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(6, (_) => FocusNode());

  bool _isLoading     = false;
  bool _isResending   = false;
  int  _countdown     = 60;   // detik cooldown resend
  Timer? _timer;

  late String _email; // di-inject dari Navigator arguments
  bool _argInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_argInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments
          as Map<String, dynamic>?;
      _email = args?['email'] ?? '';
      _argInitialized = true;
      _startCountdown();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _countdown = 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_countdown == 0) {
        t.cancel();
      } else {
        if (mounted) setState(() => _countdown--);
      }
    });
  }

  // Gabungkan 6 digit menjadi satu string
  String get _otpValue =>
      _controllers.map((c) => c.text).join();

  void _onDigitChanged(int index, String value) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    if (_otpValue.length == 6) {
      _handleVerify();
    }
  }

  Future<void> _handleVerify() async {
    if (_otpValue.length < 6) return;
    setState(() => _isLoading = true);

    final result = await AuthService.verifyOtp(
      email: _email,
      otp:   _otpValue,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (result['success'] == true) {
      Navigator.pushNamed(
        context,
        '/forgot-password/reset',
        arguments: {'email': _email},
      );
    } else {
      for (final c in _controllers) c.clear();
      _focusNodes[0].requestFocus();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Kode OTP salah'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  Future<void> _handleResend() async {
    if (_countdown > 0 || _isResending) return;
    setState(() => _isResending = true);

    final result = await AuthService.sendOtp(email: _email);

    if (!mounted) return;
    setState(() => _isResending = false);

    if (result['success'] == true) {
      _startCountdown();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Kode OTP baru telah dikirim'),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Gagal mengirim ulang OTP'),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF000080), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              _buildHeader(),
              const SizedBox(height: 36),
              _buildOtpFields(),
              const SizedBox(height: 32),
              _buildVerifyButton(),
              const SizedBox(height: 24),
              _buildResendRow(),
            ],
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
            Icons.mark_email_read_outlined,
            color: Color(0xFF000080),
            size: 36,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Verifikasi OTP',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color(0xFF000080),
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(fontSize: 13, color: Colors.grey.shade500, height: 1.6),
            children: [
              const TextSpan(text: 'Kode 6 digit telah dikirim ke\n'),
              TextSpan(
                text: _email,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF000080),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (i) {
        return SizedBox(
          width: 46,
          height: 56,
          child: TextFormField(
            controller: _controllers[i],
            focusNode: _focusNodes[i],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            // Hanya angka
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF000080),
            ),
            decoration: InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.zero,
              filled: true,
              fillColor: const Color(0xFFF5F7FF),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFC7D9F8), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF000080), width: 2),
              ),
            ),
            onChanged: (v) => _onDigitChanged(i, v),
          ),
        );
      }),
    );
  }

  Widget _buildVerifyButton() {
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
          onTap: _isLoading ? null : _handleVerify,
          child: Center(
            child: _isLoading
                ? const SizedBox(
                    width: 22, height: 22,
                    child: CircularProgressIndicator(
                        strokeWidth: 2.5, color: Colors.white),
                  )
                : const Text(
                    'VERIFIKASI',
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

  Widget _buildResendRow() {
    final canResend = _countdown == 0 && !_isResending;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Tidak menerima kode? ',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
        ),
        GestureDetector(
          onTap: canResend ? _handleResend : null,
          child: Text(
            canResend
                ? 'Kirim Ulang'
                : 'Kirim Ulang ($_countdown)',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: canResend
                  ? const Color(0xFF000080)
                  : Colors.grey.shade400,
            ),
          ),
        ),
      ],
    );
  }
}