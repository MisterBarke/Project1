import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stmm/Controlllers.dart/AppController.dart';
// import 'package:image_picker/image_picker.dart';

class RegisterPAge extends StatefulWidget {
  const RegisterPAge({super.key});

  @override
  State<RegisterPAge> createState() => _RegisterPAgeState();
}

class _RegisterPAgeState extends State<RegisterPAge> {
  // Future pikedImage() async {
  //   XFile? pikedFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   File file1 = File(pikedFile!.path);
  //   setState(() {
  //     var file = file1;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              TextFormField(
                controller: authController.name,
                decoration: const InputDecoration(
                  hintText: 'Nom',
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: authController.email,
                decoration: const InputDecoration(
                  hintText: 'email',
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: authController.password,
                decoration: const InputDecoration(
                  hintText: 'mot de passe',
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: authController.phone,
                decoration: const InputDecoration(
                  hintText: 'phone',
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  authController.sinUp();
                },
                child: const Text('Soumettre'),
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  'nouveau compte ?',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
