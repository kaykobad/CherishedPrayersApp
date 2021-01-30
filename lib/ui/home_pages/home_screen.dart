import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/ui/profile_tos_pp_feedback/profile_page.dart';
import 'package:cherished_prayers/ui/shared_widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final int selectedIndex;

  const HomeScreen({Key key, this.selectedIndex=4}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: Feed', style: optionStyle),
    Text('Index 1: Chat', style: optionStyle),
    Text('Index 2: Stories', style: optionStyle),
    Text('Index 3: Friends', style: optionStyle),
    ProfileScreen(),
  ];
  static const List<String> _titles = ['Feed', 'Chat', 'Stories', 'Friends', 'Profile'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 4 ? _getAppbarWithImage() : _getAppBar(),
      drawer: NavigationDrawer(
        name: "Kaykobad Reza",
        religion: "Islam",
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  AppBar _getAppbarWithImage() {
    return AppBar(
      title: Text(_titles[_selectedIndex], style: TextStyle(color: ColorConstants.white)),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      flexibleSpace: Image.asset(
        AssetConstants.PROFILE_BG,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
      elevation: 0,
      iconTheme: IconThemeData(color: ColorConstants.lightPrimaryColor),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      title: Text(_titles[_selectedIndex], style: TextStyle(color: ColorConstants.black)),
      centerTitle: true,
      backgroundColor: ColorConstants.white,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorConstants.lightPrimaryColor),
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
