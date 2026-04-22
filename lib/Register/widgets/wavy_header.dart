import 'package:flutter/material.dart';

class WavyHeader extends StatelessWidget {
  const WavyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        children: [
          // Background gradient biru bergelombang
          ClipPath(
            clipper: _WaveClipper(),
            child: Container(
              height: 200,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0D1B6E),
                    Color(0xFF1A3A9E),
                    Color(0xFF1E5FC2),
                  ],
                ),
              ),
            ),
          ),

          // Bintang-bintang kecil
          const Positioned(top: 14, left: 38,   child: _StarDot(size: 4)),
          const Positioned(top: 36, left: 90,   child: _StarDot(size: 3)),
          const Positioned(top: 10, right: 52,  child: _StarDot(size: 5)),
          const Positioned(top: 48, right: 100, child: _StarDot(size: 3)),

          // Logo + teks NOCTURA
          Positioned(
            top: 24,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white54, width: 1.5),
                    color: Colors.white.withOpacity(0.08),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.nightlight_round,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'NOCTURA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Sleep Intelligence',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 10,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      size.width * 0.5,
      size.height - 18,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height - 36,
      size.width,
      size.height - 10,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_WaveClipper oldClipper) => false;
}

class _StarDot extends StatelessWidget {
  final double size;
  const _StarDot({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}