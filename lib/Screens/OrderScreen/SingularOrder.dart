import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/OrderScreen.dart';
import 'package:psr_application/apis/Entities/OutletOrderItem.dart';

import '../../StateManagement/MapManagement.dart';
import '../../StateManagement/OrderScreenManagement.dart';
import '../../apis/Entities/OutletOrder.dart';
import '../../apis/Entities/SKU.dart';
import '../../apis/Entities/SubGroup.dart';
import '../../database.dart';
import 'OrderItemsScreen.dart';

class SingularOrder extends StatelessWidget {
  final OutletOrder outletOrder;
  final bool editable;

  SingularOrder(this.outletOrder, {this.editable = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 2),
              blurRadius: 3,
              spreadRadius: 3)
        ]),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return OrderItemsScreen(outletOrder);
              }));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 12),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
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
                                  fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                outletOrder.outletName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                outletOrder.beatName,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        editable
                            ? GestureDetector(
                                onTap: () {
                                  Map<SubGroup, Map<SKU, int>> aMap = {};
                                  List<int> skus = [];
                                  List<int> count = [];
                                  List.generate(outletOrder.items.length,
                                      (index) {
                                    skus.add(outletOrder.items[index].skuID);
                                    count.add(
                                        outletOrder.items[index].primaryCount);
                                  });
                                  context
                                      .read<OrderScreenManagement>()
                                      .data
                                      .forEach((element1) {
                                    for (var e2 in element1.skus) {
                                      if (skus.contains(e2.id)) {
                                        if (!aMap.containsKey(element1)) {
                                          aMap[element1] = {
                                            e2: count[skus.indexOf(e2.id)]
                                          };
                                        } else {
                                          aMap[element1]![e2] =
                                              count[skus.indexOf(e2.id)];
                                        }
                                      }
                                    }
                                  });
                                  context
                                      .read<OrderScreenManagement>()
                                      .currentlyExpanded = null;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return OrderScreen(
                                          order: outletOrder,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4.0),
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
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
                        "Order ID :",
                        "#OR${outletOrder.id.toString().padLeft(4, '0')}"
                      ],
                      [
                        "Date :",
                        (outletOrder.timeCreated.toString().substring(0, 19))
                      ],
                    ]
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 5),
                            child: e[1] == "null" || e[1] == "-1"
                                ? Container()
                                : Row(
                                    children: [
                                      Text(
                                        e[0],
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        e[1],
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
          ),
        ),
      ),
    );
  }
}
