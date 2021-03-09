import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/theme/app_config.dart';
import 'package:cherished_prayers/theme/themes.dart';
import 'package:cherished_prayers/ui/auth_pages/auth_bloc/auth_bloc.dart';
import 'package:cherished_prayers/ui/auth_pages/auth_bloc/auth_state.dart';
import 'package:cherished_prayers/ui/feed_pages/feed_bloc/feed_bloc.dart';
import 'package:cherished_prayers/ui/feed_pages/feed_bloc/feed_state.dart';
import 'package:cherished_prayers/ui/pre_auth_pages/splash_screen.dart';
import 'package:cherished_prayers/ui/settings_pages/settings_bloc/settings_bloc.dart';
import 'package:cherished_prayers/ui/settings_pages/settings_bloc/settings_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/friends_pages/friends_bloc/friends_bloc.dart';
import 'ui/friends_pages/friends_bloc/friends_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _setThemeMode();
  configLoading();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String packageName = packageInfo.packageName;
  runApp(MyApp(packageName));
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 5000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = ColorConstants.white
    ..backgroundColor = ColorConstants.gray
    ..indicatorColor = ColorConstants.white
    ..textColor = ColorConstants.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

Future _setThemeMode() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool _isDarkMode = prefs.getBool('isDarkTheme') ?? false;
  themeManager.setProperties(_isDarkMode, prefs);
  await prefs.setBool('isDarkTheme', _isDarkMode);
}

class MyApp extends StatefulWidget {
  final String packageName;

  const MyApp(this.packageName);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthBloc authBloc;
  FriendsBloc friendsBloc;
  FeedBloc feedBloc;
  SettingsBloc settingsBloc;

  @override
  void initState() {
    super.initState();
    authBloc = AuthBloc(InitialAuthState());
    friendsBloc = FriendsBloc(InitialFriendsState());
    feedBloc = FeedBloc(InitialFeedState());
    settingsBloc = SettingsBloc(InitialSettingsState());
    themeManager.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    authBloc?.close();
    friendsBloc?.close();
    feedBloc?.close();
    settingsBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AppDataStorage(widget.packageName, authBloc, friendsBloc, feedBloc, settingsBloc),
      child: MaterialApp(
        title: StringConstants.APP_NAME,
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: themeManager.currentThemeMode(),
        home: SplashScreen(),
        builder: EasyLoading.init()
      ),
    );
  }
}
