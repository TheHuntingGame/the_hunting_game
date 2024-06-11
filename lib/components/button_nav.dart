import 'package:flutter/material.dart';
import 'package:the_hunting_game/utils/no_animation_between_pages.dart';

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
          createNoAnimationRoute(destination),
        );
      },
      child: Text(text),
    );
  }
}
