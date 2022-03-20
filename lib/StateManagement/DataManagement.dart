import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:psr_application/HiveBox/HiveBox.dart';
import 'package:psr_application/apis/Entities/Performance.dart';
import 'package:psr_application/apis/LocalToInsert/OutletOrderEntity.dart';

import '../HiveBox/HiveBoxLocal.dart';
import '../apis/LocalToInsert/OutletClosedEntity.dart';

class DataManagement with ChangeNotifier, DiagnosticableTreeMixin {
  late HiveBox hiveBox;
  late HiveBoxLocal hiveBoxLocal;
  bool isSyncing = false;

  syncAll(BuildContext context) async{

  }

  insertOutletOrder(OutletOrderEntity outletOrderEntity) async {
    hiveBoxLocal.outletOrders.add(outletOrderEntity);
    await hiveBoxLocal.save();
    syncOutletOrder(outletOrderEntity);
  }

  insertOutletClosed(OutletClosedEntity outletClosedEntity) async {
    hiveBoxLocal.outletCloseds.add(outletClosedEntity);
    hiveBox.outlets
        .firstWhere((element) =>
    element.outletPlanId == outletClosedEntity.outletPlanID)
        .isDone = true;
    await hiveBox.save();
    await hiveBoxLocal.save();
    notifyListeners();
  }

  syncOutletOrder(OutletOrderEntity outletOrderEntity) async {
    double valueAdded = 0;
    int rewardPoints = 0;
    outletOrderEntity.singularOrder.forEach((key, value) {
      value.forEach((key, value) {
        valueAdded += value * key.ptr;
        valueAdded += value * key.reward;
      });
    });

    //updating performances
    for (Performance element in hiveBox.performances) {
      if (valueAdded != 0) {
        element.productiveVisit += 1;
      }
      element.successVisit += 1;
      element.netValueSales += valueAdded;
      element.rewardPoints += rewardPoints;
    }

    //counting unique skus for the day cant do for month or week
    Set uniqueSKUs = {};
    for (var element in hiveBox.outletOrders) {
      for (var element in element.items) {
        uniqueSKUs.add(element.id);
      }
    }

    outletOrderEntity.singularOrder.forEach((key, value) {
      value.forEach((key, value) {
        uniqueSKUs.add(key.id);
      });
    });
    hiveBox.performances[0].avgSKU = uniqueSKUs.length;

    //setting the outlet plan as done
    hiveBox.outlets
        .firstWhere(
            (element) => element.outletPlanId == outletOrderEntity.outletPlanID)
        .isDone = true;
    await hiveBox.save();
    notifyListeners();
  }

}
