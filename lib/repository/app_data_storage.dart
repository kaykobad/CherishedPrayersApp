import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/ui/auth_pages/auth_bloc/auth_bloc.dart';
import 'package:cherished_prayers/ui/feed_pages/feed_bloc/feed_bloc.dart';
import 'package:cherished_prayers/ui/friends_pages/friends_bloc/friends_bloc.dart';
import 'package:cherished_prayers/ui/settings_pages/settings_bloc/settings_bloc.dart';

class AppDataStorage {
  final String packageName;
  AuthUserResponse userData;
  RegisterRequest registerRequest;
  // ignore: close_sinks
  AuthBloc authBloc;
  FriendsBloc friendsBloc;
  FeedBloc feedBloc;
  SettingsBloc settingsBloc;

  // Password reset functionality
  String passwordResetEmail;
  String passwordResetOTP;

  // Configurations
  List<CountryModel> allCountries;
  List<LanguageModel> allLanguages;
  List<ReligionModel> allReligions;

  String get authToken => userData?.authToken;

  AppDataStorage(this.packageName, this.authBloc, this.friendsBloc, this.feedBloc, this.settingsBloc);
}