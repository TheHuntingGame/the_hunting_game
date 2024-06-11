import 'package:flutter/material.dart';
import 'package:the_hunting_game/components/button_nav.dart';
import 'package:the_hunting_game/screens/main_page.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to The Hunting Game - First Time Intro Screen'),
          automaticallyImplyLeading: false,
        ),
        body: const CustomButtonNav(
          text: 'continue/skip', 
          destination: HomePage(),
          ),
    );
  }
}