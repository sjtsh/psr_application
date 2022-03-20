import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/ConfirmOrderScreen/ConfirmOrder.dart';
import 'package:psr_application/Screens/OrderScreen/OrderScreen.dart';
import 'package:psr_application/Screens/OrderScreen/SubgroupListScreen/SingularProduct.dart';
import 'package:psr_application/Screens/OrderScreen/SubgroupListScreen/SubGroupBanner.dart';
import 'package:psr_application/StateManagement/NoOrderManagement.dart';
import 'package:psr_application/StateManagement/OrderScreenManagement.dart';
import 'package:psr_application/StateManagement/OrderVariation.dart';

import '../../../StateManagement/DataManagement.dart';
import '../../../StateManagement/ShopClosedController.dart';
import '../../../apis/Entities/SubGroup.dart';
import '../ConfirmOrderScreen/ConfirmOrderScreen.dart';
import '../NoOrder/NoOrderScreen.dart';

class SubGroupListScreen extends StatefulWidget {
  @override
  State<SubGroupListScreen> createState() => _SubGroupListScreenState();
}

class _SubGroupListScreenState extends State<SubGroupListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color(0Xfff2f2f2),
          child: Column(
            children: [
              Container(
                height: 50,
                color: Colors.white,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    Expanded(
                      child: Center(
                          child: Text("Take Order",
                              style: TextStyle(fontSize: 20))),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: context
                      .watch<DataManagement>()
                      .hiveBox
                      .subgroups
                      .asMap()
                      .entries
                      .map((e) => SubGroupBanner(e.key, e.value))
                      .toList(),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (context.read<OrderVariation>().isAllDone) {
                    if (context
                        .read<OrderScreenManagement>()
                        .singularOrder
                        .isEmpty) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ConfirmOrder();
                      }));
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ConfirmOrderScreen();
                      }));
                    }
                  } else {
                    context
                        .read<OrderScreenManagement>()
                        .keys
                        .forEach((element) {
                      try {
                        final dynamic tooltip = element.currentState;
                        tooltip.ensureTooltipVisible();
                      } catch (e) {}
                    });
                  }
                },
                child: Container(
                  height: 60,
                  color: context.watch<OrderVariation>().isAllDone
                      ? Colors.green
                      : Colors.blueGrey,
                  child: Center(
                    child: Text(
                      "Confirm" " ("+
                          (context
                                      .watch<OrderScreenManagement>()
                                      .noOrderReasons
                                      .length +
                                  context
                                      .watch<OrderScreenManagement>()
                                      .competitiveExistingStock
                                      .length +
                                  context
                                      .watch<OrderScreenManagement>()
                                      .ownExistingStock
                                      .length +
                                  context
                                      .watch<OrderScreenManagement>()
                                      .singularOrder
                                      .length)
                              .toString() +
                          "/" +
                          context
                              .read<DataManagement>()
                              .hiveBox
                              .subgroups
                              .length
                              .toString() + ")",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
