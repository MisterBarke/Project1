import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stmm/Models.dart/Trajets.dart';

class Usermodel {
  String? id;
  String? phone;
  String? email;
  String? password;
  String? name;
  bool? isAdmin;
  String? axe;
  String? imageUrl;
  List<Trajet> trajets = <Trajet>[];

  Usermodel(
      {this.phone,
      this.id,
      this.email,
      this.imageUrl,
      this.password,
      this.name,
      this.isAdmin,
      this.axe});

  Usermodel.fromSnapshot(DocumentSnapshot snapshot) {
    id = (snapshot.data() as dynamic)['id'];
    imageUrl = (snapshot.data() as dynamic)['imageUrl'];

    axe = (snapshot.data() as dynamic)['axe'];
    email == (snapshot.data() as dynamic)['email'];
    password = (snapshot.data() as dynamic)['password'];
    name = (snapshot.data() as dynamic)['name'];
    isAdmin = (snapshot.data() as dynamic)['isAdmin'];
    phone = (snapshot.data() as dynamic)['phone'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'name': name,
        'isAdmin': isAdmin,
        'phone': phone,
        'imageUrl': imageUrl
      };

  List<Trajet> _convertCartItems(List cartFomDb) {
    List<Trajet> result = [];
    if (cartFomDb.isNotEmpty) {
      for (var element in cartFomDb) {
        result.add(Trajet.fromSnapshot(element));
      }
    }
    return result;
  }
}
