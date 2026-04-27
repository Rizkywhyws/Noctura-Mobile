import 'package:flutter/material.dart';

class WavyHeader extends StatelessWidget {
  const WavyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF000080), Color(0xFF1565C0)],
              ),
            ),
          ),
          // Bintang dekoratif
          const Positioned(top: 22, right: 32, child: _StarDot(size: 5)),
          const Positioned(top: 48, right: 64, child: _StarDot(size: 3)),
          const Positioned(top: 36, left: 40, child: _StarDot(size: 4)),
          const Positioned(top: 80, left: 72, child: _StarDot(size: 3)),
          // Konten tengah
          Positioned.fill(
            bottom: 50,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildLogo(),
                  const SizedBox(height: 14),
                  const Text(
                    'NOCTURA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Sleep Intelligence',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Wave bawah
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
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.1),
        border: Border.all(color: Colors.white.withOpacity(0.25), width: 1.5),
      ),
      child: CustomPaint(painter: _LogoPainter()),
    );
  }
}

// Titik bintang dekoratif
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
    path.quadraticBezierTo(
      size.width * 0.25,
      0,
      size.width * 0.5,
      size.height * 0.55,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height,
      size.width,
      size.height * 0.4,
    );
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}

class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.38;

    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());


    canvas.drawCircle(
      Offset(cx, cy),
      r,
      Paint()..color = Colors.white,
    );

    canvas.drawCircle(
      Offset(cx + r * 0.37, cy),
      r * 0.74,
      Paint()..blendMode = BlendMode.clear,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(_) => false;
}