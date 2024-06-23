import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:the_hunting_game/authentication/auth_functions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _StartPageState();
}

class _StartPageState extends State<LoginPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final githubIcon = brightness == Brightness.light
        ? 'lib/images/github_icon_dark.png'
        : 'lib/images/github_icon_light.png';
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //Email field
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    controller: _emailController,
                    decoration: const InputDecoration(label: Text("Email")),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  //Password field
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    decoration: const InputDecoration(label: Text("Password")),
                    obscureText: true,
                  ),
                  //Repeat Password field
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    controller: _repeatpasswordController,
                    decoration: const InputDecoration(
                        label: Text("Repeat Password - Only when signing up")),
                    obscureText: true,
                  ),
                  const SizedBox(height: 25.0),
                  //Sign In Button
                  ElevatedButton(
                    onPressed: () async {
                      await signinwithPassword(
                          _emailController, _passwordController, context);
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  const Divider(),
                  //SignUp Button
                  ElevatedButton(
                    onPressed: () async {
                      await signupwithPassword(
                          _emailController,
                          _passwordController,
                          _repeatpasswordController,
                          context);
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text("OR"),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  OutlinedButton.icon(
                    onPressed: () async {
                      await signinwithGoogle(context);
                    },
                    icon: Image.asset(
                      'lib/images/google_icon.png',
                      height: 20,
                    ),
                    label: const Text("Continue with Google"),
                  ),

                  OutlinedButton.icon(
                    onPressed: () async {
                      await signinwithGithub(context);
                    },
                    icon: Image.asset(
                      githubIcon,
                      height: 20,
                    ),
                    label: const Text("Continue with Github"),
                  ),

                  OutlinedButton.icon(
                    onPressed: () async {
                      await signinwithSpotify(context);
                    },
                    icon: Image.asset(
                      'lib/images/spotify_icon.png',
                      height: 20,
                    ),
                    label: const Text("Continue with Spotify"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
