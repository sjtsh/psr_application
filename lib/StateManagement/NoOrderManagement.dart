import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NoOrderManagement with ChangeNotifier, DiagnosticableTreeMixin {
  String? _noOrderTextFieldTextCompetitiveStock;
  String? _noOrderTextFieldTextOwnStock;

  String? get noOrderTextFieldTextOwnStock => _noOrderTextFieldTextOwnStock;

  set noOrderTextFieldTextOwnStock(String? value) {
    _noOrderTextFieldTextOwnStock = value;
    notifyListeners();
  }

  String? get noOrderTextFieldTextCompetitiveStock => _noOrderTextFieldTextCompetitiveStock;

  set noOrderTextFieldTextCompetitiveStock(String? value) {
    _noOrderTextFieldTextCompetitiveStock = value;
    notifyListeners();
  }
}
