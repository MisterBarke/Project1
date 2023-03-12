import 'package:cloud_firestore/cloud_firestore.dart';

class Trajet {
  String? idTrajet;
  Timestamp? dateDepart;
  String? idChauffeur;
  String? positionDepart;
  String? positionArrivee;
  String? statut;
  String? idAdministrateur;

  Trajet({
    this.idTrajet,
    this.dateDepart,
    this.idChauffeur,
    this.positionDepart,
    this.positionArrivee,
    this.statut,
    this.idAdministrateur,
  });

  factory Trajet.fromFirestore(DocumentSnapshot doc) {
    Map data = (doc.data() as dynamic);
    return Trajet(
      idTrajet: doc['idTrajet'],
      idAdministrateur: data['idAdministrateur'],
      dateDepart: data['dateDepart'],
      idChauffeur: data['idChauffeur'] ?? '',
      positionDepart: data['positionDepart'],
      positionArrivee: data['positionArrivee'],
      statut: data['statut'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'idTrajet': idTrajet,
        'dateDepart': dateDepart,
        'positionArrivee': positionArrivee,
        ' positionDepart': positionDepart,
        'statut': statut,
      };
}
