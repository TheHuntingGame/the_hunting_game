import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _StartPageState();
}

class _StartPageState extends State<LoginPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  //Sign In Button
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await supabase.auth.signInWithPassword(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim());
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops! Sign In Failed!"),
                            backgroundColor: Color.fromARGB(255, 243, 49, 6),
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
                      try {
                        await supabase.auth.signUp(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim());
                        const SnackBar(
                          content: Text("Sign Up successful! Have fun!"),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops! Sign Up Failed!"),
                            backgroundColor: Color.fromARGB(255, 243, 49, 6),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
