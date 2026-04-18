import 'package:flutter/material.dart';

class DropdownItem {
  final String value;
  final String label;
  final IconData? icon;
  final Color? iconBg;
  final Color? iconColor;
  final String? subtitle;

  const DropdownItem({
    required this.value,
    required this.label,
    this.icon,
    this.iconBg,
    this.iconColor,
    this.subtitle,
  });
}