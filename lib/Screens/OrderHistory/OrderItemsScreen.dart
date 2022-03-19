import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/apis/Entities/OutletOrder.dart';
import 'package:psr_application/apis/Entities/OutletOrderItem.dart';
import 'package:psr_application/apis/Entities/SKU.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';

import '../../StateManagement/OrderScreenManagement.dart';
import '../../apis/Entities/Outlet.dart';
import '../../database.dart';

class OrderItemsScreen extends StatelessWidget {
  final OutletOrder outletOrder;

  OrderItemsScreen(this.outletOrder);

  @override
  Widget build(BuildContext context) {
    int a = 0;
    double b = 0;
    for (var element in outletOrder.items) {
      a += element.primaryCount;
      b += element.ptr * element.primaryCount;
    }
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 60,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_rounded),
                  ),
                  Expanded(
                    child: Text(
                      "Outlet Description",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 3,
                                offset: Offset(0, 2))
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 12),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffEA47B2),
                                      ),
                                      child: Center(
                                        child: Text(
                                          getInitials(outletOrder.outletName),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 8),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      outletOrder.outletName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black.withOpacity(0.1),
                                thickness: 1,
                              ),
                              Column(
                                children: [
                                  [
                                    "Outlet ID :",
                                    "#OU${outletOrder.outletID.toString()}"
                                  ],
                                  ["Outlet Name :", outletOrder.outletName],
                                  [
                                    "Time Created :",
                                    (outletOrder.timeCreated.toString())
                                  ],
                                  [
                                    "Outlet Plan ID :",
                                    outletOrder.outletPlanID.toString()
                                  ],
                                  ["Beat Name :", outletOrder.beatName],
                                  ["Remarks :", "${outletOrder.remarks}"],
                                ]
                                    .map(
                                      (e) => e[1] == "null" || e[1] == "-1"
                                          ? Container()
                                          : Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 5.0,
                                                      horizontal: 12),
                                                  child: Row(
                                                    children: [
                                                      Text(e[0]),
                                                      Expanded(
                                                          child: Container()),
                                                      Text(
                                                        e[1],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  thickness: 1,
                                                ),
                                              ],
                                            ),
                                    )
                                    .toList(),
                              ),
                              ExpandablePanel(
                                collapsed: Column(
                                  children: [
                                    ExpandableButton(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 12),
                                        child: Row(
                                          children: [
                                            Text("Order List"),
                                            Expanded(
                                              child: Container(),
                                            ),
                                            Icon(Icons
                                                .keyboard_arrow_down_rounded),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black.withOpacity(0.1),
                                      thickness: 1,
                                    ),
                                  ],
                                ),
                                expanded: Column(
                                  children: [
                                    ExpandableButton(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 12),
                                        child: Row(
                                          children: [
                                            Text("Order List"),
                                            Expanded(
                                              child: Container(),
                                            ),
                                            Icon(Icons
                                                .keyboard_arrow_down_rounded),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: outletOrder.items
                                          .map(
                                            (e) => Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xffF5F5F5),
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                  ),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 12),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      e.skuName,
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Text(
                                                      "${e.primaryCount~/e.cf}${e.primaryUnit} ${e.primaryCount % e.cf}${e.secondaryUnit}",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 12),
                                child: Row(
                                  children: [
                                    Text("Total Amount"),
                                    Expanded(child: Container()),
                                    Text(
                                      "$a Units, Rs. $b",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: 74),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
