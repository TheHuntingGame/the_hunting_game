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
  @override
  void initState() {
    _getAuth();
    super.initState();
  }

  Future<void> _getAuth() async {
    setState(() {
      _user = supabase.auth.currentUser;
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
    return _user == null ? LoginPage() : HomePage();
  }
}
