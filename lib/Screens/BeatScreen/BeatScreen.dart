import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psr_application/Screens/BeatScreen/BeatHeader.dart';

import 'BeatStat.dart';
import 'IndividualBeat.dart';

class BeatScreen extends StatelessWidget {
  const BeatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: Column(
          children: [
            BeatHeader(),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                child: Column(
                  children: ["", "", ""].map((e) => IndividualBeat()).toList(),
                ),
              ),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, -2),
                      blurRadius: 3,
                      spreadRadius: 3)
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(child: BeatStat()),
                    Expanded(child: BeatStat()),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
