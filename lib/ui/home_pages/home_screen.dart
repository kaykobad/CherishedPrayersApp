import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/chat_pages/all_threads_screen.dart';
import 'package:cherished_prayers/ui/profile_tos_pp_feedback/profile_page.dart';
import 'package:cherished_prayers/ui/shared_widgets/avatar.dart';
import 'package:cherished_prayers/ui/shared_widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    AllThreadsPage(),
    Text('Index 2: Stories', style: optionStyle),
    Text('Index 3: Friends', style: optionStyle),
    ProfileScreen(),
  ];
  static const List<String> _titles = ['Feed', 'Chat', 'Stories', 'Friends', 'Profile'];

  AppDataStorage _appDataStorage;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      drawer: NavigationDrawer(
        name: _appDataStorage.userData.firstName,
        religion: _appDataStorage.userData.religion ?? "",
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  AppBar _getAppBar() {
    if (_selectedIndex == 1) return _getAppbarWithAvatar();
    else if (_selectedIndex == 4) return _getAppbarWithImage();
    return _getGeneralAppBar();
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

  AppBar _getGeneralAppBar() {
    return AppBar(
      title: Text(_titles[_selectedIndex], style: TextStyle(color: ColorConstants.black)),
      centerTitle: true,
      backgroundColor: ColorConstants.white,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorConstants.lightPrimaryColor),
    );
  }

  AppBar _getAppbarWithAvatar() {
    return AppBar(
      title: Text(_titles[_selectedIndex], style: TextStyle(color: ColorConstants.black)),
      centerTitle: true,
      backgroundColor: ColorConstants.white,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorConstants.lightPrimaryColor),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomAvatar(url: _appDataStorage.userData.avatar == null ? null : ApiEndpoints.URL_ROOT + _appDataStorage.userData.avatar, size: 36),
        ),
      ],
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
