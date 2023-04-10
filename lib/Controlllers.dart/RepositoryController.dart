import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:stmm/Controlllers.dart/AppController.dart';
import '../Models.dart/ChaufferModel.dart';
import '../Models.dart/Trajets.dart';
import '../Models.dart/Usermodels.dart';

class RepositoryController extends GetxController {
  Rx<Usermodel> userselected = Usermodel().obs;
  RxString heureSelection = ''.obs;
  static RepositoryController instance = Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  RxList<Usermodel> freeDriver = RxList<Usermodel>([]);
  RxList<Usermodel> allDriver = RxList<Usermodel>([]);
  RxList<Trajet> chauffeurTrajets = RxList<Trajet>([]);
  RxList<Usermodel> userlist = RxList<Usermodel>([]);
  RxList<Usermodel> allAdmin = RxList<Usermodel>([]);
  RxList<Usermodel> destinationlist = RxList<Usermodel>([]);
  RxList<Usermodel> historiqueBychauffeurid = RxList<Usermodel>([]);

  // Future<Administrateur> getAdministrateur(String idAdministrateur) async {
  //   DocumentSnapshot doc =
  //       await _db.collection('Administrateurs').doc(idAdministrateur).get();
  //   return Administrateur.fromFirestore(doc);
  // }

  Future<void> ajouterTrajet(Trajet trajet) {
    return _db.collection('Trajets').doc(trajet.idTrajet).set({
      'datee': trajet.datee,
      'idChauffeur': trajet.idChauffeur,
      // 'positionDepart': trajet.positionDepart,
      'positionArrivee': trajet.positionArrivee,
      'statut': trajet.statut,
      'idAdministrateur': trajet.idAdministrateur,
      'heur': trajet.heur,
    });
  }

  Stream<List<Trajet>> trajetsParChauffeur() {
    return _db.collection('Trajets').snapshots().map((QuerySnapshot snapshot) =>
        snapshot.docs
            .map((DocumentSnapshot doc) => Trajet.fromSnapshot(doc))
            .toList());
  }

  chauffeurTrajet(Usermodel driver) {
    return FirebaseFirestore.instance
        .collection('Trajets')
        .doc(driver.id!)
        .get();
  }

  Future<List<Chauffeur>> chauffeursDisponibles() async {
    QuerySnapshot snapshot = await _db
        .collection('Chauffeurs')
        .where('disponible', isEqualTo: true)
        .get();
    return snapshot.docs
        .map((DocumentSnapshot doc) => Chauffeur.fromFirestore(doc))
        .toList();
  }

  Future<void> assignerTrajet(String idChauffeur, String positionDepart,
      String positionArrivee, DateTime dateDepart, String idAdministrateur) {
    return _db.collection('Trajets').add({
      'dateDepart': dateDepart,
      'idChauffeur': idChauffeur,
      'positionDepart': positionDepart,
      'positionArrivee': positionArrivee,
      'statut': 'en_attente',
      'idAdministrateur': idAdministrateur,
    });
  }

  // Stream<List<Administrateur>> administrateurs() {
  //   return _db.collection('Administrateurs').snapshots().map(
  //       (QuerySnapshot snapshot) => snapshot.docs
  //           .map((DocumentSnapshot doc) => Administrateur.fromFirestore(doc))
  //           .toList());
  // }
}
