import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';

import '../../../StateManagement/OrderScreenManagement.dart';

class ConfirmOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SubGroup subGroup;
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
                      child: Text("Confirm Order"),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.transparent,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 2),
                      blurRadius: 3)
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  ...context
                      .read<OrderScreenManagement>()
                      .noOrderReasons
                      .entries
                      .map(
                        (e) => Text(e.key.name.toString()),
                      )
                      .toList(),
                  Text(context
                      .read<OrderScreenManagement>()
                      .noOrderReasons
                      [context
                      .read<OrderScreenManagement>()
                      .noOrderReasons.keys.toList()[2]]!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
