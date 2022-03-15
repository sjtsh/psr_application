import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/OrderScreen.dart';
import 'package:psr_application/Screens/OrderScreen/SubgroupListScreen/SingularProduct.dart';
import 'package:psr_application/Screens/OrderScreen/SubgroupListScreen/SubGroupBanner.dart';
import 'package:psr_application/StateManagement/NoOrderManagement.dart';
import 'package:psr_application/StateManagement/OrderScreenManagement.dart';
import 'package:psr_application/StateManagement/OrderVariation.dart';

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
                      .watch<OrderScreenManagement>()
                      .data
                      .asMap()
                      .entries
                      .map((e) => SubGroupBanner(e.key, e.value))
                      .toList(),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // if (context.read<OrderVariation>().isAllDone) {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ConfirmOrderScreen();
                    }));
                  // } else {
                  //   context
                  //       .read<OrderScreenManagement>()
                  //       .keys
                  //       .forEach((element) {
                  //     try {
                  //       final dynamic tooltip = element.currentState;
                  //       tooltip.ensureTooltipVisible();
                  //     } catch (e) {}
                  //   });
                  // }
                },
                child: Container(
                  height: 60,
                  color: context.read<OrderVariation>().isAllDone
                      ? Colors.green
                      : Colors.blueGrey,
                  child: Center(
                    child: Text(
                      "Confirm",
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