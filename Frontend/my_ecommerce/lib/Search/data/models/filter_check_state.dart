import 'package:flutter/material.dart';

class FilterCheckState {
  final Widget? icon;
  final String title;
  bool value;

  FilterCheckState({
    required this.icon,
    required this.title,
    this.value = false,
  });
}