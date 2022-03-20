import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/HiveBox/HiveBoxLocal.dart';
import 'package:psr_application/Screens/BeatScreen/BeatScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../StateManagement/DataManagement.dart';
import '../../StateManagement/LogInManagement.dart';
import 'CheckSessionScreen.dart';
import 'SplashScreen.dart';

class CheckTodayScreen extends StatelessWidget {
  const CheckTodayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance().then((prefs) async {
        String? lastLogIn = prefs.getString("date");
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
          print(a);
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
