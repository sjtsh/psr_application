import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/BeatScreen/components/BeatHeader.dart';
import '../../StateManagement/LogInManagement.dart';
import 'components/AverageVolume.dart';
import 'components/BeatStat.dart';
import 'components/IndividualBeat.dart';

class BeatScreen extends StatefulWidget {
  @override
  State<BeatScreen> createState() => _BeatScreenState();
}

class _BeatScreenState extends State<BeatScreen> {
  int index = 0;

  Future<bool> _onBackPressed() async {
    if (index == 1) {
      Navigator.pop(context);
    }
    index = 1;
    Future.delayed(Duration(seconds: 1), () {
      index = 0;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xffF1F2F6),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
      ),
      sized: false,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xffF1F2F6),
            body: Column(
              children: [
                BeatHeader(),
                AverageVolume(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 6),
                    child: Column(
                      children: context
                          .watch<LogInManagement>()
                          .allBeatsLocal
                          .map((e) => IndividualBeat(e))
                          .toList(),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
