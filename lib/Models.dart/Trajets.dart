import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Trajet {
  String? idTrajet;
  DateTime? dateDepart;
  String? idChauffeur;
  // String? positionDepart;
  String? positionArrivee;
  String? statut;
  String? idAdministrateur;
  String? datee;

  String? heur;
  DateTime? heure;

  Trajet(
      {this.idTrajet,
      this.dateDepart,
      this.idChauffeur,
      // this.positionDepart,
      this.positionArrivee,
      this.statut,
      this.datee,
      this.heur,
      this.idAdministrateur,
      this.heure});

  factory Trajet.fromSnapshot(DocumentSnapshot doc) {
    return Trajet(
      heure: DateTime.parse((doc.data() as dynamic)['heur']),
      idTrajet: (doc.data() as dynamic)['idTrajet'],
      idAdministrateur: (doc.data() as dynamic)['idAdministrateur'],
      dateDepart: DateTime.parse((doc.data() as dynamic)['datee']),
      idChauffeur: (doc.data() as dynamic)['idChauffeur'] ?? '',
      // positionDepart: data['positionDepart'],
      positionArrivee: (doc.data() as dynamic)['positionArrivee'],
      statut: (doc.data() as dynamic)['statut'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        // 'idTrajet': idTrajet,
        // 'dateDepart': dateDepart,
        'positionArrivee': positionArrivee,
        // ' positionDepart': positionDepart,
        'statut': statut,
        // 'heure': heure,
      };
}
