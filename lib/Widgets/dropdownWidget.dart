import 'package:flutter/material.dart';
import 'package:stmm/Controlllers.dart/AppController.dart';
import 'package:stmm/Models.dart/Usermodels.dart';

class SearchableUserDropdown extends StatefulWidget {
  final Usermodel utilisateurSelectionne;
  final ValueChanged<String> onChanged;

  SearchableUserDropdown({
    required this.utilisateurSelectionne,
    required this.onChanged,
  });

  @override
  _SearchableUserDropdownState createState() => _SearchableUserDropdownState();
}

class _SearchableUserDropdownState extends State<SearchableUserDropdown> {
  Usermodel? _utilisateurSelectionne;
  TextEditingController _textEditingController = TextEditingController();
  List<Usermodel>? _utilisateursFiltres;

  @override
  void initState() {
    super.initState();
    _utilisateurSelectionne = widget.utilisateurSelectionne;
    _textEditingController.text = widget.utilisateurSelectionne.name!;
    _utilisateursFiltres = authController.userlist;
    _textEditingController.addListener(() {
      setState(() {
        _utilisateursFiltres = authController.userlist
            .where((utilisateur) => utilisateur.name!
                .toLowerCase()
                .contains(_textEditingController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _utilisateurSelectionne!.id,
      items: _utilisateursFiltres!.map((utilisateur) {
        return DropdownMenuItem(
          value: utilisateur.id,
          child: Text(utilisateur.name!),
        );
      }).toList(),
      onChanged: (selectedId) {
        setState(() {
          _utilisateurSelectionne = authController.userlist
              .firstWhere((utilisateur) => utilisateur.id == selectedId);
          _textEditingController.text = _utilisateurSelectionne!.name!;
        });
        widget.onChanged(selectedId!);
      },
      decoration: InputDecoration(
        labelText: 'Rechercher',
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            _textEditingController.clear();
            setState(() {
              _utilisateursFiltres = authController.userlist;
            });
          },
        ),
        border: const OutlineInputBorder(),
      ),
      onSaved: (selectedId) {
        widget.onChanged(selectedId!);
      },
    );
  }
}
