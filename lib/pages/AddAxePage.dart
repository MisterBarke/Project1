import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:stmm/Controlllers.dart/AppController.dart';
import 'package:stmm/Models.dart/Usermodels.dart';
import 'package:stmm/pages/AssignTrajesPage.dart';

class AdDestination extends StatefulWidget {
  const AdDestination({super.key});

  @override
  State<AdDestination> createState() => _AdDestinationState();
}

class _AdDestinationState extends State<AdDestination> {
  @override
  void initState() {
    // TODO: implement initState
    authController.selectedUsers.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Text(
                'Nouvelle destination',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Container(
                height: 35,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: const TextField(
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: 'Rechercher un chauffeur',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Container(
                  height: 540,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                        children: authController.userlist
                            .map((element) => MyListTile(driver: element))
                            .toList()),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      authController.selectedUsers.isNotEmpty
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                              return const AssignTrajet();
                            }))
                          : Get.snackbar(
                              'Alert', 'Selectionner au moins un Chauffeur',
                              backgroundColor: Colors.white,
                              margin: const EdgeInsets.all(20));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black,
                      ),
                      child: const Text(
                        'Valider',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyListTile extends StatefulWidget {
  final Usermodel driver;

  const MyListTile({
    Key? key,
    required this.driver,
  }) : super(key: key);

  @override
  _MyListTileState createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  bool _isChecked = false;

  void _toggleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
      if (_isChecked) {
        authController.selectedUsers.add(widget.driver);
      } else {
        authController.selectedUsers.remove(widget.driver);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: _isChecked,
        onChanged: (bool? value) {
          _toggleCheckbox();
        },
        shape: CircleBorder(),
        activeColor: Colors.black,
        checkColor: Colors.white,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
      title: Text(widget.driver.name!),
      onTap: () {
        _toggleCheckbox();
        print(authController.selectedUsers.length.toString());
      },
      // tileColor: _isChecked ? Colors.grey[200] : null,
      shape: const Border(
        bottom: BorderSide(
          color: Colors.black,
          width: 1.0,
        ),
      ),
    );
  }
}
