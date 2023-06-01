import 'package:flutter/material.dart';

class CustomBottomNavbarItem extends BottomNavigationBarItem {
  final String path;

  CustomBottomNavbarItem({
    required super.icon,
    required super.label,
    required this.path,
    super.activeIcon,
    super.backgroundColor,
    super.tooltip,
  });
}
