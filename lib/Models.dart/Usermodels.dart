import 'package:cloud_firestore/cloud_firestore.dart';

class Usermodel {
  String? id;
  String? email;
  String? password;
  String? name;
  bool? isAdmin;
  String? axe;

  Usermodel(
      {this.id, this.email, this.password, this.name, this.isAdmin, this.axe});

  Usermodel.fromSnapshot(DocumentSnapshot snapshot) {
    id = (snapshot.data() as dynamic)['id'];
    axe = (snapshot.data() as dynamic)['axe'];
    email == (snapshot.data() as dynamic)['email'];
    password = (snapshot.data() as dynamic)['password'];
    name = (snapshot.data() as dynamic)['name'];
    isAdmin = (snapshot.data() as dynamic)['isAdmin'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'name': name,
        'isAdmin': isAdmin,
      };
}
