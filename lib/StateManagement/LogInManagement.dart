import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/LoginScreen/LoadingScreen.dart';
import 'package:psr_application/StateManagement/MapManagement.dart';
import 'package:psr_application/apis/Services/OutletService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/BeatScreen/BeatScreen.dart';
import '../apis/Entities/Beat.dart';
import '../apis/Entities/Outlet.dart';
import '../apis/Entities/User.dart';
import '../apis/Services/BeatService.dart';
import '../apis/Services/UserService.dart';
import '../database.dart';

class LogInManagement
    with ChangeNotifier, DiagnosticableTreeMixin, LogInVariables {

  LoadingFromSession(BuildContext context) async {
    try {
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
          (value) => value.setString("session_id", meUser?.sessionID ?? ""));
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
      _loadingAt = 30;
      _loadingText = "Loading the beats...";
      notifyListeners();
      context.read<LogInManagement>().allBeatsLocal =
      await BeatService().getBeats();
      _loadingAt = 60;
      _loadingText = "Loading the outlets";
      context.read<MapManagement>().allOutlets =
      await OutletService().getOutlets();
      notifyListeners();
      _cameras = await availableCameras();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) {
            return BeatScreen();
          },
        ),
      );
    } else {}
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

  List<CameraDescription> get cameras => _cameras;

  set cameras(List<CameraDescription> value) {
    _cameras = value;
  }

  int get loadingAt => _loadingAt;

  String get loadingText => _loadingText;

  get formKey => _formKey;

  get mobileErrorText => _mobileErrorText;

  get passwordErrorText => _passwordErrorText;

  TextEditingController get mobileTextController => _mobileTextController;

  TextEditingController get passwordTextController => _passwordTextController;

  List<Beat> _allBeatsLocal = [];
  List<Outlet> _allOutletsLocal = [];

  set allBeatsLocal(List<Beat> value) {
    _allBeatsLocal = value;
  }

  set allOutletsLocal(List<Outlet> value) {
    _allOutletsLocal = value;
  }
  List<CameraDescription> _cameras = [];
  List<Outlet> get allOutletsLocal => _allOutletsLocal;

  List<Beat> get allBeatsLocal => _allBeatsLocal;
}
