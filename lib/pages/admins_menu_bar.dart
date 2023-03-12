import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stmm/Controlllers.dart/AppController.dart';
import 'package:stmm/pages/AddAxePage.dart';
import 'package:stmm/pages/addBus.dart';

// import 'package:google_fonts/google_fonts.dart';

class AdminMenuBar extends StatelessWidget {
  const AdminMenuBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Abdoul Latif',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            accountEmail: Text('92085861',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.black,
              child: ClipOval(
                child: Icon(
                  Icons.person_rounded,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          ListTile(
              leading: const Icon(
                Icons.directions_rounded,
                color: Colors.white,
              ),
              title: const Text(
                'Axes',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).pop();
              }),
          ListTile(
            leading: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            title: const Text(
              'Nouvelle destination ',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const AdDestination();
              }));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person_add_alt_1,
              color: Colors.white,
            ),
            title: const Text(
              'Ajouter un chauffeur ',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const AdChauffeurPage();
              }));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: const Text(
              'Paramétre ',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            title: const Text(
              'Déconnexion ',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              authController.singOut();
            },
          ),
        ],
      ),
    );
  }
}
