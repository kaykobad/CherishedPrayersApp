import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/ui/auth_pages/auth_bloc/auth_bloc.dart';

class AppDataStorage {
  final String packageName;
  AuthUserResponse userData;
  RegisterRequest registerRequest;
  // ignore: close_sinks
  AuthBloc authBloc;

  // Password reset functionality
  String passwordResetEmail;
  String passwordResetOTP;

  // Configurations
  List<CountryModel> allCountries;
  List<LanguageModel> allLanguages;
  List<ReligionModel> allReligions;

  String get authToken => userData?.authToken;

  AppDataStorage(this.packageName, this.authBloc);
}