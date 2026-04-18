import 'package:flutter/material.dart';
import 'dropdown_model.dart';

class DropdownItemTile extends StatelessWidget {
  final DropdownItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const DropdownItemTile({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: isSelected ? const Color(0xFFEFF6FF) : Colors.transparent,
        child: Row(
          children: [
            if (item.icon != null)
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected
                      ? (item.iconBg ?? const Color(0xFFE6F1FB))
                      : (item.iconBg ?? const Color(0xFFF9FAFB)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  item.icon,
                  size: 16,
                  color: isSelected
                      ? (item.iconColor ?? const Color(0xFF000080))
                      : (item.iconColor ?? const Color(0xFF9CA3AF)),
                ),
              ),
            if (item.icon != null) const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isSelected
                          ? const Color(0xFF000080)
                          : const Color(0xFF1A202C),
                    ),
                  ),
                  if (item.subtitle != null)
                    Text(
                      item.subtitle!,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                ],
              ),
            ),

            AnimatedOpacity(
              opacity: isSelected ? 1 : 0,
              duration: const Duration(milliseconds: 150),
              child: const Icon(
                Icons.check_rounded,
                size: 16,
                color: Color(0xFF4A90C7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
