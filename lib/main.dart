import 'dart:convert';
import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/DataManagement.dart';
import 'package:psr_application/StateManagement/MapManagement.dart';
import 'package:psr_application/StateManagement/ShopClosedController.dart';
import 'package:psr_application/apis/Entities/Beat.dart';
import 'package:psr_application/apis/Entities/OutletOrder.dart';
import 'package:psr_application/apis/Entities/OutletOrderItem.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';
import 'package:psr_application/apis/Entities/User.dart';
import 'HiveBox/HiveBox.dart';
import 'apis/Entities/Outlet.dart';
import 'apis/Entities/Performance.dart';
import 'Screens/LoginScreen/CheckSessionScreen.dart';
import 'Screens/MapScreen/MapScreen.dart';
import 'StateManagement/AverageVolume.dart';
import 'StateManagement/DateRangeManagement.dart';
import 'StateManagement/LogInManagement.dart';
import 'StateManagement/NoOrderManagement.dart';
import 'StateManagement/OrderScreenManagement.dart';
import 'StateManagement/OrderVariation.dart';
import 'apis/Entities/SKU.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getApplicationDocumentsDirectory().then((Directory path) async {
    Hive
      ..init(path.path)
      ..registerAdapter(HiveBoxAdapter())
      ..registerAdapter(HollowBeatAdapter())
      ..registerAdapter(OutletOrderAdapter())
      ..registerAdapter(OutletAdapter())
      ..registerAdapter(OutletOrderItemAdapter())
      ..registerAdapter(PerformanceAdapter())
      ..registerAdapter(SKUAdapter())
      ..registerAdapter(SubGroupAdapter())
      ..registerAdapter(UserAdapter());
    Hive.openBox('box');
  });
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LogInManagement(),
        ),
        ChangeNotifierProvider(
          create: (_) => DataManagement(),
        ),
        ChangeNotifierProvider(
          create: (_) => MapManagement(),
        ),
        ChangeNotifierProvider(
          create: (_) => AverageVolumeState(),
        ),
        ChangeNotifierProvider(
          create: (_) => ShopClosedController(),
        ),
        ChangeNotifierProvider(
          create: (_) => DateRangeManagement(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderScreenManagement(),
        ),
        ChangeNotifierProvider(
          create: (_) => NoOrderManagement(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderVariation(),
        )
      ],
      child: MyApp(),
    ),
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
        home: CheckSessionScreen());
  }
}

getUrls() {
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: 'psrapplication',
  ).then((value) {
    Reference uploading = firebase_storage.FirebaseStorage.instanceFor(
            app: Firebase.app('psrapplication'))
        .ref('skus');
    uploading.listAll().then((value) {
      value.items.forEach((element) {
        element.getDownloadURL().then((value) => print(value));
      });
    });
  });
}
