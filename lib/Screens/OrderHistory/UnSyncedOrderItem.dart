import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../../apis/Entities/OutletOrder.dart';
import '../../database.dart';

class UnSyncedOrderItem extends StatelessWidget {
  final OutletOrder outletOrderLocal;

  UnSyncedOrderItem(this.outletOrderLocal);

  @override
  Widget build(BuildContext context) {
    int a = 0;
    double b = 0;
    for (var element in outletOrderLocal.items) {
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
                                          getInitials(outletOrderLocal.outletName),
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
                                      outletOrderLocal.outletName,
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
                                    "#OU${outletOrderLocal.outletID.toString()}"
                                  ],
                                  ["Outlet Name :", outletOrderLocal.outletName],
                                  [
                                    "Time Created :",
                                    (outletOrderLocal.timeCreated.toString())
                                  ],
                                  [
                                    "Outlet Plan ID :",
                                    outletOrderLocal.outletPlanID.toString()
                                  ],
                                  ["Beat Name :", outletOrderLocal.beatName],
                                  ["Remarks :", "${outletOrderLocal.remarks}"],
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
                                      children: outletOrderLocal.items
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
