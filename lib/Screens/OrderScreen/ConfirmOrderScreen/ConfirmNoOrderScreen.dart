import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/apis/Entities/OutletOrder.dart';
import '../../../StateManagement/OrderScreenManagement.dart';
import 'ConfirmVariation.dart';

class ConfirmNoOrderScreen extends StatelessWidget {
  final OutletOrder? order;

  ConfirmNoOrderScreen(this.order);

  @override
  Widget build(BuildContext context) {
    int a = 0;
    double b = 0;
    double c = 0;
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
                        SizedBox(
                          height: 6,
                        ),
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
                              SizedBox(
                                height: 6,
                              ),
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
                              SizedBox(
                                height: 6,
                              ),
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
                              SizedBox(
                                height: 6,
                              ),
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
                                  // doneOrder();
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
}
