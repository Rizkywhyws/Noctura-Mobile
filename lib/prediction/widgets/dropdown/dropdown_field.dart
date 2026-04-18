import 'package:flutter/material.dart';
import 'dropdown_model.dart';
import 'dropdown_panel.dart';

class AssessmentDropdown extends StatefulWidget {
  final String label;
  final String? value;
  final List<DropdownItem> items;
  final void Function(String?) onChanged;

  const AssessmentDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  State<AssessmentDropdown> createState() => _AssessmentDropdownState();
}

class _AssessmentDropdownState extends State<AssessmentDropdown>
    with WidgetsBindingObserver {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    // Observer untuk detect perubahan keyboard
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _close();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    if (_isOpen) {
      _overlayEntry?.markNeedsBuild();
    }
  }

  void _toggle() {
    _isOpen ? _close() : _open();
  }

  void _open() {
    _overlayEntry = _buildOverlay();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _close() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) setState(() => _isOpen = false);
  }

  OverlayEntry _buildOverlay() {
    final box = context.findRenderObject() as RenderBox;
    final size = box.size;
    final position = box.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (overlayContext) {

        final mediaQuery = MediaQuery.of(overlayContext);
        final screenHeight = mediaQuery.size.height;
        final keyboardHeight = mediaQuery.viewInsets.bottom;

        final availableHeight = screenHeight - keyboardHeight;

        final fieldTop = position.dy;
        final fieldBottom = position.dy + size.height;

        final spaceAbove = fieldTop - 8;
        final spaceBelow = availableHeight - fieldBottom - 8;

        final bool showAbove = spaceBelow < 180 || spaceAbove > spaceBelow;

        const double preferredHeight = 240.0;

        final double maxHeight;
        final double top;

        if (showAbove) {

          maxHeight = spaceAbove.clamp(120.0, preferredHeight);
          top = fieldTop - maxHeight - 6;
        } else {

          maxHeight = spaceBelow.clamp(120.0, preferredHeight);
          top = fieldBottom + 6;
        }

        return Stack(
          children: [
            // Backdrop
            Positioned.fill(
              child: GestureDetector(
                onTap: _close,
                behavior: HitTestBehavior.translucent,
              ),
            ),

            Positioned(
              left: position.dx,
              top: top,
              width: size.width,
              child: Material(
                color: Colors.transparent,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 0,
                    maxHeight: maxHeight,
                  ),
                  child: DropdownPanel(
                    items: widget.items,
                    selectedValue: widget.value,
                    searchable: true,
                    showAbove: showAbove,
                    onSelect: (val) {
                      widget.onChanged(val);
                      _close();
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  DropdownItem? get selected =>
      widget.items.where((e) => e.value == widget.value).firstOrNull;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF9CA3AF),
          ),
        ),
        const SizedBox(height: 6),

        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: _toggle,
            child: Container(
              constraints: const BoxConstraints(minHeight: 48),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFF9FAFB),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selected?.label ?? 'Pilih...',
                      style: TextStyle(
                        fontSize: 14,
                        color: selected != null
                            ? const Color(0xFF1A202C)
                            : const Color(0xFFD1D5DB),
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}