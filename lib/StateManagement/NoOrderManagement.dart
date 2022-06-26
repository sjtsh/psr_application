import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';

import 'OrderScreenManagement.dart';
import 'ShopClosedController.dart';

class NoOrderManagement with ChangeNotifier, DiagnosticableTreeMixin {
  String? _noOrderTextFieldTextCompetitiveStock;
  String? _noOrderTextFieldTextOwnStock;
  String? _noOrderReasonTextField;
  String? _noOrderPhotoLocalUrl;

  String? get noOrderPhotoLocalUrl => _noOrderPhotoLocalUrl;

  set noOrderPhotoLocalUrl(String? value) {
    _noOrderPhotoLocalUrl = value;
    notifyListeners();
  }

  String? get noOrderReasonTextField => _noOrderReasonTextField;

  set noOrderReasonTextField(String? value) {
    _noOrderReasonTextField = value;
    notifyListeners();
  }

  String? get noOrderTextFieldTextOwnStock => _noOrderTextFieldTextOwnStock;

  set noOrderTextFieldTextOwnStock(String? value) {
    _noOrderTextFieldTextOwnStock = value;
    notifyListeners();
  }

  String? get noOrderTextFieldTextCompetitiveStock =>
      _noOrderTextFieldTextCompetitiveStock;

  set noOrderTextFieldTextCompetitiveStock(String? value) {
    _noOrderTextFieldTextCompetitiveStock = value;
    notifyListeners();
  }

  initializeNoOrder(subGroup, BuildContext context) {
    if (context
        .read<OrderScreenManagement>()
        .competitiveExistingStock
        .containsKey(subGroup)) {
      _noOrderTextFieldTextCompetitiveStock = context
          .read<OrderScreenManagement>()
          .competitiveExistingStock[subGroup];
    } else {
      _noOrderTextFieldTextCompetitiveStock = "";
    }
    if (context
        .read<OrderScreenManagement>()
        .ownExistingStock
        .containsKey(subGroup)) {
      _noOrderTextFieldTextOwnStock = context
          .read<OrderScreenManagement>()
          .ownExistingStock[subGroup]?["stock_count"];
      _noOrderPhotoLocalUrl = context
          .read<OrderScreenManagement>()
          .ownExistingStock[subGroup]?["img"];
    } else {
      _noOrderTextFieldTextOwnStock = "";
      _noOrderPhotoLocalUrl = null;
    }
    if (context
        .read<OrderScreenManagement>()
        .noOrderReasons
        .containsKey(subGroup)) {
      _noOrderReasonTextField =
          context.read<OrderScreenManagement>().noOrderReasons[subGroup];
    } else {
      _noOrderReasonTextField = "";
    }
    context.read<OrderScreenManagement>().validation(context);
  }

  addNoOrderReason(SubGroup subGroup, BuildContext context) {
    if (noOrderReasonTextField != "" && noOrderReasonTextField != null) {
      context.read<OrderScreenManagement>().noOrderReasons[subGroup] =
          noOrderReasonTextField!;
      context
          .read<OrderScreenManagement>()
          .competitiveExistingStock
          .remove(subGroup);
      context.read<OrderScreenManagement>().ownExistingStock.remove(subGroup);
      context.read<OrderScreenManagement>().singularOrder.remove(subGroup);
      context.read<OrderScreenManagement>().validation(context);
      Map<SubGroup,String> aMap = {};
      aMap.addAll(context.read<OrderScreenManagement>().noOrderReasons);
      context.read<OrderScreenManagement>().noOrderReasons = aMap;
      notifyListeners();
      Navigator.pop(context);
    }
  }

  addNoOrderCompetitiveExistingStock(SubGroup subGroup, BuildContext context) {
    if (_noOrderTextFieldTextCompetitiveStock != "" &&
        _noOrderTextFieldTextCompetitiveStock != null) {
      context.read<OrderScreenManagement>().competitiveExistingStock[subGroup] =
          _noOrderTextFieldTextCompetitiveStock!;
      context.read<OrderScreenManagement>().noOrderReasons.remove(subGroup);
      context.read<OrderScreenManagement>().ownExistingStock.remove(subGroup);
      context.read<OrderScreenManagement>().singularOrder.remove(subGroup);
      context.read<OrderScreenManagement>().validation(context);
      Map<SubGroup,String> aMap = {};
      aMap.addAll(context.read<OrderScreenManagement>().competitiveExistingStock);
      context.read<OrderScreenManagement>().competitiveExistingStock = aMap;
      notifyListeners();
      Navigator.pop(context);
    }
  }

  addNoOrderOwnExistingStock(SubGroup subGroup, BuildContext context) {
    if (_noOrderTextFieldTextOwnStock != "" &&
        _noOrderTextFieldTextOwnStock != null &&
        _noOrderPhotoLocalUrl != null) {
      context.read<OrderScreenManagement>().ownExistingStock[subGroup] = {
        "stock_count": _noOrderTextFieldTextOwnStock!,
        "img": _noOrderPhotoLocalUrl!,
      };
      context.read<OrderScreenManagement>().noOrderReasons.remove(subGroup);
      context
          .read<OrderScreenManagement>()
          .competitiveExistingStock
          .remove(subGroup);
      context.read<OrderScreenManagement>().singularOrder.remove(subGroup);
      context.read<OrderScreenManagement>().validation(context);
      Map<SubGroup, Map<String, String>> aMap = {};
      aMap.addAll(context.read<OrderScreenManagement>().ownExistingStock);
      context.read<OrderScreenManagement>().ownExistingStock = aMap;
      notifyListeners();
      Navigator.pop(context);
    }
  }
}
