import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: Feed', style: optionStyle),
    Text('Index 1: Chat', style: optionStyle),
    Text('Index 2: Stories', style: optionStyle),
    Text('Index 3: Friends', style: optionStyle),
    Text('Index 4: Profile', style: optionStyle),
  ];
  static const List<String> _titles = ['Feed', 'Chat', 'Stories', 'Friends', 'Profile'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        centerTitle: true,
      ),
      drawer: _getDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  Widget _getDrawer() {
    return Drawer(
      child: Container(
        color: ColorConstants.drawerColor,
        child: Column(
          children: [
            DrawerHeader(
              child: Icon(
                Icons.account_circle_outlined,
                color: ColorConstants.lightPrimaryColor,
                size: 84,
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 12,
      selectedItemColor: ColorConstants.lightPrimaryColor,
      unselectedItemColor: ColorConstants.gray,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      unselectedFontSize: 14,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Feed',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message_outlined),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined),
          label: 'Stories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.supervisor_account_outlined),
          label: 'Friends',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
