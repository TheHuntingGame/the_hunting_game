import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:the_hunting_game/components/button_func.dart';
import 'package:the_hunting_game/components/button_nav.dart';
import 'package:the_hunting_game/screens/game_preparation/lobby.dart';
import 'package:the_hunting_game/screens/game_preparation/setup.dart';

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    // Show the SnackBar when the HomePage is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("User is logged in: $username"),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('The Hunting Game'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
              width: 150,
              child: CustomButtonNav(
                text: 'Join Game',
                destination: GameLobbyRoomJoin(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 150,
              child: CustomButtonFunc(
                label: 'Create Game',
                onPressed: () => createGamePopup(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


void createGamePopup(BuildContext context) async {
  final randomPin = (Random().nextInt(9000) + 1000).toString();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Game Created'),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Game PIN: $randomPin'),
            SizedBox(
              height: 200,
              width: 200,
              child: QrImageView(
                data: randomPin,
                version: 3,
                gapless: false,
                constrainErrorBounds: false,
                errorStateBuilder: (cxt, err) {
                  return const Center(
                    child: Text(
                      "Uh oh! Something went wrong...",
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        actions:[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Proceed'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameSetup(),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}
