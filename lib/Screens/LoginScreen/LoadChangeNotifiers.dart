import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/MyApp.dart';
import 'package:psr_application/Screens/LoginScreen/SplashScreen.dart';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:psr_application/StateManagement/DataManagement.dart';
import 'package:psr_application/StateManagement/MapManagement.dart';
import 'package:psr_application/StateManagement/ShopClosedController.dart';
import 'package:psr_application/apis/Entities/Beat.dart';
import 'package:psr_application/apis/Entities/OutletOrder.dart';
import 'package:psr_application/apis/Entities/OutletOrderItem.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';
import 'package:psr_application/apis/Entities/User.dart';
import '../../HiveBox/HiveBox.dart';
import '../../StateManagement/LogInManagement.dart';
import '../../StateManagement/AverageVolume.dart';
import '../../StateManagement/DateRangeManagement.dart';
import '../../StateManagement/LogInManagement.dart';
import '../../StateManagement/NoOrderManagement.dart';
import '../../StateManagement/OrderScreenManagement.dart';
import '../../StateManagement/OrderVariation.dart';
import '../../apis/Entities/Outlet.dart';
import '../../apis/Entities/Performance.dart';
import '../../apis/Entities/SKU.dart';

class LoadChangeNotifiers extends StatelessWidget {
  const LoadChangeNotifiers({Key? key}) : super(key: key);

  Future<bool> openBox() async {
    WidgetsFlutterBinding.ensureInitialized();
    Directory dir = await getApplicationDocumentsDirectory();
    Hive
      ..init(dir.path)
      ..registerAdapter(HiveBoxAdapter())
      ..registerAdapter(HollowBeatAdapter())
      ..registerAdapter(OutletOrderAdapter())
      ..registerAdapter(OutletAdapter())
      ..registerAdapter(OutletOrderItemAdapter())
      ..registerAdapter(PerformanceAdapter())
      ..registerAdapter(SKUAdapter())
      ..registerAdapter(SubGroupAdapter())
      ..registerAdapter(UserAdapter());
    await Hive.openBox('box');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: openBox(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return MultiProvider(
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
              child: const MyApp(),
            );
          }
          return MaterialApp(home: SplashScreen());
        });
  }
}
