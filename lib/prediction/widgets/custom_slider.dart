import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final Function(double) onChanged;
  final ValueChanged<double>? onChangeEnd;
  final Color activeColor;
  final Color inactiveColor;
  final List<String>? labels;
  final bool showLabelsUnderAxis;
  final String? unit;

  const CustomSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    this.divisions,
    required this.onChanged,
    required this.activeColor,
    this.inactiveColor = const Color(0xFFE5E7EB),
    this.labels,
    this.onChangeEnd,
    this.showLabelsUnderAxis = true,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Value badge di tengah
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE5E7EB)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                unit != null
                    ? '${value.toStringAsFixed(1)} $unit'
                    : value.round().toString(),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A202C),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Slider
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 4,
              overlayShape: SliderComponentShape.noOverlay,
              thumbShape: const _CustomThumbShape(),
              activeTrackColor: activeColor,
              inactiveTrackColor: inactiveColor,
              thumbColor: Colors.white,
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
              onChangeEnd: onChangeEnd,
            ),
          ),

          // Labels bawah
          if (showLabelsUnderAxis && labels != null && labels!.length >= 3)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _labelText(labels!.first),
                  _labelText(labels![labels!.length ~/ 2]),
                  _labelText(labels!.last),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _labelText(String text) => Text(
        text,
        style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF), fontWeight: FontWeight.w500),
      );
}

class _CustomThumbShape extends SliderComponentShape {
  const _CustomThumbShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(18, 18);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    // Shadow
    canvas.drawCircle(
      center + const Offset(0, 1),
      9,
      Paint()
        ..color = Colors.black.withOpacity(0.12)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );

    // White fill
    canvas.drawCircle(center, 9, Paint()..color = Colors.white);

    // Colored border
    canvas.drawCircle(
      center,
      9,
      Paint()
        ..color = sliderTheme.activeTrackColor ?? const Color(0xFF4A90C7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Inner dot
    canvas.drawCircle(
      center,
      3.5,
      Paint()..color = sliderTheme.activeTrackColor ?? const Color(0xFF4A90C7),
    );
  }
}