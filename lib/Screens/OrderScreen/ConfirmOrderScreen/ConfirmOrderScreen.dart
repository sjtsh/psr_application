import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/ConfirmOrderScreen/ConfirmNoOrderScreen.dart';
import 'package:psr_application/Screens/OrderScreen/ConfirmOrderScreen/ConfirmVariation.dart';
import 'package:psr_application/Signature/signature_page.dart';
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
    double c = 0;
    context.watch<OrderScreenManagement>().singularOrder.forEach((key, value) {
      value.forEach((x, z) {
        a += z;
        b += z * x.ptr;
        c += z * (x.mrp - x.ptr);
      });
    });
    return SafeArea(
      child: Scaffold(
      backgroundColor: Colors.white,
        body: context.watch<OrderScreenManagement>().singularOrder.isEmpty
            ? Column(
                children: [
                  Container(
                    height: 60,
                    color: Colors.white,
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
                          onPressed: () {
                            context.read<OrderScreenManagement>().showRemark();
                          },
                          icon: Icon(
                            Icons.menu,
                            color: Colors.black,
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
                          onPressed: () {
                            context.read<OrderScreenManagement>().showRemark();
                          },
                          icon: Icon(
                            Icons.menu,
                            color: !context
                                    .watch<OrderScreenManagement>()
                                    .isRemarkShown
                                ? Colors.black
                                : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
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
                        SizedBox(height: 6,),
                        Row(
                          children: [
                            Text(
                              "Profit margin",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              "${c.toStringAsFixed(1)} Rs",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
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
                          height: 60,
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            SizedBox(height: 6,),
                              Row(
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
                              SizedBox(height: 6,),
                              Row(
                                children: [
                                  Text(
                                    "Profit margin",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Text(
                                    "${c.toStringAsFixed(1)} Rs",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6,),
                            ],
                          ),
                        ),
                        !context.watch<OrderScreenManagement>().isRemarkShown
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextFormField(
                                  controller: context
                                      .read<OrderScreenManagement>()
                                      .confirmOrderRemarkController,
                                  decoration: InputDecoration(
                                      prefixIcon:
                                          const Icon(Icons.book_outlined),
                                      focusColor: Colors.green,
                                      hintText: "Remark",
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          borderSide: const BorderSide(
                                              color: Colors.green)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          borderSide: BorderSide(
                                              color: Colors.black
                                                  .withOpacity(0.1)))),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Container(
                              clipBehavior: Clip.hardEdge,
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color:
                                    order == null ? Colors.green : Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: MaterialButton(
                                onPressed: () async {
                                  Navigator.push(context, MaterialPageRoute(builder: (_){

                                    return SignaturePage();
                                  }));
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
                                          order == null ? "Confirm" : "Edit",
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

  doneOrder(BuildContext context) async {
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
      bool success = false;
      try {
        if (order == null) {
          // needed to revise
          // success = await OrderService()
          //     .insertOrder(
          //         context
          //             .read<
          //                 OrderScreenManagement>()
          //             .singularOrder,
          //     context
          //         .read<OrderScreenManagement>()
          //         .confirmOrderRemarkController.text ,
          //         context
          //             .read<MapManagement>()
          //             .selectedOutlet!
          //             .outletPlanId);
        } else {
          success = await OrderService()
              .updateOrder(
              context
                  .read<
                  OrderScreenManagement>()
                  .singularOrder,
              context
                  .read<
                  OrderScreenManagement>()
                  .confirmOrderRemarkController
                  .text,
              order!.id);
        }
      } catch (e) {
        print(e);
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
  }
}
