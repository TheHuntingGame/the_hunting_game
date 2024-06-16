import 'package:flutter/material.dart';
import 'package:the_hunting_game/authentication/register_page.dart';
import 'package:the_hunting_game/components/button_func.dart';
import 'package:the_hunting_game/components/square_tile.dart';
import 'package:the_hunting_game/components/text_field.dart';
import 'package:the_hunting_game/screens/in_game/map_page.dart';
import 'package:the_hunting_game/main.dart';
import 'package:the_hunting_game/screens/main_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  //initialize supabase client
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 50),

            //logo
            const Icon(Icons.lock, size: 100),

            const SizedBox(height: 20),

            //welcome back
            Text(
              'Get ready for Hunting!',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),
            //username textfield
            CustomTextField(
              controller: usernameController,
              hintText: 'Username',
              obscureText: false,
            ),

            const SizedBox(height: 10),

            //password textfield
            CustomTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),

            const SizedBox(height: 10),
            //forgot password?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),
            //sign in button
            CustomButtonFunc(label: 'Sign in', onPressed: () => SignUserIn()),

            const SizedBox(height: 25),
            //or continue with
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'or continue with',
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),
            //google + apple sign in button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //google button
                const SquareTile(imagePath: 'lib/images/google_logo.png'),
                const SizedBox(width: 25),
                //apple button
                const SquareTile(imagePath: 'lib/images/apple_logo.png'),
                const SizedBox(width: 25),
                //github button
                GestureDetector(
                    child: const SquareTile(
                        imagePath: 'lib/images/github_logo.png'),
                    onTap: () async {
                      final sm = ScaffoldMessenger.of(context);
                      await supabase.auth.signInWithOAuth(OAuthProvider.github);
                      sm.showSnackBar(const SnackBar(
                        content: Text('Logged in with GitHub'),
                      ));
                    }),
              ],
            ),

            const SizedBox(height: 25),
            //not a member? register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your first time here?',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: const Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: const Text(
                'Go Back',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

void SignUserIn() {
  print('Signing in user...');
}
