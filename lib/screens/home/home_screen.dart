import 'package:flutter/material.dart';
import 'package:zelrap/data/models/account.dart';
import 'package:zelrap/screens/home/pages/feed_page.dart';
import 'package:zelrap/screens/home/pages/home_page.dart';
import 'package:zelrap/screens/home/pages/people_page.dart';
import 'package:zelrap/screens/home/pages/timeline_page.dart';

class HomeScreen extends StatefulWidget {
  final Account account;

  const HomeScreen({Key key, @required this.account}) : super(key: key);

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
        title: const Text("Hi, User"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (int index) {
          setState(() {
            tabIndex = index;
            print("TAP TAP TAP $index, $tabIndex");
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Theme.of(context).accentColor),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline, color: Theme.of(context).accentColor),
            title: new Text('Timeline'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Theme.of(context).accentColor),
            title: new Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people, color: Theme.of(context).accentColor),
            title: new Text('People'),
          ),
        ],
      ),
      body: tabIndex == 0
          ? HomePage()
          : tabIndex == 1 ? TimelinePage() : ProfilePage(account: widget.account),
    );
  }

  Widget _buildBody(BuildContext context, int index) {
    if (index == 0) {
      return HomePage();
    } else if (index == 1) {
      return TimelinePage();
    } else if (index == 2) {
      return ProfilePage(account: widget.account);
    } else if (index == 3) {
      return PeoplePage();
    }
  }
}
