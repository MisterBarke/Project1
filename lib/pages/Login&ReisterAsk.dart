import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stmm/pages/LoginPage.dart';
import 'package:stmm/pages/ResgisterPage.dart';

class LoginReisterAsk extends StatelessWidget {
  const LoginReisterAsk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  appBar: AppBar(title: const Text(''),),
        body: Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MaterialButton(
            elevation: 2,
            highlightColor: Colors.white,
            textColor: Colors.white,
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const LoginPage()));
            },
            child: Container(
                alignment: Alignment.center,
                child: const Text('Se connecter ')),
          ),
          MaterialButton(
            elevation: 2,
            highlightColor: Colors.white,
            textColor: Colors.white,
            color: Colors.black,
            onPressed: () {
              Get.defaultDialog(
                  titleStyle: const TextStyle(fontSize: 25),
                  title: 'Vous etes ?',
                  content: Column(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RegisterPAge(isAdmin: true)));
                        },
                        child: const Text(
                          'Controlleur',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RegisterPAge(isAdmin: false)));
                        },
                        child: const Text(
                          'Chauffeur',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ));
            },
            child: Container(
                alignment: Alignment.center, child: const Text('S\'inscrire ')),
          )
        ],
      ),
    ));
  }
}
