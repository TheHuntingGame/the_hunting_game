import 'package:flutter/material.dart';
import 'package:the_hunting_game/authentication/splashscreen.dart';
import 'package:the_hunting_game/components/button_nav.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to The Hunting Game - First Time Intro Screen'),
          automaticallyImplyLeading: false,
        ),
        body:
          const Center(
          child: CustomButtonNav(
            text: 'continue/skip', 
            destination: AuthPage(),
            ),
          ),
      
    );
  }
}