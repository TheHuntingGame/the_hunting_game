import 'package:flutter/material.dart';
import 'pages/bottom_navigation.dart';
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
        useMaterial3: true, // Enable Material 3
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
        title: Text('TheHuntingGame - Start Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavigation()),
                );
              },
              child: Text('Join Game'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: ()  => _showCreateGameDialog(context),
              child: Text('Create Game'),
            ),
          ],
        ),
      ),
    );
  }
}

 void _showCreateGameDialog(BuildContext context) async {
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
          actions: <Widget>[
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
                      builder: (context) => BottomNavigation(),
                    ),
                  );
              },
            ),
          ],
        );
      },
    );
  }