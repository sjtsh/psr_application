import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/LoginScreen/LoadingScreen.dart';
import 'package:psr_application/Screens/MapScreen/MapScreen.dart';
import 'package:psr_application/Screens/OrderScreen/OrderScreen.dart';

import 'package:psr_application/apis/Services/BeatService.dart';
import 'package:psr_application/apis/Services/OutletService.dart';
import 'package:psr_application/apis/Services/UserService.dart';
import 'package:psr_application/StateManagement/MapManagement.dart';

import 'Entities/outletsEntity.dart';
import 'Screens/BeatScreen/BeatScreen.dart';
import 'Screens/LoginScreen/CheckSessionScreen.dart';
import 'StateManagement/CameraUpload.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'Screens/LoginScreen/loginScreen.dart';
import 'StateManagement/LogInManagement.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => CameraUpload(),
      ),
      ChangeNotifierProvider(
        create: (_) => LogInManagement(),
      ),
      ChangeNotifierProvider(
        create: (_) => MapManagement(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ask() async {
    LocationPermission checkPermission = await Geolocator.checkPermission();
    if(checkPermission == LocationPermission.denied){
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
    ask();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckSessionScreen(),
    );
  }
}
