// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  //usuario final

  FirebaseAuth _auth = FirebaseAuth.instance; // única instância do Firebase

  FirebaseUser? firebaseUser;
  Map<String, dynamic> userData = Map(); //username, adress, email

  bool isLoading = false;

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrUser();
  }

  void signUp(
      {required Map<String, dynamic> userdata,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
            email: userdata["email"], password: pass)
        .then((user) async {
      firebaseUser = user;
      await _saveUserData(userdata);
      onSuccess();
      notifyListeners();
    }).catchError((e) {
      onFail();
    });
    isLoading = false;
    notifyListeners();
  }

  void signIn(
      {required String email,
      required String password,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) async {
      firebaseUser = user;
      await _loadCurrUser();
      onSuccess();
      notifyListeners();
    }).catchError((e) {
      onFail();
    });

    isLoading = false;
    notifyListeners();
  }

  void recoverPass() {}

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection("Users")
        .document(firebaseUser!.uid)
        .setData(userData);
  }

  Future _loadCurrUser() async {
    if (firebaseUser == null) {
      firebaseUser = await _auth.currentUser();
    }
    if (firebaseUser != null) {
      if (this.userData["name"] == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection("Users")
            .document(firebaseUser!.uid)
            .get();
        this.userData = docUser.data;
      }
    }
    notifyListeners();
  }

  void signOut() async {
    await _auth.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }
}
