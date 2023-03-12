import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:stmm/Controlllers.dart/AppController.dart';
import 'package:stmm/Models.dart/Trajets.dart';
import 'package:stmm/Models.dart/Usermodels.dart';

class AssignTrajet extends StatelessWidget {
  const AssignTrajet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: authController.selectedUsers
            .map((element) => UtilisateurWidget(
                    user: element,
                    villesExistantes: const [
                      'Agadez-Niamey',
                      'Niamey-Tahoua',
                      'Mali-Togo'
                    ]))
            .toList(),
      ),
    );
  }
}

class UtilisateurWidget extends StatefulWidget {
  final Usermodel user;
  // final Trajet trajet;
  final List<String> villesExistantes;

  const UtilisateurWidget({
    Key? key,
    required this.user,
    required this.villesExistantes,
  }) : super(key: key);

  @override
  _UtilisateurWidgetState createState() => _UtilisateurWidgetState();
}

class _UtilisateurWidgetState extends State<UtilisateurWidget> {
  //...

  late String _villeSelectionnee;
  late TimeOfDay _heureSelectionnee;
  late int _jourSelectionne;
  late DateTime _dateSelectionnee;

  @override
  void initState() {
    super.initState();
    _villeSelectionnee = 'Tahoua';
    _heureSelectionnee = TimeOfDay.fromDateTime(DateTime(1995, 7, 3));
    _jourSelectionne = 10;
    _dateSelectionnee = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    //...

    return GestureDetector(
      onTap: () async {
        final result = await showDialog<Map<String, dynamic>>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(widget.user.name!),
              content: _buildForm(),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Annuler'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).pop({
                    //   'ville': _villeSelectionnee,
                    //   'heure': _heureSelectionnee,
                    // });
                  },
                  child: Text('Enregistrer'),
                ),
              ],
            );
          },
        );
        if (result != null) {
          setState(() {
            // widget.user. = result['ville'];
            // widget.utilisateur.dateNaissance = DateTime(
            //   DateTime.now().year,
            //   DateTime.now().month,
            //   DateTime.now().day,
            //   result['heure'].hour,
            //   result['heure'].minute,
            // );
          });
        }
      },
      child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              Text(
                widget.user.name!,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Axe : Niamey-Maradi',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Date : Le 17/03 à 03:30',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }

  Widget _buildForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButtonFormField<String>(
          value: _villeSelectionnee,
          onChanged: (value) {
            setState(() {
              _villeSelectionnee = value!;
            });
          },
          items: [
            ...widget.villesExistantes
                .map((ville) => DropdownMenuItem(
                      value: ville,
                      child: Text(ville),
                    ))
                .toList(),
            DropdownMenuItem(
              value: _villeSelectionnee,
              child: Text(_villeSelectionnee),
            ),
          ],
          decoration: const InputDecoration(
            labelText: 'Ville',
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Icon(Icons.event, color: Colors.grey),
            const SizedBox(width: 8.0),
            Text('Le  ${_dateSelectionnee.day} / ${_dateSelectionnee.month}'),
            const SizedBox(width: 8.0),
            InkWell(
              child: const Icon(Icons.edit, color: Colors.blue),
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
        const SizedBox(height: 20),
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
            );
          },
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Heure de naissance'),
                Text(_heureSelectionnee.format(context)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
