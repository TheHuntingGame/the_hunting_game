import 'package:flutter/material.dart';
import 'package:the_hunting_game/authentication/splashscreen.dart';
import 'package:the_hunting_game/screens/intro_screen.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  bool firstTime = await isFirstTimeOpen();
  runApp(MyApp(firstTime));
}

final supabase = Supabase.instance.client;

class MyApp extends StatefulWidget {
  final bool firstTime;

  const MyApp(this.firstTime, {super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        final brightness = MediaQuery.of(context).platformBrightness;
        final isDarkMode = brightness == Brightness.dark;

        if (isDarkMode) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }

        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            colorSchemeSeed: const Color.fromARGB(255, 0, 200, 255),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorSchemeSeed: const Color(0xFF05053A),
            useMaterial3: true,
          ),
          themeMode: ThemeMode.system,
          home: widget.firstTime ? IntroScreen() : AuthPage(),
          builder: (context, child) {
            return AnimatedTheme(
              data: ThemeData(brightness: isDarkMode ? Brightness.dark : Brightness.light),
              duration: const Duration(milliseconds: 500),
              child: child!,
            );
          },
        );
      },
    );
  }
}


