// import 'package:final_stm_project/admins_pages/admin_menu_bar/admins_menu_bar.dart';

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_page/search_page.dart';

import 'package:stmm/Controlllers.dart/AppController.dart';

import '../Widgets/driverWidget.dart';
import 'addBus.dart';

import 'admins_menu_bar.dart';
// import 'package:google_fonts/google_fonts.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _currentindex = 0;
  PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // bottomNavigationBar: NavigationBar(
      //     onDestinationSelected: (index) {
      //       setState(() {
      //         _currentindex = index;
      //       });
      //       controller.jumpToPage(_currentindex);
      //     },
      //     selectedIndex: _currentindex,
      //     surfaceTintColor: Colors.white,
      //     backgroundColor: Colors.white,
      //     destinations: const [
      //       NavigationDestination(
      //           icon: Icon(
      //             Icons.home_outlined,
      //             size: 30,
      //             color: Color.fromARGB(255, 255, 98, 0),
      //             // color: Colors.white,
      //           ),
      //           label: 'Acceuil'),
      //       NavigationDestination(
      //           icon: Icon(
      //             Icons.person_outlined,
      //             size: 30,
      //             // color: Colors.white,
      //             color: Color.fromARGB(255, 255, 98, 0),
      //           ),
      //           label: 'Chauffeur')
      //     ]),
      drawer: const AdminMenuBar(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        // title: const Text(
        //   'STM',
        //   style: TextStyle(
        //       color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold),
        // ),
        // backgroundColor: Colors.blue,
        // backgroundColor: const Color.fromARGB(255, 255, 98, 0),
        elevation: 0,
        // backgroundColor: const Color.fromARGB(255, 1, 23, 41),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => showSearch(
                  context: context,
                  delegate: SearchPage(
                      searchStyle: const TextStyle(color: Colors.black),
                      builder: (user) => GestureDetector(
                          onTap: () {
                            // authcontroller.selectedDriver.add(user.nom);
                            // Navigator.of(context).pop();
                            // Navigator.of(context).push(
                            //     MaterialPageRoute(
                            //         builder: (BuildContext context) {
                            //   return ChauffeuPage(user: user);
                            // }));
                          },
                          child: const ListTile(
                            title: Text('nom du chauffeur'),
                            // subtitle: Text(user.axe!),
                          )),
                      filter: ((user) => []),
                      items: authController.userlist,
                      searchLabel: 'trouver un chauffeur',
                      failure:
                          const Center(child: Text('Aucune correspondance')))),
              child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  height: 40,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Row(
                      children: const [
                        SizedBox(width: 15),
                        Text('Trouver un chauffeur',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18)),
                        Spacer(),
                        Icon(Icons.search, color: Colors.black),
                      ],
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            // SizedBox(
            //   height: 30,
            //   child: Row(
            //     children: [
            //       _currentindex == 0
            //           ? Text(
            //               'Voyages en  cours : ${authController.userlist.length.toString()}',
            //               style: const TextStyle(fontSize: 19),
            //             )
            //           : const Text(
            //               'Les chauffeur ',
            //               style: TextStyle(fontSize: 19),
            //             ),
            //     ],
            //   ),
            // ),
            Expanded(
                child: Obx(() => PageView(
                        onPageChanged: (index) {
                          setState(() {
                            _currentindex = index;
                          });
                        },
                        controller: controller,
                        children: [
                          if (authController.userlist.isEmpty)
                            Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Pas de voyage en cours'),
                                OutlinedButton(
                                    onPressed: () {
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (BuildContext context) {
                                      //   return const AddBus();
                                      // }));
                                    },
                                    child: const Text('Nouvelle destination'))
                              ],
                            ))
                          else
                            Obx(() => GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 12,
                                    mainAxisExtent: 300,
                                  ),
                                  itemCount: authController.userlist.length,
                                  itemBuilder: (_, index) {
                                    return driverWidget(
                                        driver: authController.userlist[index]);
                                  },
                                )),
                          //     Obx(() => GridView.builder(
                          //           physics: const BouncingScrollPhysics(),
                          //           shrinkWrap: true,
                          //           gridDelegate:
                          //               const SliverGridDelegateWithFixedCrossAxisCount(
                          //                   crossAxisCount: 2,
                          //                   crossAxisSpacing: 8,
                          //                   mainAxisSpacing: 12,
                          //                   mainAxisExtent: 300),
                          //           itemCount: authcontroller.allUsers.length,
                          //           itemBuilder: (_, index) {
                          //             return driverWidget(
                          //                 driver: authcontroller.allUsers[index]);
                          //           },
                          //         )),
                          //   ],
                          // ))),
                        ])))
          ],
        ),
      ),
    );
  }
}

class Infos extends StatefulWidget {
  const Infos({super.key});

  @override
  State<Infos> createState() => _InfosState();
}

class _InfosState extends State<Infos> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 12,
              mainAxisExtent: 300),
          itemCount: authController.userlist.length,
          itemBuilder: (_, index) {
            return driverWidget(driver: authController.userlist[index]);
          },
        ));
  }
}
