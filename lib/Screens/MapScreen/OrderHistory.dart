import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/SingularOrder.dart';

import '../../StateManagement/BeatManagement.dart';
import '../../apis/Entities/Outlet.dart';

class OrderHistory extends StatelessWidget {
  final Outlet outlet;

  OrderHistory(this.outlet);

  @override
  Widget build(BuildContext context) {
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
                    child: Center(
                      child: Text(outlet.name),
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
                child: context
                        .read<BeatManagement>()
                        .outletOrders
                        .where((element) => element.outletID == outlet.id)
                        .isEmpty
                    ? Center(
                        child: Text("No orders in beat plan"),
                      )
                    : Container(
                        child: Column(
                          children: context
                              .read<BeatManagement>()
                              .outletOrders
                              .where((element) => element.outletID == outlet.id)
                              .map((e) => SingularOrder(e))
                              .toList(),
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}
