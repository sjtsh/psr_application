import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/LoginScreen/LoadingScreen.dart';
import 'package:psr_application/Screens/LoginScreen/loginScreen.dart';
import 'package:psr_application/StateManagement/BeatManagement.dart';
import 'package:psr_application/StateManagement/MapManagement.dart';
import 'package:psr_application/apis/Services/NoOrderReasonGroupService.dart';
import 'package:psr_application/apis/Services/OutletService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/BeatScreen/BeatScreen.dart';
import '../apis/Entities/Beat.dart';
import '../apis/Entities/Outlet.dart';
import '../apis/Entities/User.dart';
import '../apis/Services/BeatService.dart';
import '../apis/Services/SKUService.dart';
import '../apis/Services/TourPlan.dart';
import '../apis/Services/UserService.dart';
import '../database.dart';
import 'ShopClosedController.dart';
import 'package:http/http.dart' as http;

import 'TodayProgress.dart';

class LogInManagement
    with ChangeNotifier, DiagnosticableTreeMixin {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController mobileTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  int loadingAt = 0;
  String loadingText = "";
  String? mobileErrorText;
  String? passwordErrorText;
  bool isLoading = false;
  bool isPasswordShown = false;
  List<Outlet> allOutletsLocal = [];

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
      loadingAt = 20;
      loadingText = "Loading the beats...";
      notifyListeners();
      context.read<MapManagement>().allOutlets = context
          .read<LogInManagement>()
          .allOutletsLocal = await OutletService().getOutlets();
      notifyListeners();
      loadingAt = 40;
      loadingText = "Loading your SKUs";
      await SKUService().getSKUs(context);
      notifyListeners();
      loadingAt = 60;
      loadingText = "Loading your OrderReasons";
      await NoOrderReasonGroupService().getNoOrderReasonGroups(context);
      notifyListeners();
      loadingAt = 70;
      loadingText = "Loading your tourplan";
      await TourPlanService().getTourPlan(context);
      notifyListeners();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) {
            return BeatScreen();
          },
        ),
      );
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