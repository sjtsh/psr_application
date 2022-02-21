import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class LogIn with ChangeNotifier, DiagnosticableTreeMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _mobileTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  String? _mobileErrorText;
  String? _passwordErrorText;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  get formKey => _formKey;

  get mobileErrorText => _mobileErrorText;

  get passwordErrorText => _passwordErrorText;

  TextEditingController get mobileTextController => _mobileTextController;

  TextEditingController get passwordTextController => _passwordTextController;

  // Validation
  //Validation of number
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

  Loading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}
