import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:the_hunting_game/authentication/login_page.dart';
import 'package:the_hunting_game/screens/main_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    _getAuth();
    super.initState();
  }

  Future<void> _getAuth() async {
    setState(() {
      _user = supabase.auth.currentUser;
      _isLoading = false;
    });
    supabase.auth.onAuthStateChange.listen((event) {
      setState(() {
        _user = event.session?.user;
      });
    });
  }

  final SupabaseClient supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (_user == null) {
      return const LoginPage();
    } else {
      final username = _user!.email ?? 'Unknown'; // Extract the username
      return HomePage(username: username);
    }
  }
}

