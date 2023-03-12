import 'package:flutter/material.dart';
import '../Models.dart/Usermodels.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

class ChauffeurPage extends StatelessWidget {
  ChauffeurPage({Key? key, this.driver}) : super(key: key);
  Usermodel? driver;

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
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              "https://thumbs.dreamstime.com/b/homme-noir-souriant-au-pouvoir-220427321.jpg",
                            )),
                        color: Colors.white,
                        shape: BoxShape.circle),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 50,
                    // color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            driver!.name!,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Numero de tel : 92085861',
                            style: TextStyle(
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              // height: 100,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    color: Colors.white,
                  ),
                  const Spacer(),
                  Column(
                    children: const [
                      Text(
                        'Niamey-Zinder',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        '237,RN BC 8324',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        '03:00 PM',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                  Spacer(),
                  const Icon(Icons.location_on_rounded)
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              alignment: Alignment.topCenter,
              height: 500,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    // height: 70,
                    padding: const EdgeInsets.only(bottom: 10),
                    // color: Colors.red,
                    child: CalendarTimeline(
                      initialDate: DateTime(2020, 4, 20),
                      firstDate: DateTime(2019, 1, 15),
                      lastDate: DateTime(2020, 11, 20),
                      onDateSelected: (date) => print(date),
                      leftMargin: 20,
                      monthColor: Colors.blueGrey,
                      dayColor: Colors.teal[200],
                      activeDayColor: Colors.white,
                      activeBackgroundDayColor: Colors.black,
                      dotsColor: Color(0xFF333A47),
                      selectableDayPredicate: (date) => date.day != 23,
                      locale: 'en_ISO',
                    ),
                  ),
                  // Expanded(
                  //     child: SingleChildScrollView(
                  //   child: Column(
                  //     children:
                  //         List.generate(100, (index) => Text(index.toString())),
                  //   ),
                  // ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
