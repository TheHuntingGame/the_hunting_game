import 'package:flutter/material.dart';

//This is a custom buttom for switching between pages

class CustomButtonNav extends StatelessWidget {
  final String text;
  final Widget destination;

  CustomButtonNav({required this.text, required this.destination});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Text(text),
    );
  }
}
