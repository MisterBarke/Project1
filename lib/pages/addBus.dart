import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
                child: const TextField(
                  decoration: InputDecoration(
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
                child: const TextField(
                  decoration: InputDecoration(
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
                child: const TextField(
                  decoration: InputDecoration(
                      hintText: 'Numéro du bus',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none),
                )),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                height: 40,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const TextField(
                  decoration: InputDecoration(
                      hintText: 'Plaque d\'immatriculation',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: const Text(
                    'Valider',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
