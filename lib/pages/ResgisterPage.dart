import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stmm/Controlllers.dart/AppController.dart';
import 'package:stmm/Models.dart/CahuffeurModel.dart';
// import 'package:image_picker/image_picker.dart';

class RegisterPAge extends StatefulWidget {
  RegisterPAge({super.key, required this.isAdmin});
  bool isAdmin;
  @override
  State<RegisterPAge> createState() => _RegisterPAgeState();
}

class _RegisterPAgeState extends State<RegisterPAge> {
  File? file;
  String? urlimage;
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  Future pikedImage() async {
    XFile? pikedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    File file1 = File(pikedFile!.path);
    setState(() {
      file = file1;
    });
  }

  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final uploadTask = storageRef.putFile(imageFile);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      urlimage = downloadUrl;
    });
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Inscription',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      file == null
                          ? Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(360))),
                            )
                          : Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(file!),
                                      fit: BoxFit.cover),
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(360))),
                            ),
                      Positioned(
                        bottom: 30,
                        right: 10,
                        child: IconButton(
                            onPressed: () {
                              pikedImage();
                            },
                            icon: const Icon(
                              Icons.image,
                              size: 60,
                              color: Colors.white,
                            )),
                      )
                    ],
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 10),
                  height: 40,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Form(
                    key: _form,
                    child: TextFormField(
                      validator: ValidationBuilder().required().build(),
                      controller: authController.name,
                      decoration: const InputDecoration(
                          hintText: 'Nom',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          border: InputBorder.none),
                    ),
                  )),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 40,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: authController.phone,
                    decoration: const InputDecoration(
                        hintText: 'télephone',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none),
                  )),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 40,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: authController.password,
                    decoration: const InputDecoration(
                        hintText: 'mot de passe',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none),
                  )),
              const SizedBox(
                height: 50,
              ),
              MaterialButton(
                  shape: const StadiumBorder(),
                  onPressed: () async {
                    Get.defaultDialog(
                        title: 'chargement..',
                        content: const SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ));
                    await uploadImageToFirebaseStorage(file!);
                    print(urlimage);
                    await authController.sinUp(widget.isAdmin, urlimage!);
                    // for (ChauffeurModel chauf
                    //     in authController.chauffeursCanSinup) {
                    //   if (chauf.phone == authController.phone.text.trim()) {

                    //   } else {
                    //     await Future.delayed(Duration(seconds: 1));
                    //   }
                    // }
                    // Navigator.of(context).pop();
                    // Get.snackbar('Attention',
                    //     'vous n\'avez pas les autorisations réquises',
                    //     backgroundColor: Colors.white);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    alignment: Alignment.center,
                    // height: 30,
                    // width: 200,
                    child: const Text(
                      'Soumettre',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  )),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  'J\'ai déja un compte',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
