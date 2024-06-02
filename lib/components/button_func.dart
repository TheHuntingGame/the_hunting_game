import 'package:flutter/material.dart';

//This is a custom buttom for going to places in a file
class CustomButtonFunc extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButtonFunc({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
