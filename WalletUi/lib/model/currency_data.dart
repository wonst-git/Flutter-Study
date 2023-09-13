import 'package:flutter/material.dart';

class CurrencyData {
  final String name;
  final String code;
  final String amount;
  final IconData icon;

  CurrencyData({
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
  });
}
