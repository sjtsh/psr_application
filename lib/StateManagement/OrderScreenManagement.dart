import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

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

  List<List> _data = <List>[
    ["hello", "1", "2"],
    ["hello", 1, 2, 3],
    [5, 1, 2],
    ["hello", 1, 2, 4, 5],
    ["hello", "1", "2"],
    ["hello", 1, 2, 3],
    [5, 1, 2],
    ["hello", 1, 2, 4, 5],
    ["hello", "1", "2"],
    ["hello", 1, 2, 3],
    [5, 1, 2],
    ["hello", 1, 2, 4, 5],
    ["hello", "1", "2"],
    ["hello", 1, 2, 3],
    [5, 1, 2],
    ["hello", 1, 2, 4, 5],
    ["hello", "1", "2"],
    ["hello", 1, 2, 3],
    [5, 1, 2],
    ["hello", 1, 2, 4, 5],
    ["hello", "1", "2"],
    ["hello", 1, 2, 3],
    [5, 1, 2],
    ["hello", 1, 2, 4, 5],
    ["hello", "1", "2"],
    ["hello", 1, 2, 3],
    [5, 1, 2],
    ["hello", 1, 2, 4, 5],
    ["hello", "1", "2"],
    ["hello", 1, 2, 3],
    [5, 1, 2],
    ["hello", 1, 2, 4, 5],
    ["hello", "1", "2"],
    ["hello", 1, 2, 3],
    [5, 1, 2],
    ["hello", 1, 2, 4, 5],
    ["hello", "1", "2"],
    ["hello", 1, 2, 3],
    [5, 1, 2],
    ["hello", 1, 2, 4, 5],
    ["hello", 1, 2, 4, 5],
    ["hello", "1", "2"],
    ["hello", 1, 2, 3],
    [5, 1, 2],
    ["hello", 1, 2, 4, 5],
    ["hello", "1", "2"],
    ["hello", 1, 2, 3],
    [5, 1, 2],
    ["hello", 1, 2, 4, 5],
    ["hello", "1", "2"],
    ["hello", 1, 2, 3],
    [5, 1, 2],
    ["hello", 1, 2, 4, 5],
    ["hello", "1", "2"],
    ["hello", 1, 2, 3],
    [5, 1, 2],
    ["hello", 1, 2, 4, 5],
    ["hello", "1", "2"],
    ["hello", 1, 2, 3],
    [5, 1, 2],
    ["hello", 1, 2, 4, 5],
    ["hello", "1", "2"],
    ["hello", 1, 2, 3],
    [5, 1, 2],
    ["hello", 1, 2, 4, 5],
  ];

  List<List> get data => _data;

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
