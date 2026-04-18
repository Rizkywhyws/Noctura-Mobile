import 'package:flutter/material.dart';
import 'dropdown_model.dart';
import 'dropdown_item_title.dart';

class DropdownPanel extends StatefulWidget {
  final List<DropdownItem> items;
  final String? selectedValue;
  final bool searchable;
  final bool showAbove;
  final void Function(String) onSelect;

  const DropdownPanel({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.searchable,
    required this.showAbove,
    required this.onSelect,
  });

  @override
  State<DropdownPanel> createState() => _DropdownPanelState();
}

class _DropdownPanelState extends State<DropdownPanel> {
  String _query = '';

  List<DropdownItem> get _filtered => _query.isEmpty
      ? widget.items
      : widget.items
          .where(
            (i) =>
                i.label.toLowerCase().contains(_query.toLowerCase()) ||
                (i.subtitle?.toLowerCase().contains(_query.toLowerCase()) ??
                    false),
          )
          .toList();

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(14));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        border: Border.all(color: const Color(0xFFE5E7EB), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.searchable) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: TextField(
                  autofocus: false,
                  onChanged: (v) => setState(() => _query = v),
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: 'Cari...',
                    hintStyle: TextStyle(color: Color(0xFFD1D5DB)),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const Divider(height: 1, color: Color(0xFFE5E7EB)),
            ],
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: _filtered.length,
                itemBuilder: (_, i) {
                  final item = _filtered[i];
                  return DropdownItemTile(
                    item: item,
                    isSelected: item.value == widget.selectedValue,
                    onTap: () => widget.onSelect(item.value),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}