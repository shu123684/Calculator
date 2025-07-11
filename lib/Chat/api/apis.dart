import 'package:calculator/Chat/models/chat_user.dart';
import 'package:calculator/Theme/ThemeManager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs {
  // For authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  // THeme Manager
  static ThemeManager themeManager = ThemeManager();

  // For accessing CLoud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // For Stroing self information
  static late ChatUser me;

  static User get user => auth.currentUser!;

  // for checking if user exist or not
  static Future<bool> userExist() async {
    return (await firestore.collection('user').doc(user.uid).get()).exists;
  }

  // for checking if user exist or not
  static Future<void> getSelfInfo() async {
    await firestore.collection('user').doc(user.uid).get().then((user) async {
      if(user.exists) {
        me = ChatUser.fromJson(user.data()!);
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  // for creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
      image: user.photoURL.toString(),
      name: user.displayName.toString(),
      about: 'hey',
      createdAt: time,
      isOnline: false,
      lastActive: time,
      id: user.uid,
      pushToken: "",
      email: user.email.toString(),
    );

    return (await firestore.collection('user').doc(user.uid).set(chatUser.toJson()));
  }

  // For getting all user
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser() {
    return firestore.collection('user').where('id', isNotEqualTo: user.uid).snapshots();
  }

  static Future<void> updateUserInfo() async {
    await firestore.collection('user').doc(user.uid).update({'name' : me.name, 'about' : me.about});
  }

}
