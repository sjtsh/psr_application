
import 'package:flutter/material.dart';
import 'package:psr_application/Screens/OrderHistory/UnSyncedOrderItem.dart';
import '../../apis/Entities/OutletOrder.dart';
import '../../database.dart';

class UnSyncedOrder extends StatelessWidget {
  final OutletOrder outletOrderLocal;
  final bool editable;

  UnSyncedOrder(this.outletOrderLocal, {this.editable = false});

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
                return UnSyncedOrderItem(outletOrderLocal);
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
                              getInitials(outletOrderLocal.outletName),
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
                                outletOrderLocal.outletName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                outletOrderLocal.beatName,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4.0),
                            child: Text(
                              "Not Synced",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        editable
                            ? GestureDetector(
                                onTap: () {
                                  // Map<SubGroup, Map<SKU, int>> aMap = {};
                                  // List<int> skus = [];
                                  // List<int> count = [];
                                  // List.generate(outletOrderLocal.items.length,
                                  //         (index) {
                                  //       skus.add(outletOrderLocal.items[index].skuID);
                                  //       count.add(
                                  //           outletOrderLocal.items[index].primaryCount);
                                  //     });
                                  // context
                                  //     .read<OrderScreenManagement>()
                                  //     .data
                                  //     .forEach((element1) {
                                  //   for (var e2 in element1.skus) {
                                  //     if (skus.contains(e2.id)) {
                                  //       if (!aMap.containsKey(element1)) {
                                  //         aMap[element1] = {
                                  //           e2: count[skus.indexOf(e2.id)]
                                  //         };
                                  //       } else {
                                  //         aMap[element1]![e2] =
                                  //         count[skus.indexOf(e2.id)];
                                  //       }
                                  //     }
                                  //   }
                                  // });
                                  // context
                                  //     .read<OrderScreenManagement>()
                                  //     .currentlyExpanded = null;
                                  // context
                                  //     .read<OrderScreenManagement>()
                                  //     .singularOrder = aMap;
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (_) {
                                  //       return OrderScreen(
                                  //         order: outletOrderLocal,
                                  //       );
                                  //     },
                                  //   ),
                                  // );
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
                        "Not Synced",
                      ],
                      [
                        "Date :",
                        (outletOrderLocal.timeCreated
                            .toString()
                            .substring(0, 19))
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
