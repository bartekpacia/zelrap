import 'package:flutter/material.dart';
import 'package:zelrap/screens/home/pages/home_page.dart';
import 'package:zelrap/screens/home/pages/notifications_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageController = PageController();
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hi, User'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (int index) {
          setState(() {
            tabIndex = index;
            print('tapped $index, $tabIndex');
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Theme.of(context).accentColor),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Theme.of(context).accentColor),
            title: new Text('Notifications'),
          ),
        ],
      ),
      body: tabIndex == 0 ? HomePage() : NotificationsPage(),
    );
  }
}
