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

  //Things for switch screens_BEGIN
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    //main
    MainPage(),
    //shop
    ShopPage(),
    //chat
    ChatPage(),
    //settings
    SettingsPage(),
  ];
  //Things for switch screens_END

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TheHuntingGame'),
        automaticallyImplyLeading: false,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Material(
        elevation: 5.0,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          showSelectedLabels: true, // Always show labels for selected items
          showUnselectedLabels: true, // Always show labels for unselected items
          type: BottomNavigationBarType.fixed,
          items: const [
            //main
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            //shop
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Shop'),
            //chat
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            //settings
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
