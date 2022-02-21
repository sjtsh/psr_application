import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'Screens/LoginScreen/loginScreen.dart';
import 'firebase_options.dart';


void main() {
  // FirebaseApp secondaryApp = Firebase.app('psrapplication');
  // firebase_storage.FirebaseStorage storage =
  // firebase_storage.FirebaseStorage.instanceFor(app: secondaryApp);
  // firebase_storage.Reference ref =
  // firebase_storage.FirebaseStorage.instance.ref('/hey.jpg');
  // print(ref.fullPath);
  // print(ref.getDownloadURL());
  runApp(MultiProvider(providers: [

  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LogInScreen(),
    );
  }
}


