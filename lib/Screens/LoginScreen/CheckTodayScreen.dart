import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/HiveBox/HiveBoxLocal.dart';
import 'package:psr_application/Screens/BeatScreen/BeatScreen.dart';
import 'package:psr_application/StateManagement/SignatureManagement.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../StateManagement/DataManagement.dart';
import '../../StateManagement/LogInManagement.dart';
import '../../StateManagement/ShopClosedController.dart';
import 'CheckSessionScreen.dart';
import 'SplashScreen.dart';

class CheckTodayScreen extends StatelessWidget {
  const CheckTodayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance().then((prefs) async {
        String? lastLogIn = prefs.getString("date");
        availableCameras().then((value) async {
          context.read<ShopClosedController>().cameras = value;
          context.read<SignatureManagement>().cameras = value;
          context.read<ShopClosedController>().controller =  CameraController(value[0], ResolutionPreset.max);
          await context.read<ShopClosedController>().controller?.initialize();
          context.read<SignatureManagement>().cameraController =  CameraController(value[1], ResolutionPreset.max);
          await context.read<SignatureManagement>().cameraController?.initialize();
        });
        try {
          context.read<DataManagement>().hiveBoxLocal =
              Hive.box("unsynced").getAt(0);
        } catch (e) {
          Hive.box("unsynced").put(
              0,
              HiveBoxLocal(
                  outletOrders: [], outletCloseds: [], uploadFiles: []));
          context.read<DataManagement>().hiveBoxLocal =
              Hive.box("unsynced").getAt(0);
        }
        if (lastLogIn == NepaliDateTime.now().toString().substring(0, 10)) {
          await context.read<LogInManagement>().LoadingFromHive(context);
          return true;
        } else {
          return false;
        }
      }),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          bool a = snapshot.data;
          if (a) {
            return BeatScreen();
          } else {
            return const CheckSessionScreen();
          }
        }
        return SplashScreen();
      },
    );
  }
}
