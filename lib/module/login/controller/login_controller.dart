import 'package:crud_firebase/service/auth/auth_service.dart';
import 'package:crud_firebase/state_util.dart';
import 'package:flutter/material.dart';
import 'package:crud_firebase/core.dart';

class LoginController extends State<LoginView> {
  static late LoginController instance;
  late LoginView view;
  bool isLogin = false;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  Future loginByGoogle() async {
    isLogin = await AuthService().loginByGoogle();
    print(isLogin);
    setState(() {});
    if (isLogin == true) {
      Get.offAll(const MainNavigationView());
    } else {
      // ignore: use_build_context_synchronously
      await showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Info'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Login Failed'),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ok"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
