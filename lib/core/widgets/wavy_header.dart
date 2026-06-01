import 'package:flutter/material.dart';

class WavyHeader extends StatelessWidget {
  const WavyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF000080), Color(0xFF1565C0)],
              ),
            ),
          ),
          Positioned(top: 22, right: 32, child: _StarDot(size: 5)),
          Positioned(top: 48, right: 64, child: _StarDot(size: 3)),
          Positioned(top: 36, left: 40, child: _StarDot(size: 4)),
          Positioned(top: 80, left: 72, child: _StarDot(size: 3)),
          
          Positioned.fill(
            bottom: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildLogo(),
                // Teks "NOCTURA" sudah dihapus
                const SizedBox(height: 20), 
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: const Size(double.infinity, 60),
              painter: _WavePainter(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      width: 220, 
      height: 220,
      child: Image.asset(
        'assets/images/logo-noctura.png', 
        fit: BoxFit.contain,
      ),
    );
  }
}

class _StarDot extends StatelessWidget {
  final double size;
  const _StarDot({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.35),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.25, 0, size.width * 0.5, size.height * 0.55);
    path.quadraticBezierTo(size.width * 0.75, size.height, size.width, size.height * 0.4);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}