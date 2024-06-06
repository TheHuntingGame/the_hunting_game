import 'package:flutter/material.dart';
import 'package:the_hunting_game/components/button_nav.dart';
import 'package:the_hunting_game/in_game/bottom_navigation.dart';

//This is the game lobby room join page
class GameLobbyRoomJoin extends StatelessWidget {
  const GameLobbyRoomJoin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Waiting for players to connect...'),
          automaticallyImplyLeading: false,
        ),
        body: CustomButtonNav(
          text: 'Assume players already connected', 
          destination: BottomNavigation()
          ),
    );
  }
}
