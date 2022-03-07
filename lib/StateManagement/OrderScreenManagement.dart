import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/apis/Entities/NoOrderReasonGroup.dart';
import 'package:psr_application/apis/Entities/SKU.dart';
import 'package:psr_application/apis/Entities/SKU.dart';
import 'package:psr_application/apis/Entities/SKU.dart';

import '../apis/Entities/SubGroup.dart';

class OrderScreenManagement with ChangeNotifier, DiagnosticableTreeMixin {
  List<bool> items = [];
  Map<SubGroup, Map<SKU, int>> singularOrder = {};
  bool _confirmButtonDisabled = false;
  int? currentlyExpanded;
  ScrollController controller = ScrollController();
  List<SubGroup> data = [];
  List<SubGroup>? _dataToDisplay;
  TextEditingController _noOrderRemarkController = TextEditingController();
  TextEditingController get noOrderRemarkController => _noOrderRemarkController;

  bool _isRemarkShown =false;
  bool get isRemarkShown => _isRemarkShown;

  List<SubGroup>? get dataToDisplay => _dataToDisplay;

  set dataToDisplay(List<SubGroup>? value) {
    _dataToDisplay = value;
    notifyListeners();
  }

  List<NoOrderReasonGroup> noOrderReasons = [];
  NoOrderReasonGroup? _selectedNoOrderReasonGroup;
  bool _noOrderButtonDisabled = false;

  bool get noOrderButtonDisabled => _noOrderButtonDisabled;

  set noOrderButtonDisabled(bool value) {
    _noOrderButtonDisabled = value;
    notifyListeners();
  }

  NoOrderReasonGroup? get selectedNoOrderReasonGroup =>
      _selectedNoOrderReasonGroup;

  set selectedNoOrderReasonGroup(NoOrderReasonGroup? value) {
    _selectedNoOrderReasonGroup = value;
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
    if(index!=null){
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
    }else{
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

  showRemark(){
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
    print(_dataToDisplay);
  }
}
