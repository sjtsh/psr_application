import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psr_application/apis/Entities/OutletOrder.dart';

class OrderScreen extends StatelessWidget {
  final OutletOrder? order;

  OrderScreen({this.order});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Order",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            // SingularProduct(),
          ],
        ),
      ),
    );
  }
}
