import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/LoginScreen/LoadingScreen.dart';
import 'package:psr_application/Screens/LoginScreen/loginScreen.dart';
import 'package:psr_application/StateManagement/LogInManagement.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../StateManagement/ShopClosedController.dart';
import '../../apis/Services/UserService.dart';
import '../../database.dart';

class CheckSessionScreen extends StatelessWidget {
  const CheckSessionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance().then((prefs) async {
        String sessionID = prefs.getString("session_id") ?? "";
        availableCameras().then((value){
          context.read<ShopClosedController>().cameras = value;
          context
              .read<ShopClosedController>()
              .initialize();
        });
        if (sessionID != "") {
          context.read<LogInManagement>().LoadingFromSession(context, sessionID);
          return sessionID;
        }
        return "";
      }),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          String sessionID = snapshot.data;
          if (sessionID == "") {
            return LogInScreen();
          } else {
            return LoadingScreen();
          }
        }
        return Scaffold(
            body: Center(
          child: SvgPicture.asset("assets/logo.svg"),
        ));
      },
    );
  }
}
