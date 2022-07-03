import 'package:flutter/material.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({final Key? key}) : super(key: key);

  @override
  State<FaqPage> createState() => _FaqPageState();

  static Route route() => MaterialPageRoute<void>(
        builder: (final _) => const FaqPage(),
      );

  static Page page() => const MaterialPage<void>(
        child: FaqPage(),
      );
}

class _FaqPageState extends State<FaqPage> {
  bool _customTileExpanded = false;

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              const Text(
                                'FAQ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      _expansionWidget('What is iSPKP?',
                          'iSPKP is a platform in which applicants can make online applications for licensing of commercial vehicles through the mobile application.'),
                      const SizedBox(
                        height: 20,
                      ),
                      _expansionWidget(
                          'How can I make payment online for the summons?',
                          'You can make payment through credit card transactions.'),
                      const SizedBox(
                        height: 20,
                      ),
                      _expansionWidget(
                          'Will I be charged for viewing my compound online?',
                          'No, there are no charges incurred for viewing compound.'),
                      const SizedBox(
                        height: 20,
                      ),
                      _expansionWidget(
                          'Who can do the online Competent Driving License (CDL) renewal?',
                          'All citizen (MyKAD holders), permanent resident (PTM holders), temporary resident (MyKAS holders), police and army are entitled to do the online renewal. All foreign citizens are not allowed to do this online renewal.'),
                      const SizedBox(
                        height: 20,
                      ),
                      _expansionWidget(
                          'When is the effective date of my renewed license once I renew the license online?',
                          'Your renewed license will be effective according to the expiry date as stated on the existing license.'),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      );

  ExpansionTile _expansionWidget(String title, String content) {
    return ExpansionTile(
      title: Text(title),
      children: <Widget>[
        ListTile(title: Text(content)),
      ],
      textColor: Colors.black54,
      trailing: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.black,
      ),
    );
  }
}
