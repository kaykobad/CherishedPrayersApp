import 'package:cherished_prayers/data/models/models.dart';

class ChatUserData {
  int id;
  String name;
  String avatar;

  ChatUserData.fromAuthUserData(AuthUserResponse userData) {
    this.id = userData.id;
    this.name = userData.firstName;
    this.avatar = userData.avatar;
  }
}