import 'package:flutter/material.dart';
import 'package:the_hunting_game/screens/intro_screen.dart';
import 'package:the_hunting_game/screens/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<bool> isFirstTimeOpen() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  if (isFirstTime) {
    await prefs.setBool('isFirstTime', false);
  }
  return isFirstTime;
}


Future <void> main() async {
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  WidgetsFlutterBinding.ensureInitialized();
  bool firstTime = await isFirstTimeOpen();
  runApp(MyApp(firstTime));
}


class MyApp extends StatelessWidget {
  final bool firstTime;

  const MyApp(this.firstTime, {super.key});

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
      home: firstTime ? IntroScreen() : HomePage(),
    );
  }
}

