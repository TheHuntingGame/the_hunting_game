import 'package:flutter/material.dart';
import 'package:the_hunting_game/pages/chat_page.dart';
import 'package:the_hunting_game/pages/settings_page.dart';
import 'package:the_hunting_game/pages/shop_page.dart';
import 'package:the_hunting_game/pages/main_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _MainPageState();
}

class _MainPageState extends State<BottomNavigation> {

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TheHuntingGame'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Shop',
          ),
          NavigationDestination(
            icon: Icon(Icons.messenger_sharp),
            label: 'Chat',
            ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        /// Main page
        MainPage(),

        //Shop page
        ShopPage(),

        //chat page
        ChatPage(),

        //Settings page
        SettingsPage(),
      ][currentPageIndex],
    );
  }
}

