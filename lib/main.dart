import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/apis/Services/BeatService.dart';
import 'package:psr_application/apis/Services/UserService.dart';

import 'Screens/BeatScreen/BeatScreen.dart';
import 'StateManagement/CameraUpload.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'Screens/LoginScreen/loginScreen.dart';
import 'StateManagement/LogIn.dart';
import 'firebase_options.dart';

void main() {
  UserService().Login("9818173521", "9818173521").then((value) {
    BeatService().getBeats();
  });
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => CameraUpload(),
      ),
      ChangeNotifierProvider(
        create: (_) => LogIn(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogInScreen(),
    );
  }
}
