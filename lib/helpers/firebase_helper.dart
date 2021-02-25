import 'package:cherished_prayers/data/models/chat_models/chat_user_data.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String USER_COLLECTION = "Users";
const String THREAD_COLLECTION = "Threads";
const String MESSAGE_COLLECTION = "Messages";

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

Future<Thread> getThread(ChatUserData user1, ChatUserData user2) async {
  String threadId = "thread_";
  if (user1.id > user2.id) threadId += "${user2.id}_${user1.id}";
  else threadId += "${user1.id}_${user2.id}";
  
  final QuerySnapshot result = await FirebaseFirestore.instance
      .collection(THREAD_COLLECTION)
      .where("id", isEqualTo: threadId).get();
  final List<DocumentSnapshot> documents = result.docs;

  if (documents.length == 0) {
    Thread t = Thread(threadId, user1.id, user1.name, user1.avatar, 0, user2.id, user2.name, user2.avatar, 0, "");
    FirebaseFirestore.instance.collection(THREAD_COLLECTION)
      .doc(threadId).set(t.toJson())
      .then((value) {
        print("New thread added to firebase");
        return t;
      })
      .catchError((error) {
        print("Failed to create thread: $error");
        return null;
      });
  } else {
    FirebaseFirestore.instance.collection(THREAD_COLLECTION)
      .doc(threadId).get()
      .then((value) {
        print("Thread data got from firebase");
        return Thread.fromJson(value.data());
      })
      .catchError((error) {
        print("Failed to get thread data: $error");
        return null;
      });
  }
}
