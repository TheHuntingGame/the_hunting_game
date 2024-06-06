import 'package:flutter/material.dart';
import 'package:the_hunting_game/components/button_nav.dart';
import 'package:the_hunting_game/in_game/bottom_navigation.dart';

class GameSetup extends StatelessWidget {
  const GameSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Game Setup'),
            Text('Waiting for players to connect...'),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'Listing all players in this round, ability to drag into teams when appropiate game mode is selected'),
            CustomButtonNav(
                text: 'Game Mode Select', destination: GameModeSelect()),
          ],
        ),
      ),
    );
  }
}

class GameModeSelect extends StatelessWidget {
  const GameModeSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Mode Select'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'Select the game modes: 4connect, tag game, caputre the flag, hide and seek, travel game, racing, etc...'),
            const Text('Custom games and import games through AI or yourself'),
            CustomButtonNav(text: 'Overview', destination: FinalAdjustments()),
          ],
        ),
      ),
    );
  }
}

class FinalAdjustments extends StatelessWidget {
  const FinalAdjustments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Adjustments'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'See all settings: players, teams, game mode, specific/special settings(like chat settings), etc...,'),
            const Text('Ability to check last time'),
            CustomButtonNav(text: 'Start Game', destination: BottomNavigation()),
          ],
        ),
      ),
    );
  }
}
