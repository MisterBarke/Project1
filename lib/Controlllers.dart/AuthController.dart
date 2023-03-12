import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:stmm/Models.dart/Usermodels.dart';
import 'package:stmm/pages/ResgisterPage.dart';
import 'package:stmm/pages/admins_page.dart';

import '../pages/LoginPage.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  RxList<Usermodel> selectedUsers = RxList<Usermodel>([]);
  Rx<Usermodel> usermodel = Usermodel().obs;
  RxList<Usermodel> userlist = RxList<Usermodel>([]);
  String usercollection = 'users';
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController axeName = TextEditingController();
  TextEditingController arriver = TextEditingController();
  TextEditingController depart = TextEditingController();
  TextEditingController heureDepart = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    // _determinePosition;

    firebaseUser = Rxn<User>(auth.currentUser);
    ever(firebaseUser, setInitialScreen);
    userlist.bindStream(getUserById());
    firebaseUser.bindStream(auth.userChanges().cast());

    // buslist.bindStream(getBuslist());
  }

  setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => const RegisterPAge());
    } else {
      usermodel.bindStream(initialiseUserModel());
      Get.offAll(() => const AdminPage());
    }
  }

  Stream<Usermodel> initialiseUserModel() {
    return FirebaseFirestore.instance
        .collection(usercollection)
        .doc(firebaseUser.value!.uid)
        .snapshots()
        .map((snapshot) => Usermodel.fromSnapshot(snapshot));
  }

  Future logIn() async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((value) {
        String userId = value.user!.uid;
        _addUserToFirebase(userId);
        debugPrint('User added');

        // clear();

        return true;
      });
    } catch (e) {
      Get.snackbar('connection échoué', 'Ressayer à nouveau');
      debugPrint(e.toString());
      debugPrint('User not added');
    }
  }

  Future sinUp() async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((value) {
        String userId = value.user!.uid;
        _addUserToFirebase(userId);
        // clear();
      });
    } catch (e) {
      Get.snackbar('Inscription  échouée', 'Ressayer à nouveau');
      debugPrint(e.toString());
    }
  }

  Future singOut() async {
    try {
      // clear();
      await auth.signOut().whenComplete(() {});
    } catch (e) {
      Get.snackbar('Déconnection', '');
    }
  }

  _addUserToFirebase(String userId) {
    FirebaseFirestore.instance.collection('users').doc(userId).set({
      'name': name.text.trim(),
      'id': userId,
      'password': password.text.trim(),
      'email': email.text.trim(),
      'phone': phone.text.trim(),
    });
  }

  Stream<List<Usermodel>> getUserById() {
    return FirebaseFirestore.instance
        .collection(usercollection)
        // .where('axe', isNotEqualTo: '')
        .snapshots()
        .map(
          (docs) => docs.docs
              .map(
                (e) => Usermodel.fromSnapshot(e),
              )
              .toList(),
        );
  }

  // Stream<List<UserModel>> getFreeuserById() {
  //   return FirebaseFirestore.instance
  //       .collection(usercollection)
  //       .where('axe', isEqualTo: '')
  //       .snapshots()
  //       .map(
  //         (docs) => docs.docs
  //             .map(
  //               (e) => UserModel.fromSnapshot(e),
  //             )
  //             .toList(),
  //       );
  // }

  // Stream<List<UserModel>> getAlluserById() {
  //   return FirebaseFirestore.instance
  //       .collection(usercollection)
  //       .snapshots()
  //       .map(
  //         (docs) => docs.docs
  //             .map(
  //               (e) => UserModel.fromSnapshot(e),
  //             )
  //             .toList(),
  //       );
  // }

  // Future addBus() async {
  //   try {
  //     FirebaseFirestore.instance.collection(buscollection).doc().set({
  //       'numero': 'N°1',
  //       'isArrived': false,
  //       'driver': '',
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

}
