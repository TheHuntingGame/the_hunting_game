import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:the_hunting_game/screens/main_page.dart';

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
    dotenv.load();
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
                  const SizedBox(height: 25.0),
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
                      try {
                        await supabase.auth.signInWithPassword(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim());
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Oops! Sign In Failed: $e"),
                            backgroundColor:
                                const Color.fromARGB(255, 243, 49, 6),
                          ),
                        );
                      }
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
                      if (_passwordController.text ==
                          _passwordController.text) {
                        try {
                          final response = await supabase.auth.signUp(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );

                          // Check if the sign-up was successful
                          if (response.user != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "User is logged in: ${response.user!.email}"),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(
                                    username:
                                        response.user!.email ?? 'Unknown'),
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
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              "Make sure the password and Repeatpassword are the same."),
                          backgroundColor: Color.fromARGB(255, 243, 49, 6),
                        ));
                      }
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
                      final webClientId = dotenv.env['WEB_CLIENT_ID']!;
                      final iosClientId = dotenv.env['IOS_CLIENT_ID']!;

                      final GoogleSignIn googleSignIn = GoogleSignIn(
                        clientId: iosClientId,
                        serverClientId: webClientId,
                      );
                      final googleUser = await googleSignIn.signIn();
                      // Check if the user canceled the sign-in process
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
                          builder: (context) =>
                              HomePage(username: '$googleSignIn'),
                        ),
                      );
                    },
                    icon: Image.network(
                      "https://cdn.freebiesupply.com/logos/large/2x/google-icon-logo-png-transparent.png",
                      height: 20,
                    ),
                    label: const Text("Continue with Google"),
                  ),

                  OutlinedButton.icon(
                    onPressed: () async {
                      await supabase.auth.signInWithOAuth(OAuthProvider.github);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(username: 'hi'),
                        ),
                      );
                    },
                    icon: Image.network(
                      "https://cdn.freebiesupply.com/logos/large/2x/github-icon-logo-png-transparent.png",
                      height: 20,
                    ),
                    label: const Text("Continue with Github"),
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
