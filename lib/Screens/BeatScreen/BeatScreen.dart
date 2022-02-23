import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/BeatScreen/components/BeatHeader.dart';
import '../../StateManagement/LogIn.dart';
import 'components/BeatStat.dart';
import 'components/IndividualBeat.dart';

class BeatScreen extends StatelessWidget {
  const BeatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xfff2f2f2),
          body: Column(
            children: [
              BeatHeader(),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                  child: Column(
                    children:
                        context.watch<LogIn>().allBeatsLocal.map((e) => IndividualBeat(e)).toList(),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
