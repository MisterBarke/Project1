import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:search_page/search_page.dart';
import 'package:stmm/Controlllers.dart/AppController.dart';
import 'package:stmm/Models.dart/Trajets.dart';
import 'package:stmm/Models.dart/Usermodels.dart';
import 'package:stmm/pages/AssignTrajesPage.dart';
import 'package:uuid/uuid.dart';
// import 'package:uuid/uuid.dart';

class AdDestination extends StatefulWidget {
  const AdDestination({super.key});

  @override
  State<AdDestination> createState() => _AdDestinationState();
}

class _AdDestinationState extends State<AdDestination> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedTrip;
  String? _selectedTripId;
  String? _newTrip;
  String? _selectedChauffeur;
  String userSelectedId = authController.userlist.first.id!;
  final TextEditingController _lieuDepart = TextEditingController();
  final TextEditingController _destination = TextEditingController();

  List<String> trajets = ["Trajet 1", "Trajet 2", "Trajet 3"];

  late String _villeSelectionnee;
  late TimeOfDay _heureSelectionnee;
  late int _jourSelectionne;
  late DateTime _dateSelectionnee;
  // Importer la librairie intl pour formater la date

// Dans votre code, vous pouvez appeler cette méthode lorsque l'utilisateur a sélectionné une heure
  String onTimeSelected(TimeOfDay time) {
    // Obtenir la date actuelle
    DateTime now = DateTime.now();

    // Créer un objet DateTime avec la date actuelle et l'heure sélectionnée
    DateTime dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);

    // Formater la date au format ISO 8601
    String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime);

    // Afficher la date au format ISO 8601
    print(formattedDate);
    return formattedDate;
  }

  String onDateSelected(DateTime date) {
    // Formater la date au format ISO 8601
    String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(date);

    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    // authController.selectedUsers.clear();
    _heureSelectionnee = TimeOfDay.fromDateTime(DateTime(1995, 7, 3));
    _jourSelectionne = 10;
    _dateSelectionnee = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var children2 = [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Text(
          'Nouvelle destination',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            height: 540,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border:
                                    Border.all(width: 1, color: Colors.black)),
                            child: Obx(
                              () => DropdownButtonFormField<String>(
                                value: _selectedTripId,
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    hintText: 'Axe',
                                    border: InputBorder.none),
                                items: authController.destinationList.map((e) {
                                  return DropdownMenuItem<String>(
                                      onTap: () {
                                        setState(() {
                                          _selectedTrip =
                                              '${e.depart}-${e.destination}';
                                        });
                                      },
                                      value: e.id,
                                      child:
                                          Text('${e.depart}-${e.destination}'));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedTripId = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null && _newTrip == null) {
                                    return 'Please select or enter a trip';
                                  }
                                  return null;
                                },
                              ),
                            )),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text('Ajouter un trajet'),
                                      content: SizedBox(
                                        height: 110,
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black)),
                                              child: TextFormField(
                                                decoration: const InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    hintText:
                                                        'Lieu de départ / exple: Niamey',
                                                    border: InputBorder.none),
                                                controller: _lieuDepart,
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black)),
                                              child: TextFormField(
                                                decoration: const InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    hintText:
                                                        'Destination / exple: Dosso',
                                                    border: InputBorder.none),
                                                controller: _destination,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Annuler'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() async {
                                              String uid = const Uuid().v1();
                                              FirebaseFirestore.instance
                                                  .collection('Destinations')
                                                  .doc(uid)
                                                  .set({
                                                'id': uid,
                                                'destination': _destination.text
                                                    .trim()
                                                    .toUpperCase(),
                                                'depart': _lieuDepart.text
                                                    .trim()
                                                    .toUpperCase()
                                              });

                                              setState(() {
                                                _selectedTripId = uid;
                                                _selectedTrip =
                                                    '${_lieuDepart.text.trim().toUpperCase()}-${_destination.text.trim().toUpperCase()}';
                                              });
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: const Text('Ajouter'),
                                        ),
                                      ],
                                    ));
                          },
                          icon: const Icon(Icons.edit))
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: _dateSelectionnee,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2025),
                      ).then((date) {
                        if (date != null) {
                          setState(() {
                            _dateSelectionnee = date;
                          });
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Colors.grey, width: 1)),
                      // margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.event, color: Colors.black),
                          const SizedBox(width: 8.0),
                          Text(
                            'Le  ${_dateSelectionnee.day} / ${_dateSelectionnee.month}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(width: 8.0),
                          const Spacer(),
                          InkWell(
                            child: const Icon(Icons.edit, color: Colors.black),
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: _dateSelectionnee,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025),
                              ).then((date) {
                                if (date != null) {
                                  setState(() {
                                    _dateSelectionnee = date;
                                  });
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  InkWell(
                    onTap: () {
                      DatePicker.showTimePicker(
                        context,
                        showSecondsColumn: false,
                        onConfirm: (time) {
                          setState(() {
                            _heureSelectionnee = TimeOfDay.fromDateTime(time);
                          });
                        },
                        onChanged: (time) {
                          setState(() {
                            _heureSelectionnee = TimeOfDay.fromDateTime(time);
                          });
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Heure de départ',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          Text(
                            '${_heureSelectionnee.hour.toString()}:${_heureSelectionnee.minute.toString()}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                            value: _selectedChauffeur,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedChauffeur = newValue;
                              });
                              print(_selectedChauffeur);
                            },
                            items: authController.userlist
                                .map((chauffeur) => DropdownMenuItem(
                                      value: chauffeur.id,
                                      onTap: () {
                                        userSelectedId = chauffeur.id!;
                                        // print(userSelectedId);
                                      },
                                      child: Text(chauffeur.name!),
                                    ))
                                .toList(),
                            decoration: const InputDecoration(
                              // labelText: 'Sélectionnez un chauffeur',
                              hintText: 'Chauffeur ',
                              hintStyle:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                              border: OutlineInputBorder(),
                            )),
                      ),
                      // IconButton(
                      //     onPressed: () => showSearch(
                      //         context: context,
                      //         delegate: SearchPage(
                      //             suggestion: SingleChildScrollView(
                      //               child: Column(
                      //                 children: authController.userlist
                      //                     .map((element) => GestureDetector(
                      //                           onTap: () {
                      //                             setState(() {
                      //                               _selectedChauffeur =
                      //                                   element.name;
                      //                               userSelectedId =
                      //                                   element.id!;
                      //                             });
                      //                           },
                      //                           child: MyListTile(
                      //                               onChanged:
                      //                                   (Usermodel value) {
                      //                                 print(value.name);
                      //                                 authController
                      //                                     .selectedUsers
                      //                                     .clear();
                      //                                 authController
                      //                                     .selectedUsers
                      //                                     .add(value);
                      //                               },
                      //                               driver: element),
                      //                         ))
                      //                     .toList(),
                      //               ),
                      //             ),
                      //             searchStyle:
                      //                 const TextStyle(color: Colors.black),
                      //             builder: (user) => GestureDetector(
                      //                 onTap: () {
                      //                   // authcontroller.selectedDriver.add(user.nom);
                      //                   // Navigator.of(context).pop();
                      //                   // Navigator.of(context).push(
                      //                   //     MaterialPageRoute(
                      //                   //         builder: (BuildContext context) {
                      //                   //   return ChauffeuPage(user: user);
                      //                   // }));
                      //                 },
                      //                 child: MyListTile(
                      //                     onChanged: (Usermodel value) {
                      //                       authController.selectedUsers
                      //                           .clear();
                      //                       authController.selectedUsers
                      //                           .add(value);
                      //                     },
                      //                     driver: user)),
                      //             filter: ((user) => [user.name, user.axe]),
                      //             items: authController.userlist,
                      //             searchLabel: 'trouver un chauffeur',
                      //             failure: const Center(
                      //                 child: Text('Aucune correspondance')))),
                      //     icon: const Icon(
                      //       Icons.search,
                      //       color: Colors.black,
                      //       size: 30,
                      //     ))
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () async {
                      Get.defaultDialog(
                          title: 'chargement..',
                          content: const SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          ));
                      String id = const Uuid().v4();
                      if (_formKey.currentState!.validate()
                          // authController.usermodel.value.isAdmin == true
                          ) {
                        Trajet trajet = Trajet(
                          datee: onDateSelected(_dateSelectionnee),
                          heur: onTimeSelected(_heureSelectionnee),
                          idAdministrateur: authController.usermodel.value.id,
                          idChauffeur: _selectedChauffeur,
                          idTrajet: id,
                          positionArrivee: _selectedTrip,
                        );
                        await repositoryController
                            .ajouterTrajet(trajet)
                            .whenComplete(() {
                          authController.showNotification(
                              'Bravo', 'Voyage programé');
                        });
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Assign',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: children2,
        ),
      ),
    );
  }
}

