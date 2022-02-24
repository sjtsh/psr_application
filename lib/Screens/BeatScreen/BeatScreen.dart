import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/BeatScreen/components/BeatHeader.dart';
import 'package:psr_application/Screens/BeatScreen/components/SelectBeat.dart';
import '../../StateManagement/LogInManagement.dart';
import '../../StateManagement/TodayProgress.dart';
import 'components/AverageVolume.dart';
import 'components/BeatStat.dart';
import 'components/IndividualBeat.dart';
import 'components/TodayProgress.dart';

class BeatScreen extends StatelessWidget {
  const BeatScreen({Key? key}) : super(key: key);

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
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xffF1F2F6),
            body: ListView(
              children: [
                BeatHeader(),
                AverageVolume(),
                context.watch<TodayProgressState>().inProgressBeat == null
                    ? SelectBeat()
                    : TodayProgress(),
              ],
            )),
      ),
    );
  }
}
