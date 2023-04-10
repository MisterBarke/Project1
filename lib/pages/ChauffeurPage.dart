import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stmm/Controlllers.dart/AppController.dart';
import 'package:stmm/Models.dart/Trajets.dart';
import '../Models.dart/Usermodels.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

class ChauffeurPage extends StatefulWidget {
  ChauffeurPage({
    Key? key,
    this.driver,
  }) : super(key: key);
  Usermodel? driver;
  @override
  State<ChauffeurPage> createState() => _ChauffeurPageState();
}

class _ChauffeurPageState extends State<ChauffeurPage> {
  DateTime _selectedDate = DateTime(authController.year.value,
      authController.month.value, authController.day.value);
  List<Trajet> _events = [];
  String getDayName(int dayNumber) {
    switch (dayNumber) {
      case 1:
        return "Lundi";
      case 2:
        return "Mardi";
      case 3:
        return "Mercredi";
      case 4:
        return "Jeudi";
      case 5:
        return "Vendredi";
      case 6:
        return "Samedi";
      case 7:
        return "Dimanche";
      default:
        return "Jour non valide";
    }
  }

  List<DateTime> dates = [
    for (int i = 1; i < 32; i++)
      DateTime(2023, DateTime.now().month, DateTime.now().day == 30 ? i - 1 : i)
  ];

  Future<void> getData() async {
    List<Trajet> events = [];

    // Parcourir les documents de la collection Firestore
    for (var document in authController.chauffeurTrajets) {
      // Extraire la date de création du document
      DateTime createdAt = document.dateDepart!;
      if (createdAt.year == _selectedDate.year &&
          createdAt.month == _selectedDate.month &&
          createdAt.day == _selectedDate.day &&
          widget.driver!.id == document.idChauffeur) {
        events.add(document);
      }
    }

    setState(() {
      _events = events;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    // authController.chauffeurTrajets.forEach((element) {
    //   if (element.idAdministrateur == widget.driver!.id) {
    //     trajets.add(element);
    //   }
    // });
  }

  PageController controller = PageController();
  List<Trajet> trajets = <Trajet>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
                // height: 50,
                ),
            Container(
              width: double.infinity,
              // color: Colors.amber,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(70),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              widget.driver!.imageUrl!,
                            )),
                        color: Colors.white,
                        shape: BoxShape.circle),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 50,
                    // color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.driver!.name!,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Numero de tel : ${widget.driver!.phone!}',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //   width: double.infinity,
            //   // height: 100,
            //   decoration: const BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.all(Radius.circular(15))),
            //   child: Row(
            //     children: [
            //       const Icon(
            //         Icons.location_on_rounded,
            //         color: Colors.white,
            //       ),
            //       const Spacer(),
            //       Column(
            //         children: const [
            //           Text(
            //             'Niamey-Zinder',
            //             style: TextStyle(
            //                 fontWeight: FontWeight.bold, fontSize: 20),
            //           ),
            //           Text(
            //             '237,RN BC 8324',
            //             style: TextStyle(
            //                 fontWeight: FontWeight.bold, fontSize: 20),
            //           ),
            //           Text(
            //             '03:00 PM',
            //             style: TextStyle(
            //                 fontWeight: FontWeight.bold, fontSize: 20),
            //           ),
            //         ],
            //       ),
            //       Spacer(),
            //       const Icon(Icons.location_on_rounded)
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            Container(
              // height: 70,
              padding: const EdgeInsets.only(bottom: 10),
              // color: Colors.red,
              child: CalendarTimeline(
                showYears: true,
                initialDate: _selectedDate,
                firstDate: DateTime(2019, 1, 15),
                lastDate: DateTime(2024, 11, 20),
                onDateSelected: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                  getData();
                },
                leftMargin: 20,
                monthColor: Colors.white,
                dayColor: Colors.white,
                activeDayColor: Colors.black,
                activeBackgroundDayColor: Colors.white,
                dotsColor: const Color(0xFF333A47),
                selectableDayPredicate: (date) => date.day != 23,
                locale: 'fr',
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                alignment: Alignment.topCenter,
                // height: 500,
                width: double.infinity,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  // color: Colors.amber,
                  child: _events.isEmpty
                      ? Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.warning_amber,
                                color: Colors.red,
                              ),
                              Text(
                                'Journée libre',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: _events
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        Usermodel user = authController
                                            .allAdmins
                                            .firstWhere((element) =>
                                                element.id ==
                                                e.idAdministrateur);
                                        Get.defaultDialog(
                                            // backgroundColor:
                                            //     Colors.black.withOpacity(0.3),
                                            title: widget.driver!.name!,
                                            content: Container(
                                                // color: Colors.black,
                                                child: Column(
                                              children: [
                                                _tableSection(
                                                    trajet: e,
                                                    dayNumber: _selectedDate.day
                                                        .toString(),
                                                    day: getDayName(
                                                        _selectedDate.weekday)),
                                                const SizedBox(
                                                  height: 10,
                                                  child: Divider(thickness: 2),
                                                ),
                                                Table(
                                                  children: [
                                                    TableRow(children: [
                                                      const Text(
                                                        'CONTROLLEUR',
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      Text(
                                                        authController.allAdmins
                                                            .firstWhere((element) =>
                                                                element.id ==
                                                                e.idAdministrateur)
                                                            .name!,
                                                        style: const TextStyle(
                                                            fontSize: 20),
                                                      )
                                                    ]),
                                                    TableRow(children: [
                                                      const Text('PHONE',
                                                          style: TextStyle(
                                                              fontSize: 20)),
                                                      Text(
                                                          authController
                                                              .allAdmins
                                                              .firstWhere(
                                                                  (element) =>
                                                                      element
                                                                          .id ==
                                                                      e
                                                                          .idAdministrateur)
                                                              .phone!,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 20))
                                                    ])
                                                  ],
                                                )
                                              ],
                                            )));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.6),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        // height: 50,
                                        width: double.infinity,
                                        child: _tableSection(
                                          trajet: e,
                                          dayNumber:
                                              _selectedDate.day.toString(),
                                          day:
                                              getDayName(_selectedDate.weekday),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _tableSection({Trajet? trajet, String? day, String? dayNumber}) {
  return Table(
    children: [
      TableRow(children: [
        const Text(
          'AXE ',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        Text(
          trajet!.positionArrivee!,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
      ]),
      TableRow(children: [
        const Text(
          'DEPART',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        Text(
          '${day!} Le ${dayNumber!} ',
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
      ]),
      TableRow(children: [
        const Text(
          'REDEZ VOUS',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        Text(
          '${trajet.heure!.hour}:${trajet.heure!.minute}',
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
      ])
    ],
  );
}
