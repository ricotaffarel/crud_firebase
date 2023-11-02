import 'package:flutter/material.dart';
import 'package:crud_firebase/core.dart';
import '../controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  Widget build(context, LoginController controller) {
    controller.view = this;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          actions: const [],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white),
                onPressed: () => controller.loginByGoogle(),
                child: const Text("Login Google"),
              ),
            ),
          ),
        ));
  }

  @override
  State<LoginView> createState() => LoginController();
}
