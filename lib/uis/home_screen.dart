import 'package:flutter/material.dart';
import 'package:flutter_fitness/uis/settings_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _homeScreenController = PageController();
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My fitness pal'),
      ),
      body: PageView(
        controller: _homeScreenController,
        children: _pages,
        onPageChanged: (index) => _onPageChanged,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateCamera,
        child: const Icon(Icons.camera_alt_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlueAccent,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.question_mark,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.question_mark,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.settings_outlined,
                color: Colors.white,
              ),
              onPressed: () => _jumpToSettings(),
              focusColor: Colors.blue,
            )
          ],
        ),
      ),
    );
  }

  void _navigateCamera() {}

  _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _homeScreenController.jumpToPage(_selectedIndex);
  }

  _jumpToSettings() {
    _onPageChanged(3);
  }
}