// // class MyListTile extends StatefulWidget {
// //   final Usermodel driver;
// //   Function onChanged;
// //   MyListTile({
// //     Key? key,
// //     required this.driver,
// //     required this.onChanged,
// //   }) : super(key: key);

// //   @override
// //   _MyListTileState createState() => _MyListTileState();
// // }

// // class _MyListTileState extends State<MyListTile> {
// //   bool _isChecked = false;

// //   void _toggleCheckbox() {
// //     setState(() {
// //       _isChecked = !_isChecked;
// //       if (_isChecked) {
// //         authController.selectedUsers.clear();
// //         authController.selectedUsers.add(widget.driver);
// //       } else {
// //         authController.selectedUsers.remove(widget.driver);
// //       }
// //     });
// //   }

// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     if (authController.selectedUsers.contains(widget.driver)) {
// //       _isChecked = true;
// //       // repositoryController.userselected = widget.driver as Rx<Usermodel>;
// //     } else {
// //       _isChecked = false;
// //       authController.selectedUsers.remove(widget.driver);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       elevation: 5,
// //       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
// //       // decoration: BoxDecoration(
// //       //     border: Border.all(color: Colors.grey),
// //       //     borderRadius: const BorderRadius.all(Radius.circular(10))),
// //       child: ListTile(
// //         leading: Checkbox(
// //           value: _isChecked,
// //           // onChanged: (bool? value) {
// //           //   _toggleCheckbox();
// //           //   setState(() {});
// //           // },
// //           onChanged: widget.onChanged(widget.driver),
// //           // shape: const CircleBorder(),
// //           // activeColor: Colors.black,
// //           // checkColor: Colors.white,
// //           // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
// //           // visualDensity: VisualDensity.compact,
// //         ),
// //         title: Text(widget.driver.name!),
// //         onTap: () {
// //           setState(() {});
// //           _toggleCheckbox();

// //           print(authController.selectedUsers.length.toString());
// //         },
// //         tileColor: _isChecked ? Colors.grey[200] : null,
// //         shape: const Border(
// //           bottom: BorderSide(
// //             color: Colors.black,
// //             width: 1.0,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// }
