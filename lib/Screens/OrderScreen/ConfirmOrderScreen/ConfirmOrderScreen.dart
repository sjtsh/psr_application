import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/ConfirmOrderScreen/ConfirmVariation.dart';
import 'package:psr_application/StateManagement/MapManagement.dart';
import 'package:psr_application/apis/Services/OrderService.dart';

import '../../../StateManagement/OrderScreenManagement.dart';
import '../../../apis/Entities/OutletOrder.dart';

class ConfirmOrderScreen extends StatelessWidget {
  final OutletOrder? order;

  ConfirmOrderScreen({this.order});

  @override
  Widget build(BuildContext context) {
    int a = 0;
    double b = 0;
    context.watch<OrderScreenManagement>().singularOrder.forEach((key, value) {
      value.forEach((x, z) {
        a += z;
        b += z * x.ptr;
      });
    });
    return SafeArea(
      child: Scaffold(
        body: context.watch<OrderScreenManagement>().singularOrder.isEmpty
            ? Column(
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
                    child: const Center(
                      child: Text("No Orders"),
                    ),
                  ),
                ],
              )
            : ListView(
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
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          "Total Order",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          "$a Units ${b.toStringAsFixed(1)} Rs",
                          style: TextStyle(fontSize: 12),
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
                        Column(
                          children: context
                              .watch<OrderScreenManagement>()
                              .singularOrder
                              .entries
                              .map((e) => ConfirmVariation(e))
                              .toList(),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          height: 40,
                          child: Row(
                            children: [
                              Text(
                                "Total Value",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Text(
                                "$a Units ${b.toStringAsFixed(1)} Rs",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Container(
                              clipBehavior: Clip.hardEdge,
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: MaterialButton(
                                onPressed: () async {
                                  if (context
                                          .read<OrderScreenManagement>()
                                          .singularOrder
                                          .isNotEmpty &&
                                      !context
                                          .read<OrderScreenManagement>()
                                          .confirmButtonDisabled) {
                                    context
                                        .read<OrderScreenManagement>()
                                        .confirmButtonDisabled = true;
                                    bool success;
                                    if (order == null) {
                                      success = await OrderService()
                                          .insertOrder(
                                              context
                                                  .read<OrderScreenManagement>()
                                                  .singularOrder,
                                              "remarks",
                                              context
                                                  .read<MapManagement>()
                                                  .selectedOutlet!
                                                  .outletPlanId);
                                    } else {
                                      success = false;
                                    }
                                    if (success) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("Successful"),
                                        ),
                                      );
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("Unsuccessful"),
                                        ),
                                      );
                                    }
                                    context
                                        .read<OrderScreenManagement>()
                                        .confirmButtonDisabled = false;
                                  }
                                },
                                child: Center(
                                  child: context
                                          .read<OrderScreenManagement>()
                                          .confirmButtonDisabled
                                      ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ))
                                      : Text(
                                          "Confirm",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
