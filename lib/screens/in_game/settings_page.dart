import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:the_hunting_game/authentication/login_page.dart';
import 'package:the_hunting_game/main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

final User? user = supabase.auth.currentUser;
class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
                    Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListTile(
              title: Text('$user'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListTile(
              title: const Text('anything'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListTile(
              title: const Text('Sign Out'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () async {
                await supabase.auth.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
                final sm = ScaffoldMessenger.of(context);
                sm.showSnackBar(const SnackBar(
                  content: Text('Logged out'),
                ));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListTile(
              title: const Text('Credits'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreditsPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credits'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ListTile(
            title: Text('Developer'),
            subtitle: Text('lunatics975, Mythendros (github)'),
          ),
          ListTile(
            title: Text('Designer'),
            subtitle: Text('not us'),
          ),
          ListTile(
            title: Text('Project Manager'),
            subtitle: Text('never heard of...'),
          ),
          ListTile(
            title: Text('Special Thanks'),
            subtitle: Text('Flutter Community'),
          ),
          ListTile(
            title: Text('LICENSE'),
            subtitle: Text('MIT License'),
          ),
        ],
      ),
    );
  }
}
