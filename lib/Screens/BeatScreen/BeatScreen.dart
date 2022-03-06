import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
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

class BeatScreen extends StatefulWidget {
  @override
  State<BeatScreen> createState() => _BeatScreenState();
}

class _BeatScreenState extends State<BeatScreen> {
  bool animated = true;
  int index = 0;
  StreamSubscription<ConnectivityResult>? subscription;
  String text = "connected";

  initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        setState(() {
          text = "connected";
        });
        Future.delayed(Duration(milliseconds: 1000))
            .then((value) => setState(() => animated = true));
      } else {
        print("not connected");
        setState(() {
          text = "Trying to connect";
          animated = false;
        });
      }
    });
  }

// Be sure to cancel subscription after you are done
  @override
  dispose() {
    super.dispose();
    subscription?.cancel();
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
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Scaffold(
              backgroundColor: Color(0xffF1F2F6),
              body: ListView(
                children: [
                  AnimatedContainer(
                    height: animated ? 0 : 20,
                    color:
                        text == "Trying to connect" ? Colors.red : Colors.green,
                    duration: const Duration(milliseconds: 200),
                    child: Center(
                      child: Text(
                        text,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  BeatHeader(),
                  AverageVolume(),
                  TodayProgress(),
                  SelectBeat(),
                ],
              )),
        ),
      ),
    );
  }
}
