import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/theme/app_config.dart';
import 'package:cherished_prayers/theme/themes.dart';
import 'package:cherished_prayers/ui/pre_auth_pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setThemeMode();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String packageName = packageInfo.packageName;
  runApp(MyApp(packageName));
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
  @override
  void initState() {
    super.initState();
    themeManager.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AppDataStorage(widget.packageName),
      child: MaterialApp(
        title: StringConstants.APP_NAME,
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: themeManager.currentThemeMode(),
        home: SplashScreen(),
      ),
    );
  }
}
