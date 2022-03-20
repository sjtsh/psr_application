import 'dart:typed_data';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/apis/Entities/OutletOrderItem.dart';
import 'package:psr_application/apis/Entities/SKU.dart';
import 'package:psr_application/apis/Entities/SKU.dart';
import 'package:psr_application/apis/Entities/SKU.dart';

import '../apis/Entities/SubGroup.dart';
import 'DataManagement.dart';
import 'OrderVariation.dart';

class OrderScreenManagement with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isConfirmed = false;
  ScrollController scrollController = ScrollController();
  Map<SubGroup, Map<SKU, int>> _singularOrder = {};
  Map<SubGroup, String> _competitiveExistingStock = {};
  Map<SubGroup, Map<String, String>> _ownExistingStock =
      {}; // the value for a subgroup to have two keys first one should be stock_count and other should be img url
  Map<SubGroup, String> _noOrderReasons = {};
  List<GlobalKey> keys = [];
  bool _confirmButtonDisabled = false;
  int? currentlyExpanded;
  List<SubGroup>? _dataToDisplay;

  final TextEditingController _noOrderRemarkController =
      TextEditingController();

  TextEditingController get noOrderRemarkController => _noOrderRemarkController;
  final TextEditingController _confirmOrderRemarkController =
      TextEditingController();
  ScrollController controller = ScrollController();

  TextEditingController get confirmOrderRemarkController =>
      _confirmOrderRemarkController;
  PageController pageController = PageController();

  int _skuIndex = 0;

  bool get isConfirmed => _isConfirmed;

  set isConfirmed(bool value) {
    _isConfirmed = value;
    notifyListeners();
  }

  Map<SubGroup, String> get competitiveExistingStock =>
      _competitiveExistingStock;

  set competitiveExistingStock(Map<SubGroup, String> value) {
    _competitiveExistingStock = value;
    notifyListeners();
  }

  Map<SubGroup, String> get noOrderReasons => _noOrderReasons;

  set noOrderReasons(Map<SubGroup, String> value) {
    _noOrderReasons = value;
    notifyListeners();
  }

  Map<SubGroup, Map<SKU, int>> get singularOrder => _singularOrder;

  set singularOrder(Map<SubGroup, Map<SKU, int>> value) {
    _singularOrder = value;
    print("running setter");
    notifyListeners();
  }

  Map<SubGroup, Map<String, String>> get ownExistingStock => _ownExistingStock;

  set ownExistingStock(Map<SubGroup, Map<String, String>> value) {
    _ownExistingStock = value;
    notifyListeners();
  }

  int get skuIndex => _skuIndex;
  PageController detailsController = PageController();

  set skuIndex(int value) {
    _skuIndex = value;
    try {
      scrollController.jumpTo(82 * value + 0.0);
      detailsController.animateToPage(value,
          duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    } catch (e) {}
    notifyListeners();
  }

  bool _isRemarkShown = false;

  bool get isRemarkShown => _isRemarkShown;

  List<SubGroup>? get dataToDisplay => _dataToDisplay;

  set dataToDisplay(List<SubGroup>? value) {
    _dataToDisplay = value;
    notifyListeners();
  }

  bool get confirmButtonDisabled => _confirmButtonDisabled;

  set confirmButtonDisabled(bool value) {
    _confirmButtonDisabled = value;
    notifyListeners();
  }

  showRemark() {
    _isRemarkShown = !_isRemarkShown;
    notifyListeners();
  }


  validation(BuildContext context) {
    context.read<OrderVariation>().isAllDone = true;
    for (var element in context
        .read<DataManagement>()
        .hiveBox.subgroups.sublist(0, 2)) {
      String message =
          context.read<OrderScreenManagement>().checkContains(element);
      if (message == "Order to be taken") {
        context.read<OrderVariation>().isAllDone = false;
        break;
      }
    }
  }

  String checkContains(SubGroup subGroup) {
    bool contains = false;
    singularOrder.forEach((key, value) {
      if (key.name == subGroup.name) {
        contains = true;
      }
    });
    if (contains) {
      return "Order taken";
    }
    competitiveExistingStock.forEach((key, value) {
      if (key.name == subGroup.name) {
        contains = true;
      }
    });
    if (contains) {
      return "Competitive Stock";
    }
    noOrderReasons.forEach((key, value) {
      if (key.name == subGroup.name) {
        contains = true;
      }
    });
    if (contains) {
      return "No Order Available";
    }
    ownExistingStock.forEach((key, value) {
      if (key.name == subGroup.name) {
        contains = true;
      }
    });
    if (contains) {
      return "Own Stock";
    }
    return "Order to be taken";
  }
}
