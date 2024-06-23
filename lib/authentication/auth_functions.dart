import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:the_hunting_game/main.dart';
import 'package:the_hunting_game/screens/main_page.dart';

///SIGN IN ---- SIGN IN ---- SIGN IN ---- SIGN IN ---- SIGN IN ----
Future<void> signinwithPassword(TextEditingController emailController,
    TextEditingController passwordController, BuildContext context) async {
  try {
    final response = await supabase.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            HomePage(username: response.user!.email ?? 'Unknown'),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Oops! Sign In Failed: $e"),
        backgroundColor: const Color.fromARGB(255, 243, 49, 6),
      ),
    );
  }
}

///SIGN UP ---- SIGN UP ---- SIGN UP ---- SIGN UP ---- SIGN UP ----
Future<void> signupwithPassword(
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController repeatpasswordController,
    BuildContext context) async {
  if (passwordController.text == repeatpasswordController.text) {
    try {
      final response = await supabase.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User is logged in: ${response.user!.email}"),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HomePage(username: response.user!.email ?? 'Unknown'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Oops! Sign Up Failed!"),
          backgroundColor: Color.fromARGB(255, 243, 49, 6),
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Make sure the password and Repeatpassword are the same."),
      backgroundColor: Color.fromARGB(255, 243, 49, 6),
    ));
  }
}

///GOOGLE SIGN IN ---- GOOGLE SIGN IN ---- GOOGLE SIGN IN ---- GOOGLE SIGN IN ----
Future<void> signinwithGoogle(BuildContext context) async {
  final webClientId = dotenv.env['WEB_CLIENT_ID']!;
  final iosClientId = dotenv.env['IOS_CLIENT_ID']!;

  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: iosClientId,
    serverClientId: webClientId,
  );
  final googleUser = await googleSignIn.signIn();
  if (googleUser == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Sign in was canceled."),
      ),
    );
    return;
  }
  final googleAuth = await googleUser.authentication;
  final accessToken = googleAuth.accessToken;
  final idToken = googleAuth.idToken;

  if (accessToken == null) {
    throw 'No Access Token found.';
  }
  if (idToken == null) {
    throw 'No ID Token found.';
  }

  await supabase.auth.signInWithIdToken(
    provider: OAuthProvider.google,
    idToken: idToken,
    accessToken: accessToken,
  );
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => HomePage(username: '$googleUser'),
    ),
  );
}

///GITHUB SIGN IN ---- GITHUB SIGN IN ---- GITHUB SIGN IN ---- GITHUB SIGN IN ----
Future<void> signinwithGithub(BuildContext context) async {
  try {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.github,
      authScreenLaunchMode: LaunchMode.externalApplication,
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(username: 'hi'),
      ),
    );
  } catch (error) {
    print("Sign in with GitHub failed: $error");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error: $error"),
      ),
    );
  }
}

///SPOTIFY SIGN IN ---- SPOTIFY SIGN IN ----  SPOTIFY SIGN IN ----  SPOTIFY SIGN IN ---- 
Future<void> signinwithSpotify(BuildContext context) async {
  try {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.spotify,
      authScreenLaunchMode: LaunchMode.externalApplication,
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(username: 'hi'),
      ),
    );
  } catch (error) {
    print("Sign in with Spotify failed: $error");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error: $error"),
      ),
    );
  }
}