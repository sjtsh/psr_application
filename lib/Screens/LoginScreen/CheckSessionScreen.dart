import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/LoginScreen/LoadingScreen.dart';
import 'package:psr_application/Screens/LoginScreen/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../StateManagement/LogIn.dart';
import '../../apis/Services/UserService.dart';

class CheckSessionScreen extends StatelessWidget {
  const CheckSessionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance().then((prefs) async {
        String sessionID = prefs.getString("session_id") ?? "";
        if (sessionID != "") {
          print(sessionID);
          await UserService().LoginWithSession(sessionID);
          return sessionID;
        }
        return "";
      }),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
        print("starting");
          String sessionID = snapshot.data;
          if (sessionID == "") {
            return LogInScreen();
          } else {
            context.read<LogIn>().LoadingFromSession(context);
            return LoadingScreen();
          }
        }
        return Scaffold(
            body: Center(
          child: Icon(Icons.add),
        ));
      },
    );
  }
}
