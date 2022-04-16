import 'package:flutter/material.dart';
import '/app/app.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({final Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(
        builder: (final _) => const SuccessPage(),
      );

  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
          child: Center(
            child: Column(
              children: <Widget>[
                const Image(
                    image: AssetImage("assets/ico_success.jpg"),
                    width: 100,
                    height: 100),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Successful!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  padding: EdgeInsets.zero,
                  elevation: 0,
                  hoverElevation: 0,
                  focusElevation: 0,
                  highlightElevation: 0,
                  color: Colors.white,
                  child: const Text(
                    'Back to HomePage',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(AppView.route());
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
