import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../models/user_model.dart';

class AuthRepository {
  Future<bool> signup(String emailAddress, String password) async {
    print("in repo signup");
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future<bool> login(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      final String? deviceToken = await FirebaseMessaging.instance.getToken();
      final uID = credential.user?.uid ?? "";
      UserModel user = UserModel(
          email: emailAddress, uID: uID, deviceToken: deviceToken ?? "");
      addUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;
    }
    return true;
  }

  Future<bool> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print('Logout failed');
      return false;
    }
    return true;
  }

  addUser(UserModel user) async {
    final firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection("profiles").doc(user.uID).set(user.toJson());
    } catch (e) {}
  }
}
