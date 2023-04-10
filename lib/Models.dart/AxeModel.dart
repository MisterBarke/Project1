import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Axemodel {
  String? destination;
  String? depart;
  String? id;
  Axemodel({this.depart, this.destination, this.id});
  factory Axemodel.fromsnap(DocumentSnapshot doc) {
    return Axemodel(
      depart: (doc.data() as dynamic)['depart'],
      id: (doc.data() as dynamic)['id'],
      destination: (doc.data() as dynamic)['destination'],
    );
  }
}
