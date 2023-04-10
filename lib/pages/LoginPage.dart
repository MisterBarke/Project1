import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stmm/Controlllers.dart/AppController.dart';

import 'ResgisterPage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              TextFormField(
                controller: authController.phone,
                decoration: const InputDecoration(
                  hintText: 'Télephone',
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
              ElevatedButton(
                  onPressed: () {
                    authController.logIn(false);
                  },
                  child: const Text('Se connecter')),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  // Get.off(() => const RegisterPAge());
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
