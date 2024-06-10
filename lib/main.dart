import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_hunting_game/authentication/login_page.dart';
import 'package:the_hunting_game/components/button_func.dart';
import 'package:the_hunting_game/components/button_nav.dart';
import 'package:the_hunting_game/game_preparation/game_lobby_room.dart';
import 'package:the_hunting_game/game_preparation/game_setup.dart';
import 'package:the_hunting_game/in_game/settings_page.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: const Color.fromARGB(255, 0, 200, 255),
        useMaterial3: true, // Enable Material 3
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF05053A),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Hunting Game'),
        actions: [
          IconTheme(
            data: IconThemeData(size: 45), // Adjust the size as desired
            child: IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.push(
                context,
                //-- TODO -- : implement login system
                MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 150,
              child: CustomButtonNav(
                text: 'Join Game', 
                destination: GameLobbyRoomJoin()
                ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 150,
              child: CustomButtonFunc(label: 'Create Game', onPressed: () => CreateGamePopup(context)),
            ),
          ],
        ),
      ),
    );
  }
}

void CreateGamePopup(BuildContext context) async {
  final randomPin = (Random().nextInt(9000) + 1000).toString();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Game Created'),
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
                  return Container(
                    child: Center(
                      child: Text(
                        "Uh oh! Something went wrong...",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        actions:[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Proceed'),
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
