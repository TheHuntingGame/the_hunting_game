import 'package:flutter/material.dart';
import 'package:the_hunting_game/in_game/bottom_navigation.dart';

class GameSetup extends StatelessWidget {
  const GameSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
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
            Text('Listing all players in this round, ability to drag into teams when appropiate game mode is selected'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameModeSelect()),
                );
              },
              child: Text('Players Complete!'),
            ),
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
        title: Text('Game Mode Select'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Select the game modes: 4connect, tag game, caputre the flag, hide and seek, travel game, racing, etc...'),
            Text('Custom games and import games through AI or yourself'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FinalAdjustments()),
                );
              },
              child: Text('Overview'),
            ),
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
        title: Text('Final Adjustments'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('See all settings: players, teams, game mode, specific/special settings(like chat settings), etc...,'),
            Text('Ability to check last time'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavigation()),
                );
              },
              child: Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}


