import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stmm/Models.dart/ChaufferModel.dart';

class ChauffeurModel {
  String? name;
  String? phone;
  String? busNumber;
  // String? plaque;

  ChauffeurModel({this.busNumber, this.name, this.phone});
  ChauffeurModel.fromsnapshot(DocumentSnapshot snapshot) {
    name = (snapshot.data() as dynamic)['name'];
    phone = (snapshot.data() as dynamic)['phone'];
    busNumber = (snapshot.data() as dynamic)['busNumber'];
  }
}
