import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/ui/auth_pages/auth_bloc/auth_bloc.dart';

class AppDataStorage {
  final String packageName;
  AuthUserResponse userData;
  // ignore: close_sinks
  AuthBloc authBloc;

  String get authToken => userData?.authToken;

  AppDataStorage(this.packageName, this.authBloc);
}