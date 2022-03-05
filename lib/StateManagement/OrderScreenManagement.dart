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

  List<ExpandableController> items = [];
  Map<SubGroup, Map<SKU, int>>  singularOrder = {};
  bool _confirmButtonDisabled = false;
  int? currentlyExpanded;
  ScrollController controller = ScrollController();
  List<SubGroup> data = [];
  List<NoOrderReasonGroup> noOrderReasons  = [];
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

  set expandableController(List<ExpandableController> value) {
    items = value;
  }

  makeExpansion(int index) {
    if (!items[index].value) {
      if (currentlyExpanded != null) {
        items[currentlyExpanded!].value = false;
      }
      items[index].value = true;
      currentlyExpanded = index;
    } else {
      items[index].value = false;
      currentlyExpanded = null;
    }
  }

  removeSKU(SubGroup subGroup, SKU sku){
    singularOrder[subGroup]?.remove(sku);
    if(singularOrder[subGroup]?.keys.isEmpty ?? false){
      singularOrder.remove(subGroup);
    }
    notifyListeners();
  }
}
