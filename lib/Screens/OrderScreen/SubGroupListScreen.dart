import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/DialogPrompt/DialogBox.dart';
import 'package:psr_application/Screens/OrderScreen/OrderScreen.dart';
import 'package:psr_application/StateManagement/NoOrderManagement.dart';
import 'package:psr_application/StateManagement/OrderScreenManagement.dart';

import '../../StateManagement/ShopClosedController.dart';
import '../../apis/Entities/SubGroup.dart';
import 'ConfirmOrderScreen/ConfirmOrderScreen.dart';
import 'NoOrder/NoOrderScreen.dart';
import 'SubgroupListScreen/SingularProduct.dart';

class SubGroupListScreen extends StatefulWidget {
  @override
  State<SubGroupListScreen> createState() => _SubGroupListScreenState();
}

class _SubGroupListScreenState extends State<SubGroupListScreen> {
  void refresh() {
    setState(() {});
  }

  bool onExistingStockTap = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    bool isAllDone = true;
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
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Builder(builder: (context) {
                            String message = context
                                .read<OrderScreenManagement>()
                                .checkContains(e.value);
                            if (message == "Order to be taken") {
                              isAllDone = false;
                            }
                            return Container(
                              height: 200,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.75),
                                      Colors.transparent
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                color: Colors.red,
                              ),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${e.value.name} ",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    "- ${e.value.productName}",
                                                    style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "${e.value.skus.length} SKUs available",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(child: Container()),
                                          Tooltip(
                                            message: message,
                                            key: message == "Order to be taken"
                                                ? context
                                                    .read<
                                                        OrderScreenManagement>()
                                                    .keys[e.key]
                                                : null,
                                            verticalOffset: 10,
                                            triggerMode: TooltipTriggerMode.tap,
                                            showDuration:
                                                const Duration(seconds: 5),
                                            child: Icon(
                                              Icons.info,
                                              color:
                                                  message == "Order to be taken"
                                                      ? Colors.red
                                                      : Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (_) {
                                                    return SingularProduct(
                                                        e.value,);
                                                  }));
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 150,
                                                  color: Colors.white,
                                                  child: const Center(
                                                    child: Text("Take Order"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: ClipRect(
                                                            child:
                                                                BackdropFilter(
                                                              filter: ImageFilter
                                                                  .blur(
                                                                      sigmaX:
                                                                          2.0,
                                                                      sigmaY:
                                                                          2.0),
                                                              child: Container(
                                                                width: width,
                                                                height: height,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade100
                                                                        .withOpacity(
                                                                            0.1)),
                                                                child: Center(
                                                                  child: MyDialogBox(
                                                                      e.value,
                                                                      refresh),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 150,
                                                  color: Colors.white,
                                                  child: const Center(
                                                    child: Text("No Order"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      )
                      .toList(),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // if (isAllDone) {
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
                  color: isAllDone ? Colors.green : Colors.blueGrey,
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
