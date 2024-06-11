import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
              title: const Text('anything'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListTile(
              title: const Text('anything'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
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
