import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:psr_application/Screens/LoginScreen/CheckTodayScreen.dart';
import 'Screens/LoginScreen/CheckSessionScreen.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ask() async {
    LocationPermission checkPermission = await Geolocator.checkPermission();
    await Permission.camera.request();
    if (checkPermission == LocationPermission.denied) {
      Geolocator.requestPermission();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ask();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: CheckTodayScreen(),
    );
    // home: CheckSessionScreen());
  }
}
