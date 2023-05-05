import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:stmm/Controlllers.dart/AppController.dart';
import 'package:stmm/Models.dart/AxeModel.dart';
import 'package:stmm/Models.dart/CahuffeurModel.dart';
import 'package:stmm/Models.dart/Trajets.dart';
import 'package:stmm/Models.dart/Usermodels.dart';
import 'package:stmm/pages/Login&ReisterAsk.dart';
import 'package:stmm/pages/ResgisterPage.dart';
import 'package:stmm/pages/admins_page.dart';

import '../pages/LoginPage.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  RxInt year = DateTime.now().year.obs;
  RxInt day = DateTime.now().day.obs;
  RxInt month = DateTime.now().month.obs;
  RxList<Usermodel> usersOfday = RxList<Usermodel>([]);
  FirebaseAuth auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  RxList<Usermodel> selectedUsers = RxList<Usermodel>([]);
  Rx<Usermodel> usermodel = Usermodel().obs;
  RxList<Usermodel> userlist = RxList<Usermodel>([]);
  RxList<Usermodel> allAdmins = RxList<Usermodel>([]);
  RxList<ChauffeurModel> chauffeursCanSinup = RxList<ChauffeurModel>([]);

  String usercollection = 'users';
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController busNumber = TextEditingController();
  TextEditingController axeName = TextEditingController();
  TextEditingController arriver = TextEditingController();
  TextEditingController depart = TextEditingController();
  TextEditingController heureDepart = TextEditingController();
  RxList<Trajet> chauffeurTrajets = RxList<Trajet>([]);
  RxList<Axemodel> destinationList = RxList<Axemodel>([]);
  @override
  void onReady() {
    super.onReady();
    // _determinePosition;
    getData();
    showNotification("Salut", 'nouveau message');
    firebaseUser = Rxn<User>(auth.currentUser);
    ever(firebaseUser, setInitialScreen);
    userlist.bindStream(getUserById());
    allAdmins.bindStream(getALladminById());
    chauffeurTrajets.bindStream(alltrajets());
    destinationList.bindStream(getdestinationlist());
    chauffeursCanSinup.bindStream(getChauffeurCanSinup());
    firebaseUser.bindStream(auth.userChanges().cast());

    // buslist.bindStream(getBuslist());
  }

  Future<void> showNotification(String title, String body) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  Future<void> getData() async {
    List<Trajet> events = [];
    List<Usermodel> users = <Usermodel>[];
    Usermodel user;
    // Parcourir les documents de la collection Firestore
    for (var document in authController.chauffeurTrajets) {
      // Extraire la date de création du document
      DateTime createdAt = document.dateDepart!;
      if (createdAt.year == year.value &&
              createdAt.month == month.value &&
              createdAt.day == day.value
          // widget.driver!.id == document.idChauffeur
          ) {
        for (var element in authController.userlist) {
          if (element.id == document.idChauffeur) {
            users.contains(element) ? null : users.add(element);
          }
        }
        events.add(document);
      }
    }
    usersOfday.value = users;
    // setState(() {
    //   _events = events;
    //   _users = users;
    // });
  }

  setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => const LoginReisterAsk());
    } else {
      usermodel.bindStream(initialiseUserModel());
      Get.offAll(() => const AdminPage());
    }
  }

  Stream<List<Usermodel>> getUserById() {
    return FirebaseFirestore.instance
        .collection(usercollection)
        .where('isAdmin', isEqualTo: false)
        .snapshots()
        .map(
          (docs) => docs.docs
              .map(
                (e) => Usermodel.fromSnapshot(e),
              )
              .toList(),
        );
  }

  Stream<List<Usermodel>> getALladminById() {
    return FirebaseFirestore.instance
        .collection(usercollection)
        .where('isAdmin', isEqualTo: true)
        .snapshots()
        .map(
          (docs) => docs.docs
              .map(
                (e) => Usermodel.fromSnapshot(e),
              )
              .toList(),
        );
  }

  Stream<List<Trajet>> alltrajets() {
    return FirebaseFirestore.instance
        .collection('Trajets')
        .orderBy('heur', descending: true)
        // .where('axe', isNotEqualTo: '')
        .snapshots()
        .map(
          (docs) => docs.docs
              .map(
                (e) => Trajet.fromSnapshot(e),
              )
              .toList(),
        );
  }

  Stream<List<Axemodel>> getdestinationlist() {
    return FirebaseFirestore.instance
        .collection('Destinations')
        // .where('axe', isNotEqualTo: '')
        .snapshots()
        .map(
          (docs) => docs.docs
              .map(
                (e) => Axemodel.fromsnap(e),
              )
              .toList(),
        );
  }

  Stream<List<ChauffeurModel>> getChauffeurCanSinup() {
    return FirebaseFirestore.instance.collection('Chauffeurs').snapshots().map(
          (docs) => docs.docs
              .map(
                (e) => ChauffeurModel.fromsnapshot(e),
              )
              .toList(),
        );
  }


  Stream<Usermodel> initialiseUserModel() {
    return FirebaseFirestore.instance
        .collection(usercollection)
        .doc(firebaseUser.value!.uid)
        .snapshots()
        .map((snapshot) => Usermodel.fromSnapshot(snapshot));
  }

  Future logIn(bool isAdmin) async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: '${phone.text.trim()}@gmail.com',
              password: password.text.trim())
          .then((value) {
        // String userId = value.user!.uid;
        // _addUserToFirebase(userId, isAdmin);
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

  Future sinUp(bool isAdmin, String imagUrl) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: '${phone.text.trim()}@gmail.com',
              password: password.text.trim())
          .then((value) {
        String userId = value.user!.uid;
        _addUserToFirebase(userId, isAdmin, imagUrl);
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

  _addUserToFirebase(String userId, bool isAdmin, String imageUrl) {
    FirebaseFirestore.instance.collection('users').doc(userId).set({
      'name': name.text.trim(),
      'id': userId,
      'password': password.text.trim(),
      'email': '${phone.text.trim()}@gmail.com',
      'phone': phone.text.trim(),
      'isAdmin': isAdmin,
      'imageUrl': imageUrl
    });
  }

  upadteUserData(Map<String, dynamic> data, String id) {
    FirebaseFirestore.instance.collection('users').doc(id).update(data);
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
