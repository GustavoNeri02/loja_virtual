import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  //usuario final

  FirebaseAuth _auth = FirebaseAuth.instance; // única instância do Firebase

  late FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map(); //username, adress, email

  bool isLoading = false;

  void signUp(
      {required Map<String, dynamic> userdata,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
        email: userdata["email"], password: pass)
        .then((user) async {
          firebaseUser = user;
          await _saveUserData(userdata);

          onSuccess();
          isLoading = false;
          notifyListeners();
        }).catchError((e) {
          onFail();
          isLoading = false;
          notifyListeners();
        });
  }

  void signIn() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));

    isLoading = false;
    notifyListeners();
  }

  void recoverPass() {}

  void isLoggedIn() {}

  Future _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance.collection("Users").document(firebaseUser.uid).setData(userData);
  }
}


