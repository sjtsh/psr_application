import 'package:flutter/material.dart';

import '../../apis/Entities/OutletOrder.dart';
import '../../database.dart';

class SingularOrder extends StatelessWidget {
  final OutletOrder outletOrder;

  SingularOrder(this.outletOrder);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), offset: Offset(0,2),blurRadius: 3,spreadRadius: 3)]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12),
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
                  ],
                ),
              ),
              Divider(
                color: Colors.black.withOpacity(0.1),
                thickness: 1,
              ),
              Column(
                children: [
                  ["Order ID :", "#OR${outletOrder.id.toString().padLeft(4, '0')}"],
                  ["Date :", (outletOrder.timeCreated.toString().substring(0, 19))],
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
    );
  }
}
