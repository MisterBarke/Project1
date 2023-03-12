import 'package:cloud_firestore/cloud_firestore.dart';

class Chauffeur {
  String? idChauffeur;
  String? nom;
  String? prenom;
  String? email;
  bool? disponibilite;

  Chauffeur({
    this.idChauffeur,
    this.nom,
    this.email,
    this.disponibilite,
  });

  factory Chauffeur.fromFirestore(DocumentSnapshot doc) {
    Object? data = doc.data();
    return Chauffeur(
      idChauffeur: (doc as dynamic)['idChauffeur'],
      nom: (data as dynamic)['nom'] ?? '',
      email: (data as dynamic)['email'] ?? '',
      disponibilite: data['disponibilite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'idChauffeur': idChauffeur,
        'email': email,
        'nom': nom,
        'disponibilite': disponibilite,
      };
}
