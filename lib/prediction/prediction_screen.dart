import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './data/form_data.dart';
import './widgets/step_header.dart';
import './widgets/prediction_footer.dart';
import './widgets/prediction_result_dialog.dart';
import './widgets/steps/step1_profile.dart';
import './widgets/steps/step2_quality.dart';
import './widgets/steps/step3_activity.dart';
import '../core/widgets/app_theme.dart';
import '../core/widgets/services/api_services.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {

  @override
  bool get wantKeepAlive => true;

  late UserFormData _formData;                 // ✅ non‑final agar bisa di‑reset
  int _currentStep = 1;
  static const int _totalSteps = 3;
  bool _isLoading = false;
  bool _isResetting = false;                   // flag khusus reset (opsional)

  late final AnimationController _stepAnimController;
  late Animation<double> _stepFadeAnim;
  late Animation<Offset> _stepSlideAnim;

  @override
  void initState() {
    super.initState();
    _formData = UserFormData();                // inisialisasi awal
    _stepAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    _buildStepAnims(forward: true);
    _stepAnimController.value = 1.0;
  }

  @override
  void dispose() {
    _stepAnimController.dispose();
    super.dispose();
  }

  void _buildStepAnims({required bool forward}) {
    _stepFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _stepAnimController, curve: Curves.easeOut),
    );
    _stepSlideAnim = Tween<Offset>(
      begin: Offset(forward ? 0.04 : -0.04, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _stepAnimController, curve: Curves.easeOutCubic),
    );
  }

  void _goToStep(int step, {required bool forward}) {
    _buildStepAnims(forward: forward);
    setState(() => _currentStep = step);
    _stepAnimController.forward(from: 0);
  }

  // ────────────────────── RESET FORM ──────────────────────────
  Future<void> _resetForm() async {
    // Tampilkan efek loading sebentar
    setState(() => _isResetting = true);
    await Future.delayed(const Duration(milliseconds: 400));

    // Buat objek form data baru (reset semua field)
    _formData = UserFormData();

    // Kembali ke langkah pertama
    _currentStep = 1;

    // Reset animasi ke posisi awal
    _buildStepAnims(forward: true);
    _stepAnimController.value = 1.0;

    if (mounted) setState(() => _isResetting = false);
  }

  void _nextStep() {
    final error = _validateCurrentStep();
    if (error != null) { _showSnackError(error); return; }
    if (_currentStep < _totalSteps) _goToStep(_currentStep + 1, forward: true);
  }

  void _prevStep() {
    if (_currentStep > 1) _goToStep(_currentStep - 1, forward: false);
  }

  Future<void> _submit() async {
    final error = _validateCurrentStep();
    if (error != null) { _showSnackError(error); return; }

    setState(() => _isLoading = true);
    try {
      final prefs  = await SharedPreferences.getInstance();
      final userId = prefs.getString('user_id') ?? '';
      final request = SleepPredictionRequest.fromFormData(_formData, userId);
      final result  = await ApiService().predict(request);

      if (mounted) showPredictionResult(context, result);
    } catch (e) {
      if (mounted) {
        _showErrorDialog(e.toString().replaceFirst('Exception: ', ''));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ── Error snackbar ──────────────────────────────────────────
  void _showSnackError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: const Color(0xFFDC2626),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  // ── Error dialog (API) ──────────────────────────────────────
  void _showErrorDialog(String message) {
    final isConnectionError =
        message.toLowerCase().contains('xmlhttprequest') ||
        message.toLowerCase().contains('failed host') ||
        message.toLowerCase().contains('connection') ||
        message.toLowerCase().contains('network') ||
        message.toLowerCase().contains('socketexception');

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
        titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFDC2626).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.wifi_off_rounded,
                color: Color(0xFFDC2626),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Gagal Terhubung',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              isConnectionError
                  ? 'Tidak dapat terhubung ke server. Pastikan:\n\n'
                    '• Server Laravel sudah berjalan\n'
                    '• URL API sudah benar\n'
                    '• Koneksi internet aktif'
                  : message,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.6,
                color: Color(0xFF475569),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF94A3B8),
                  fontFamily: 'monospace',
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Tutup'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(ctx).pop();
              _submit();
            },
            icon: const Icon(Icons.refresh_rounded, size: 16),
            label: const Text('Coba Lagi'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _validateCurrentStep() {
    switch (_currentStep) {
      case 1: return _formData.validateStep1();
      case 2: return _formData.validateStep2();
      case 3: return _formData.validateStep3();
      default: return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ValueListenableBuilder<bool>(
      valueListenable: AppTheme.instance,
      builder: (context, isDark, _) {
        final scaffoldBg =
            isDark ? const Color(0xFF0D0B1A) : const Color(0xFFF5F7FA);

        return Scaffold(
          backgroundColor: scaffoldBg,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StepHeader(
                  currentStep: _currentStep,
                  onBack: _currentStep > 1 ? _prevStep : null,
                ),
                _TitleSection(step: _currentStep, isDark: isDark),
                // ── AREA SCROLLABLE + PULL-TO-REFRESH ──────────
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _resetForm,
                    color: const Color(0xFF6C63FF),
                    backgroundColor: isDark
                        ? const Color(0xFF1C1836)
                        : Colors.white,
                    displacement: 60,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      child: AnimatedBuilder(
                        animation: _stepAnimController,
                        builder: (context, child) => FadeTransition(
                          opacity: _stepFadeAnim,
                          child: SlideTransition(
                            position: _stepSlideAnim,
                            child: child,
                          ),
                        ),
                        child: _buildCurrentStep(),
                      ),
                    ),
                  ),
                ),
                AssessmentFooter(
                  currentStep: _currentStep,
                  totalSteps: _totalSteps,
                  onNext: _nextStep,
                  onBack: _prevStep,
                  onSubmit: _submit,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 1:
        return Step1Profile(formData: _formData, onUpdate: (fn) => setState(fn));
      case 2:
        return Step2Quality(formData: _formData, onUpdate: (fn) => setState(fn));
      case 3:
        return Step3Activity(formData: _formData, onUpdate: (fn) => setState(fn));
      default:
        return Step1Profile(formData: _formData, onUpdate: (fn) => setState(fn));
    }
  }
}

// ── Title section (tidak berubah) ──────────────────────────────────────────
class _TitleSection extends StatelessWidget {
  final int step;
  final bool isDark;

  const _TitleSection({required this.step, required this.isDark});

  static const _titles = [
    ('Profil Anda',      'Isi data berikut untuk analisis yang akurat'),
    ('Kualitas & Stres', 'Bagaimana kondisi tidur dan pikiranmu?'),
    ('Aktivitas Fisik',  'Ceritakan gaya hidup harianmu'),
  ];

  @override
  Widget build(BuildContext context) {
    final (title, subtitle) = _titles[step - 1];

    final titleColor    = isDark ? const Color(0xFFF1F5F9) : const Color(0xFF1A202C);
    final subtitleColor = isDark ? const Color(0xFF9B8FE8) : const Color(0xFF718096);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: titleColor,
              letterSpacing: -0.3,
            ),
            child: Text(title),
          ),
          const SizedBox(height: 2),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: TextStyle(fontSize: 13, color: subtitleColor),
            child: Text(subtitle),
          ),
        ],
      ),
    );
  }
}