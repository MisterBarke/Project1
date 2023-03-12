import 'package:cloud_firestore/cloud_firestore.dart';

class Administrateur {
  String? idAdministrateur;
  String? nom;
  String? prenom;
  String? email;

  Administrateur({
    this.idAdministrateur,
    this.nom,
    this.prenom,
    this.email,
  });

  factory Administrateur.fromFirestore(DocumentSnapshot doc) {
    Map data = (doc.data() as dynamic);
    return Administrateur(
      idAdministrateur: doc.id,
      nom: data['nom'] ?? '',
      prenom: data['prenom'] ?? '',
      email: data['email'] ?? '',
    );
  }
}
