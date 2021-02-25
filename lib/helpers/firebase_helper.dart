import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String USER_COLLECTION = "Users";

void addUserToFirebase(AuthUserResponse userData) async {
  final QuerySnapshot result = await FirebaseFirestore.instance
      .collection(USER_COLLECTION)
      .where("id", isEqualTo: userData.id.toString()).get();
  final List<DocumentSnapshot> documents = result.docs;

  if (documents.length == 0) {
    FirebaseFirestore.instance.collection(USER_COLLECTION)
      .doc("user_${userData.id.toString()}").set({
        "id": userData.id,
        "name": userData.firstName,
        "avatar": userData.avatar == null ? "" : "${ApiEndpoints.URL_ROOT}${userData.avatar}",
      })
      .then((value) => print("New user added to firebase"))
      .catchError((error) => print("Failed to add user: $error"));
  } else {
    FirebaseFirestore.instance.collection(USER_COLLECTION)
      .doc("user_${userData.id.toString()}").update({
        "id": userData.id,
        "name": userData.firstName,
        "avatar": userData.avatar == null ? "" : "${ApiEndpoints.URL_ROOT}${userData.avatar}",
      })
      .then((value) => print("User data updated to firebase"))
      .catchError((error) => print("Failed to update user: $error"));
  }
}