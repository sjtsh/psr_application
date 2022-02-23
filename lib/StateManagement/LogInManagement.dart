import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/BeatManagement.dart';
import 'package:psr_application/apis/Services/OutletService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/BeatScreen/BeatScreen.dart';
import '../apis/Entities/User.dart';
import '../apis/Services/BeatService.dart';
import '../apis/Services/UserService.dart';
import '../database.dart';
class LogInManagement with ChangeNotifier, DiagnosticableTreeMixin, LogInVariables {
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

  LoadingFromSession(BuildContext context) async {
    try {
      if (meUser != null) {
        _loadingAt = 30;
        _loadingText = "Loading the beats...";
        notifyListeners();
        context.read<BeatManagement>().allBeatsLocal =
            await BeatService().getBeats();
        _loadingAt = 60;
        _loadingText = "Loading the outlets";
        context.read<BeatManagement>().allOutletsLocal =
            await OutletService().getOutlets();

        print("done 3 ");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return BeatScreen();
            },
          ),
        );
      } else {}
    } catch (e) {
      print(e);
      if (e == "Password incorrect") {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Enter right password")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Unsuccessful")));
      }
    }
  }

  LoadingFromSignIn(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
        await UserService()
            .Login(_mobileTextController.text, _passwordTextController.text);

        SharedPreferences.getInstance().then(
                (value) => value.setString("session_id", meUser?.sessionID ?? ""));

      if (meUser != null) {
        _loadingAt = 30;
        _loadingText = "Loading the beats...";
        notifyListeners();
        context.read<BeatManagement>().allBeatsLocal =
        await BeatService().getBeats();
        _loadingAt = 50;
        _loadingText = "Loading the outlets";
        context.read<BeatManagement>().allOutletsLocal =
        await OutletService().getOutlets();

        notifyListeners();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return BeatScreen();
            },
          ),
        );
        _isLoading = false;
        notifyListeners();
      } else {}
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print(e);
      if (e == "Password incorrect") {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Enter right password")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Unsuccessful")));
      }
    }
  }

  showPassword(){
    _isPasswordShown =!_isPasswordShown;
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
  bool _isPasswordShown =false;

  bool get isLoading => _isLoading;
  bool get isPasswordShown => _isPasswordShown;

  int get loadingAt => _loadingAt;

  String get loadingText => _loadingText;

  get formKey => _formKey;

  get mobileErrorText => _mobileErrorText;

  get passwordErrorText => _passwordErrorText;

  TextEditingController get mobileTextController => _mobileTextController;

  TextEditingController get passwordTextController => _passwordTextController;
}
