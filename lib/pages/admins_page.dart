// import 'package:final_stm_project/admins_pages/admin_menu_bar/admins_menu_bar.dart';

import 'dart:ui';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_page/search_page.dart';

import 'package:stmm/Controlllers.dart/AppController.dart';
import 'package:stmm/Models.dart/ChaufferModel.dart';
import 'package:stmm/Models.dart/Usermodels.dart';
import 'package:stmm/pages/ChauffeurPage.dart';

import '../Models.dart/Trajets.dart';
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
  List<int> jours = [for (int i = 0; i <= 31; i++) i];
  DateTime _selectedDate = DateTime.now();
  List<DateTime> dates = [
    for (int i = 1; i < 32; i++)
      DateTime(2023, DateTime.now().month, DateTime.now().day == 30 ? i - 1 : i)
  ];
  DateTime selectedDate = DateTime.now();
  List<Trajet> _events = <Trajet>[];
  List<Usermodel> _users = <Usermodel>[];
  PageController controller = PageController(initialPage: 0);

  // Future<void> getData() async {
  //   List<Trajet> events = [];
  //   List<Usermodel> users = <Usermodel>[];
  //   Usermodel user;
  //   // Parcourir les documents de la collection Firestore
  //   for (var document in authController.chauffeurTrajets) {
  //     // Extraire la date de création du document
  //     DateTime createdAt = document.dateDepart!;
  //     if (createdAt.year == _selectedDate.year &&
  //             createdAt.month == _selectedDate.month &&
  //             createdAt.day == _selectedDate.day
  //         // widget.driver!.id == document.idChauffeur
  //         ) {
  //       authController.userlist.forEach((element) {
  //         if (element.id == document.idChauffeur) {
  //           users.contains(element) ? null : users.add(element);
  //         }
  //       });
  //       events.add(document);
  //     }
  //   }

  //   setState(() {
  //     _events = events;
  //     _users = users;
  //   });
  // }

  void onpageChanged(int index) {
    controller.jumpToPage(index);
    setState(() {
      _currentindex = index;
      _selectedDate = dates[_currentindex];
      authController.year.value = _selectedDate.year;
      authController.day.value = _selectedDate.day;
      authController.month.value = _selectedDate.month;
    });
    authController.getData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
    _selectedDate = dates[_currentindex];
    _currentindex = _selectedDate.day;
    authController.year.value = _selectedDate.year;
    authController.day.value = _selectedDate.day;
    authController.month.value = _selectedDate.month;
    authController.getData();
    authController.getData();
  }

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
                      barTheme: ThemeData(
                          backgroundColor: Colors.black,
                          appBarTheme: const AppBarTheme(
                            backgroundColor: Colors.white,
                          )),
                      searchStyle: const TextStyle(color: Colors.black),
                      suggestion: Obx(() => GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 12,
                                    mainAxisExtent: 200),
                            itemCount: authController.userlist.length,
                            itemBuilder: (_, index) {
                              return driverWidget(
                                  axeName: '',
                                  driver: authController.userlist[index]);
                            },
                          )),
                      builder: (user) => GestureDetector(
                          onTap: () {
                            Get.to(() => ChauffeurPage(
                                  driver: user,
                                ));
                          },
                          child: ListTile(
                            title: Text(user.name!),
                            // subtitle: Text(user.email!),
                          )),
                      filter: ((user) => [user.name, user.axe]),
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
            CalendarTimeline(
              showYears: true,
              initialDate: dates[_currentindex],
              // initialDate: DateTime.now(),
              firstDate: dates.first,
              lastDate: dates.last,
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = dates[_currentindex];
                });
                int index = dates.indexWhere((element) => element == date);

                controller.jumpToPage(index);
                authController.getData();
              },
              leftMargin: 20,
              monthColor: Colors.white,
              dayColor: Colors.white,
              activeDayColor: Colors.black,
              activeBackgroundDayColor: Colors.white,
              dotsColor: const Color(0xFF333A47),
              // selectableDayPredicate: (date) => date.day != 23,
              locale: 'fr',
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: PageView.builder(
              itemCount: dates.length,
              onPageChanged: onpageChanged,
              controller: controller,
              itemBuilder: (BuildContext context, int index) {
                return Obx(() => GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 12,
                        mainAxisExtent: 300,
                      ),
                      itemCount: authController.usersOfday.length,
                      itemBuilder: (_, index) {
                        return driverWidget(
                            axeName: authController.chauffeurTrajets
                                .firstWhere((element) {
                              return element.dateDepart!.year ==
                                      authController.year.value &&
                                  element.dateDepart!.month ==
                                      authController.month.value &&
                                  element.dateDepart!.day ==
                                      authController.day.value &&
                                  element.idChauffeur ==
                                      authController.usersOfday[index].id;
                            }).positionArrivee,
                            driver: authController.usersOfday[index]);
                      },
                    ));
              },
            ))
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
            return driverWidget(
                axeName: authController.chauffeurTrajets.firstWhere((element) {
                  return element.dateDepart!.year ==
                          authController.year.value &&
                      element.dateDepart!.month == authController.month.value &&
                      element.dateDepart!.day == authController.day.value &&
                      element.idChauffeur ==
                          authController.usersOfday[index].id;
                }).positionArrivee,
                driver: authController.userlist[index]);
          },
        ));
  }
}
