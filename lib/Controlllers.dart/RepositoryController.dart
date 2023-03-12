import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../Models.dart/AdminModel.dart';
import '../Models.dart/ChaufferModel.dart';
import '../Models.dart/Trajets.dart';
import '../Models.dart/Usermodels.dart';

class RepositoryController extends GetxController {
  static RepositoryController instance = Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  RxList<Usermodel> freeDriver = RxList<Usermodel>([]);
  RxList<Usermodel> allDriver = RxList<Usermodel>([]);
  RxList<Usermodel> allTrajets = RxList<Usermodel>([]);
  RxList<Usermodel> userlist = RxList<Usermodel>([]);
  RxList<Usermodel> allAdmin = RxList<Usermodel>([]);
  RxList<Usermodel> historiqueBychauffeurid = RxList<Usermodel>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<Administrateur> getAdministrateur(String idAdministrateur) async {
    DocumentSnapshot doc =
        await _db.collection('Administrateurs').doc(idAdministrateur).get();
    return Administrateur.fromFirestore(doc);
  }

  Future<void> ajouterTrajet(Trajet trajet) {
    return _db.collection('Trajets').add({
      'dateDepart': trajet.dateDepart,
      'idChauffeur': trajet.idChauffeur,
      'positionDepart': trajet.positionDepart,
      'positionArrivee': trajet.positionArrivee,
      'statut': trajet.statut,
      'idAdministrateur': trajet.idAdministrateur,
    });
  }

  Stream<List<Trajet>> trajetsParChauffeur(String idChauffeur) {
    return _db
        .collection('Trajets')
        .where('idChauffeur', isEqualTo: idChauffeur)
        .orderBy('dateDepart', descending: true)
        .snapshots()
        .map((QuerySnapshot snapshot) => snapshot.docs
            .map((DocumentSnapshot doc) => Trajet.fromFirestore(doc))
            .toList());
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

  Stream<List<Administrateur>> administrateurs() {
    return _db.collection('Administrateurs').snapshots().map(
        (QuerySnapshot snapshot) => snapshot.docs
            .map((DocumentSnapshot doc) => Administrateur.fromFirestore(doc))
            .toList());
  }
}
