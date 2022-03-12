import 'package:carousel_slider/carousel_controller.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/apis/Entities/NoOrderReasonGroup.dart';
import 'package:psr_application/apis/Entities/OutletOrderItem.dart';
import 'package:psr_application/apis/Entities/SKU.dart';
import 'package:psr_application/apis/Entities/SKU.dart';
import 'package:psr_application/apis/Entities/SKU.dart';

import '../apis/Entities/SubGroup.dart';

class OrderScreenManagement with ChangeNotifier, DiagnosticableTreeMixin {
  List<bool> items = [];
  Map<SubGroup, Map<SKU, int>> singularOrder = {};
  Map<SubGroup, String> competitiveExistingStock = {};
  Map<SubGroup, Map<String, String>> ownExistingStock =
      {}; // the value for a subgroup to have two keys first one should be stock_count and other should be img url
  Map<SubGroup, String> noOrderReasons = {};

  bool _confirmButtonDisabled = false;
  int? currentlyExpanded;
  String _dropdownValueFilter = "All";

  List<SubGroup> data = [];
  List<SubGroup>? _dataToDisplay;
  List<OutletOrderItem> outletOrderItem = [];

  TextEditingController _noOrderRemarkController = TextEditingController();

  TextEditingController get noOrderRemarkController => _noOrderRemarkController;
  TextEditingController _confirmOrderRemarkController = TextEditingController();
  ScrollController controller = ScrollController();

  TextEditingController get confirmOrderRemarkController =>
      _confirmOrderRemarkController;
  PageController pageController = PageController();

  int _pageViewInt = 0;

  int get pageViewInt => _pageViewInt;

  set pageViewInt(int value) {
    _pageViewInt = value;
    notifyListeners();
  }

  String get dropdownValueFilter => _dropdownValueFilter;

  set dropdownValueFilter(String value) {
    _dropdownValueFilter = value;
    List<SubGroup> subGroups = [];
    try {
      for (var element1 in data) {
        for (var element2 in element1.skus) {
          List<String> dropdownvalues = ["Promoted", "New", "Trending"];
          List<bool> boolList = [
            element2.isPromoted,
            element2.isNew,
            element2.isTrending
          ];
          if (boolList[dropdownvalues.indexOf(value)]) {
            bool isAlreadyThere = false;
            for (var element3 in subGroups) {
              if (element3.name == element1.name) {
                isAlreadyThere = true;
                element3.skus.add(element2);
                break;
              }
            }
            if (!isAlreadyThere) {
              subGroups.add(
                  SubGroup(element1.name, element1.productName, [element2]));
            }
          }
        }
      }

      _dataToDisplay = subGroups;
    } catch (e) {
      _dataToDisplay = null;
    }

    notifyListeners();
  }

  bool _isRemarkShown = false;

  bool get isRemarkShown => _isRemarkShown;

  List<SubGroup>? get dataToDisplay => _dataToDisplay;

  set dataToDisplay(List<SubGroup>? value) {
    _dataToDisplay = value;
    notifyListeners();
  }

  bool _noOrderButtonDisabled = false;

  bool get noOrderButtonDisabled => _noOrderButtonDisabled;

  set noOrderButtonDisabled(bool value) {
    _noOrderButtonDisabled = value;
    notifyListeners();
  }

  bool get confirmButtonDisabled => _confirmButtonDisabled;

  set confirmButtonDisabled(bool value) {
    _confirmButtonDisabled = value;
    notifyListeners();
  }

  set expandableController(List<bool> value) {
    items = value;
  }

  makeExpansion(int? index) {
    if (index != null) {
      if (!items[index]) {
        if (currentlyExpanded != null) {
          items[currentlyExpanded!] = false;
        }
        items[index] = true;
        currentlyExpanded = index;
      } else {
        items[index] = false;
        currentlyExpanded = null;
      }
    } else {
      currentlyExpanded = null;
    }
    notifyListeners();
  }

  removeSKU(SubGroup subGroup, SKU sku) {
    singularOrder[subGroup]?.remove(sku);
    if (singularOrder[subGroup]?.keys.isEmpty ?? false) {
      singularOrder.remove(subGroup);
    }
    notifyListeners();
  }

  showRemark() {
    _isRemarkShown = !_isRemarkShown;
    notifyListeners();
  }

  searchProducts(String searchText) {
    _dataToDisplay = data.where((SubGroup subgroup) {
      return subgroup.name
              .toString()
              .toLowerCase()
              .contains(searchText.toLowerCase()) ||
          subgroup.productName
              .toString()
              .toLowerCase()
              .contains(searchText.toLowerCase());
    }).toList();
    notifyListeners();
  }

  checkContains(SubGroup subGroup) {
    bool contains = false;
    singularOrder.forEach((key, value) {
      if (key.name == subGroup.name) {
        contains = true;
      }
    });
    competitiveExistingStock.forEach((key, value) {
      if (key.name == subGroup.name) {
        contains = true;
      }
    });
    noOrderReasons.forEach((key, value) {
      if (key.name == subGroup.name) {
        contains = true;
      }
    });
    ownExistingStock.forEach((key, value) {
      if (key.name == subGroup.name) {
        contains = true;
      }
    });
    return contains;
  }
}
