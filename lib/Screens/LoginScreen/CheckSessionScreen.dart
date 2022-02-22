import 'package:flutter/material.dart';
import 'package:psr_application/Screens/LoginScreen/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckSessionScreen extends StatelessWidget {
  const CheckSessionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          SharedPreferences prefs = snapshot.data;
          String sessionID = prefs.getString("session_id") ?? "";
          if(sessionID == ""){
            return LogInScreen();
          }else{
            // return LoadingScreen();
            return LogInScreen();
          }
        }
        return Scaffold(
            body: Center(
          child: CircularProgressIndicator(),
        ));
      },
    );
  }
}
