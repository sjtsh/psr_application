import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/HiveBox/HiveBox.dart';
import 'package:psr_application/StateManagement/DataManagement.dart';
import 'package:psr_application/apis/Entities/Performance.dart';
import 'package:psr_application/Screens/LoginScreen/LoadingScreen.dart';
import 'package:psr_application/Screens/LoginScreen/loginScreen.dart';
import 'package:psr_application/StateManagement/MapManagement.dart';
import 'package:psr_application/apis/Entities/OutletOrder.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';
import 'package:psr_application/apis/Services/OutletService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/BeatScreen/BeatScreen.dart';
import '../apis/Entities/Beat.dart';
import '../apis/Entities/Outlet.dart';
import '../apis/Entities/User.dart';
import '../apis/Services/SKUService.dart';
import '../apis/Services/TourPlan.dart';
import '../apis/Services/UserService.dart';
import '../database.dart';
import 'AverageVolume.dart';
import 'OrderScreenManagement.dart';
import 'ShopClosedController.dart';
import 'package:http/http.dart' as http;

class LogInManagement with ChangeNotifier, DiagnosticableTreeMixin {
  TextEditingController mobileTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  int loadingAt = 0;
  String loadingText = "";
  String? mobileErrorText;
  String? passwordErrorText;
  bool isLoading = false;
  bool isPasswordShown = false;
  bool isVerified = false;

  LoadingFromSession(BuildContext context, String sessionID) async {
    try {
      await UserService().LoginWithSession(sessionID);
      await loadAll(context);
    } catch (e) {
      catchException(e, context);
    }
  }

  LoadingFromSignIn(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      await UserService()
          .Login(mobileTextController.text, passwordTextController.text);
      SharedPreferences.getInstance().then(
        (value) => value.setString("session_id", meUser?.sessionID ?? ""),
      );
      await loadAll(context);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      catchException(e, context);
    }
  }

  loadAll(BuildContext context) async {
    if (meUser != null) {
      updateLoading(20, "Loading the beats...");
      List<Outlet> outlets = await OutletService().getOutlets();

      updateLoading(40, "Loading the SKUs...");
      List<SubGroup> subgroups = await SKUService().getSKUs();
      updateLoading(70, "Loading the tourplan...");
      List<List> tourplan = await TourPlanService().getTourPlan();
      List<Performance> performances = tourplan[0] as List<Performance>;
      List<HollowBeat> beats = tourplan[1] as List<HollowBeat>;
      List<OutletOrder> orders = tourplan[2] as List<OutletOrder>;
      context.read<AverageVolumeState>().inProgressBeat =
          beats.firstWhere((element) => element.inProgress);
      notifyListeners();

      HiveBox hiveBox = HiveBox(
          performances: performances,
          outletOrders: orders,
          outlets: outlets,
          subgroups: subgroups,
          beats: beats,
          user: meUser!);
      await Hive.box("box").put(0, hiveBox);
      context.read<DataManagement>().hiveBox = Hive.box("box").getAt(0)!;
      final event = await Geolocator.getCurrentPosition();
      context
          .read<MapManagement>()
          .initializeMarkers(LatLng(event.latitude, event.longitude), context);
      isVerified = true;
      notifyListeners();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) {
            return LogInScreen();
          },
        ),
      );
    }
  }

  updateLoading(int loadingAt, String loadingText) {
    this.loadingAt = loadingAt;
    this.loadingText = loadingText;
    notifyListeners();
  }

  catchException(Object e, context) {
    print(e);
    if (e == "Password incorrect") {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter right password")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Unsuccessful")));
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return LogInScreen();
        },
      ),
    );
  }

  bool validateMobileNumber() {
    bool myPersonalValidation = true;
    if (mobileTextController.text == "" || mobileTextController.text.isEmpty) {
      mobileErrorText = "Please enter mobile number";
      myPersonalValidation = false;
    } else if (mobileTextController.text.length != 10) {
      mobileErrorText = "Number must be 10 digits";
      notifyListeners();
      myPersonalValidation = false;
    } else {
      mobileErrorText = null;
      notifyListeners();
    }
    if (passwordTextController.text == "" ||
        passwordTextController.text.isEmpty) {
      passwordErrorText = "Please enter password";
      myPersonalValidation = false;
      notifyListeners();
    } else {
      passwordErrorText = null;
      notifyListeners();
    }
    return myPersonalValidation;
  }

  showPassword() {
    isPasswordShown = !isPasswordShown;
    notifyListeners();
  }
}
