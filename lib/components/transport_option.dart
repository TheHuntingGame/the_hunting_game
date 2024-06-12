import 'package:flutter/material.dart';

class TransportOption {
  final String name;
  final IconData icon;
  final String description;
  final double price;
  final String validDuration;

  TransportOption({
    required this.name,
    required this.icon,
    required this.description,
    required this.price,
    required this.validDuration,
  });
}
