import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Screens/Screen1.dart';
import '../Screens/Screen2.dart';
import '../Screens/Screen3.dart';

class Counter with ChangeNotifier, DiagnosticableTreeMixin {
  int _currentScreen = 0;
  Widget currentScreenWidget = Screen1();
  List<Widget> currentScreenWidgetList = [Screen1(), Screen2(), Screen3()];

  int get currentScreen => _currentScreen;

  void increment(int i) {
    _currentScreen = i;
    currentScreenWidget = currentScreenWidgetList[i];
    notifyListeners();
  }
}
