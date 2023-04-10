import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialise() async {
    // Demande la permission pour envoyer des notifications
    await _fcm.requestPermission();

    // Configure la réception des notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Message received");
      // Affiche une notification locale lors de la réception du message
    });

    // Configure la gestion des messages lors de la réception en arrière-plan
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  }

  Future<void> _backgroundHandler(RemoteMessage message) async {
    print("Message received in background");
    // Traite le message reçu en arrière-plan
  }
}
