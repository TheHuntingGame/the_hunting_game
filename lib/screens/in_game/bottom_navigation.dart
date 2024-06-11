import 'package:flutter/material.dart';
import 'package:the_hunting_game/screens/in_game/chat_page.dart';
import 'package:the_hunting_game/screens/in_game/settings_page.dart';
import 'package:the_hunting_game/screens/in_game/shop_page.dart';
import 'package:the_hunting_game/screens/in_game/map_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _MainPageState();
}

class _MainPageState extends State<BottomNavigation> {

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
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
            selectedIcon: Icon(Icons.shopping_cart),
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Shop',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.messenger),
            icon: Icon(Icons.messenger_outline_outlined),
            label: 'Chat',
            ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        /// Main page
        MapPage(),

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

