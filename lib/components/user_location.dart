import 'package:flutter/material.dart';

class CustomLocationMarker extends StatelessWidget {
  const CustomLocationMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.3), // Outer circle
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 16,
          height: 16,
          decoration: const BoxDecoration(
            color: Colors.white, // Inner circle
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(
            color: Colors.blue, // Center point
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
