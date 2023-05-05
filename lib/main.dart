import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:stmm/Controlllers.dart/%20%20%20.dart';
import 'package:stmm/Controlllers.dart/RepositoryController.dart';

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
    // FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  }

  Future<void> _backgroundHandler(RemoteMessage message) async {
    print("Message received in background");
    // Traite le message reçu en arrière-plan
  }
}

Future<void> _initializeNotifications() async {
  // initialise le plugin flutter_local_notifications
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
    Get.put(RepositoryController());
  });
  _initializeNotifications();
  // await FirebaseMessaging.instance.requestPermission();

  // Configure la réception des notifications
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print("Message received");
  //   // Affiche une notification locale lors de la réception du message
  // });
  // FirebaseMessagingService().initialise();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
