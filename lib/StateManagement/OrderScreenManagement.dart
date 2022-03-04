import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../apis/Entities/SubGroup.dart';

class Item {
  final ExpandableController expandableController;

  Item(this.expandableController);
}

class OrderScreenManagement with ChangeNotifier, DiagnosticableTreeMixin {
  List<Item> _items = [];

  List<Item> get items => _items;
  Map<String, int> _singularOrder = {};

  Map<String, int> get singularOrder => _singularOrder;

  set singularOrder(Map<String, int> value) {
    _singularOrder = value;
  }

  int? currentlyExpanded;
  ScrollController _controller = ScrollController();

  get controller => _controller;

  List<SubGroup> _data = [];

  List<SubGroup> get data => _data;

  set data(List<SubGroup> value) {
    _data = value;
  }

  set expandableController(List<Item> value) {
    _items = value;
  }

  makeExpansion(int index) {
    if (!_items[index].expandableController.value) {
      if (currentlyExpanded != null) {
        _items[currentlyExpanded!].expandableController.value = false;
      }
      _items[index].expandableController.value = true;
      currentlyExpanded = index;
    } else {
      _items[index].expandableController.value = false;
      currentlyExpanded = null;
    }
  }
}
