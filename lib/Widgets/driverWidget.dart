import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stmm/Controlllers.dart/AppController.dart';
import 'package:stmm/Models.dart/Trajets.dart';
import 'package:stmm/Models.dart/Usermodels.dart';

import '../pages/ChauffeurPage.dart';

class driverWidget extends StatelessWidget {
  driverWidget({
    Key? key,
    required this.axeName,
    required this.driver,
  }) : super(key: key);

  Usermodel? driver;
  String? axeName;

  @override
  Widget build(BuildContext context) {
    // launchURL() async {
    //   if (adressController.latitude.value != 0.0) {
    //     final String googleMapslocationUrl =
    //         "https://www.google.com/maps/search/?api=1&query=${adressController.latitude.value},${adressController.longitude.value}";

    //     final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

    //     if (await canLaunch(encodedURl)) {
    //       await launch(encodedURl);
    //     }
    //   }
    // }

    return GestureDetector(
      onTap: () {
        // repositoryController.trajetsParChauffeur();

        print(authController.chauffeurTrajets.length);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ChauffeurPage(
            driver: driver,
            // trajets: authController.chauffeurTrajets,
          );
        }));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0), color: Colors.white),
        child: Column(
          children: [
            // ClipRRect(
            //   borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(16.0),
            //     topRight: Radius.circular(16.0),
            //     bottomLeft: Radius.circular(16.0),
            //     bottomRight: Radius.circular(16.0),
            //   ),
            //   child: Image.network(
            //     "https://thumbs.dreamstime.com/b/homme-noir-souriant-au-pouvoir-220427321.jpg",
            //     height: 140,
            //     width: double.infinity,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(driver!.imageUrl!)),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        // color: Colors.blue,
                        // borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                    // height:,
                    width: double.infinity,
                    child: Column(children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(driver!.name!,
                            // style: GoogleFonts.eczar(

                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text('237, RN BF7611',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(axeName ?? '',
                          style:
                              // GoogleFonts.eczar(
                              const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.phone_circle,
                            color: Colors.black,
                          )),
                      IconButton(
                          onPressed: () async {
                            // adressController.usermodel.value = driver!;
                            Get.defaultDialog(
                                title: 'chargement..',
                                content: const SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator(),
                                ));
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            // ignore: use_build_context_synchronously
                            // launchURL();
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.location_on_outlined,
                            color: Colors.black,
                          )),
                      IconButton(
                          onPressed: () async {
                            // adressController.latitude.value = 0.0;
                            // adressController.longitude.value = 0.0;
                            // adressController.usermodel.value = driver!;
                            // Get.defaultDialog(
                            //     title: 'chargement..',
                            //     content: const SizedBox(
                            //       height: 50,
                            //       width: 50,
                            //       child: CircularProgressIndicator(),
                            //     ));
                            // await Future.delayed(
                            //     const Duration(milliseconds: 500));
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (BuildContext context) {
                            //   return ChauffeuPage(user: driver!);
                            // }));
                          },
                          icon: const Icon(
                            Icons.open_in_new,
                            color: Colors.black,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
