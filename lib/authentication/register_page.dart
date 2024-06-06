import 'package:flutter/material.dart';
import 'package:the_hunting_game/authentication/login_page.dart';
import 'package:the_hunting_game/components/button_func.dart';
import 'package:the_hunting_game/components/square_tile.dart';
import 'package:the_hunting_game/components/textfield.dart';
import 'package:the_hunting_game/main.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRepeatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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

              const SizedBox(height:10),

              //password textfield
              CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              //passsword repeat textfield
              CustomTextField(
                controller: passwordRepeatController,
                hintText: 'Repeat Password',
                obscureText: true,
              ),

              const SizedBox(height: 25),
              //sign in button
              CustomButtonFunc(label: 'Sign Up', onPressed: ()=> SignUserUp()),

              const SizedBox(height: 25),
              //or continue with
              Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                      child: Text('or continue with', ),
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google button
                  SquareTile(imagePath: 'lib/images/google_logo.png'),
                  SizedBox(width: 25),
                  //apple button
                  SquareTile(imagePath: 'lib/images/apple_logo.png'),
              ],),

              const SizedBox(height: 25),

              //Already a member? Logging in
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already a member? ',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(width: 4),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: const Text('Log in',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              //not a member? register now
          ]),
        ),
      ),  
    );
  }
}

//function for signing user up
void SignUserUp() {
  print('Signing up user...');
}