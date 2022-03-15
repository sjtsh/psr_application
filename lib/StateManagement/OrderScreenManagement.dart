import 'package:carousel_slider/carousel_controller.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/apis/Entities/NoOrderReasonGroup.dart';
import 'package:psr_application/apis/Entities/OutletOrderItem.dart';
import 'package:psr_application/apis/Entities/SKU.dart';
import 'package:psr_application/apis/Entities/SKU.dart';
import 'package:psr_application/apis/Entities/SKU.dart';

import '../apis/Entities/SubGroup.dart';
import 'OrderVariation.dart';

class OrderScreenManagement with ChangeNotifier, DiagnosticableTreeMixin {
  ScrollController scrollController = ScrollController();
  List<bool> items = [];
  Map<SubGroup, Map<SKU, int>> _singularOrder = {};
  Map<SubGroup, String> _competitiveExistingStock = {};
  Map<SubGroup, Map<String, String>> _ownExistingStock =
      {}; // the value for a subgroup to have two keys first one should be stock_count and other should be img url
  Map<SubGroup, String> _noOrderReasons = {};
  List<GlobalKey> keys = [];
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

  String get dropdownValueFilter => _dropdownValueFilter;

  int _skuIndex = 0;

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
    print((82 * value + 164.0));
    scrollController.jumpTo(82 * value +0.0 );
    detailsController.animateToPage(value,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    notifyListeners();
  }

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

  validation(BuildContext context) {
    context.read<OrderVariation>().isAllDone = true;
    for (var element in data) {
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
