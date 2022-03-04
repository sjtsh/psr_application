import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/LoginScreen/LoadingScreen.dart';
import 'package:psr_application/Screens/LoginScreen/loginScreen.dart';
import 'package:psr_application/StateManagement/BeatManagement.dart';
import 'package:psr_application/StateManagement/MapManagement.dart';
import 'package:psr_application/apis/Services/OutletService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/BeatScreen/BeatScreen.dart';
import '../apis/Entities/Beat.dart';
import '../apis/Entities/Outlet.dart';
import '../apis/Entities/User.dart';
import '../apis/Services/BeatService.dart';
import '../apis/Services/TourPlan.dart';
import '../apis/Services/UserService.dart';
import '../database.dart';
import 'ShopClosedController.dart';
import 'package:http/http.dart' as http;

import 'TodayProgress.dart';

class LogInManagement
    with ChangeNotifier, DiagnosticableTreeMixin, LogInVariables {

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
      _isLoading = true;
      notifyListeners();
      await UserService()
          .Login(_mobileTextController.text, _passwordTextController.text);
      SharedPreferences.getInstance().then(
        (value) => value.setString("session_id", meUser?.sessionID ?? ""),
      );
      await loadAll(context);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      catchException(e, context);
    }
  }

  loadAll(BuildContext context) async {
    if (meUser != null) {
      _loadingAt = 20;
      _loadingText = "Loading the beats...";
      notifyListeners();
      // context.read<LogInManagement>().allBeatsLocal =
      // await BeatService().getBeats();
      // _loadingAt = 50;
      // _loadingText = "Loading the outlets";
      context.read<MapManagement>().allOutlets = context
          .read<LogInManagement>()
          .allOutletsLocal = await OutletService().getOutlets();
      notifyListeners();
      _loadingAt = 70;
      _loadingText = "Loading your tourplan";
      List tourplan = await TourPlanService().getTourPlan(context);
      context.read<BeatManagement>().beats = tourplan[0];
      context.read<BeatManagement>().outletOrders = tourplan[1];
      context.read<TodayProgressState>().scheduleVisit =
          context.read<LogInManagement>().allOutletsLocal.length;
      context.read<TodayProgressState>().visitText = context
          .read<LogInManagement>()
          .allOutletsLocal
          .where((element) => element.isDone)
          .length;
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
      _mobileErrorText = "Please enter mobile number";
      myPersonalValidation = false;
    } else if (mobileTextController.text.length != 10) {
      _mobileErrorText = "Number must be 10 digits";
      notifyListeners();
      myPersonalValidation = false;
    } else {
      _mobileErrorText = null;
      notifyListeners();
    }
    if (passwordTextController.text == "" ||
        passwordTextController.text.isEmpty) {
      _passwordErrorText = "Please enter password";
      myPersonalValidation = false;
      notifyListeners();
    } else {
      _passwordErrorText = null;
      notifyListeners();
    }
    return myPersonalValidation;
  }

  showPassword() {
    _isPasswordShown = !_isPasswordShown;
    notifyListeners();
  }
}

class LogInVariables {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _mobileTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  int _loadingAt = 0;
  String _loadingText = "";
  String? _mobileErrorText;
  String? _passwordErrorText;
  bool _isLoading = false;
  bool _isPasswordShown = false;

  bool get isLoading => _isLoading;

  bool get isPasswordShown => _isPasswordShown;

  int get loadingAt => _loadingAt;

  String get loadingText => _loadingText;

  get formKey => _formKey;

  get mobileErrorText => _mobileErrorText;

  get passwordErrorText => _passwordErrorText;

  TextEditingController get mobileTextController => _mobileTextController;

  TextEditingController get passwordTextController => _passwordTextController;

  List<Outlet> _allOutletsLocal = [];

  set allOutletsLocal(List<Outlet> value) {
    _allOutletsLocal = value;
  }

  List<Outlet> get allOutletsLocal => _allOutletsLocal;
}
