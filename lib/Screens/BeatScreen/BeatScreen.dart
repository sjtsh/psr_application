import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/BeatScreen/components/BeatHeader.dart';
import 'package:psr_application/Screens/BeatScreen/components/SelectBeat.dart';
import '../../StateManagement/AverageVolume.dart';
import '../../StateManagement/LogInManagement.dart';
import '../../StateManagement/MapManagement.dart';
import '../../StateManagement/TodayProgress.dart';
import '../MapScreen/MapScreen.dart';
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
  int page = 0;

  @override
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
        setState(() {
          text = "Trying to connect";
          animated = false;
        });
      }
    });
  }

  @override
  dispose() {
    super.dispose();
    subscription?.cancel();
  }

  setPage(int i) {
    setState(() {
      page = i;
    });
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
          child: IndexedStack(
            index: page,
            children: [
              Scaffold(
                backgroundColor: Color(0xffF1F2F6),
                body: ListView(
                  children: [
                    AnimatedContainer(
                      height: animated ? 0 : 20,
                      color: text == "Trying to connect"
                          ? Colors.red
                          : Colors.green,
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
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: GestureDetector(
                        onTap: () {
                          setPage(1);
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "CONTINUE RETAILING",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SelectBeat(),
                  ],
                ),
              ),
              MapScreen(setPage),
            ],
          ),
        ),
      ),
    );
  }
}
