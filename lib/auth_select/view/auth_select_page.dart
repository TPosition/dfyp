import 'dart:io';

import 'package:flutter/material.dart';
import '/common/widgets/fade_animation.dart';
import '/login/login.dart';
import '/sign_up/sign_up.dart';

class AuthSelect extends StatefulWidget {
  const AuthSelect({final Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: AuthSelect());

  @override
  State<AuthSelect> createState() => _AuthSelectState();
}

class _AuthSelectState extends State<AuthSelect> {
  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  Future<void> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(days: 1),
          content: Text("No Internet Connection!")));
    }
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    FadeAnimation(
                        1,
                        const Text(
                          "Welcome",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                        1.2,
                        Text(
                          "Digital wallet and Online payment platform application",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 15),
                        )),
                  ],
                ),
                FadeAnimation(
                    1.4,
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: Image.asset('assets/Illustration.png'),
                    )),
                Column(
                  children: <Widget>[
                    FadeAnimation(
                        1.5,
                        MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () => Navigator.of(context)
                              .push<void>(LoginPage.route()),
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(),
                              borderRadius: BorderRadius.circular(50)),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                        1.6,
                        Container(
                          padding: const EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: const Border(
                                bottom: BorderSide(),
                                top: BorderSide(),
                                left: BorderSide(),
                                right: BorderSide(),
                              )),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () => Navigator.of(context)
                                .push<void>(SignUpPage.route()),
                            color: Colors.yellow,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
