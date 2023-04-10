import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:stmm/Controlllers.dart/AppController.dart';
import 'package:stmm/Models.dart/CahuffeurModel.dart';

class AdChauffeurPage extends StatelessWidget {
  const AdChauffeurPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Text(
                'Ajouter un chauffeur',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                height: 40,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  controller: authController.name,
                  decoration: const InputDecoration(
                      hintText: 'Nom',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none),
                )),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                height: 40,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  controller: authController.phone,
                  decoration: const InputDecoration(
                      hintText: 'télephone',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none),
                )),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                height: 40,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  controller: authController.busNumber,
                  decoration: const InputDecoration(
                      hintText: 'Numéro du bus',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    Get.defaultDialog(
                        title: 'chargement..',
                        content: const SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ));

                    await FirebaseFirestore.instance
                        .collection('Chauffeurs')
                        .add({
                      'name': authController.name.text.trim(),
                      'phone': authController.phone.text.trim(),
                      'busNumber': authController.busNumber.text.trim()
                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: const Text(
                      'Valider',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
