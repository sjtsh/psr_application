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
        body: ListView(children: [
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
          context.read<OrderScreenManagement>().noOrderReasons.isEmpty
              ? Expanded(
                  child: Container(
                  child: Center(
                    child: Text("No Order Reason"),
                  ),
                ))
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: double.infinity,
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
                        Column(
                          children: context
                              .read<OrderScreenManagement>()
                              .noOrderReasons
                              .entries
                              .map((e) => Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e.key.name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 6),
                                            // Expanded(child: Container()),
                                            Text(
                                              "No Order Reasons:",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              e.value,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ))
                              .toList(),
                        ),
                        Column(
                          children: context
                              .read<OrderScreenManagement>()
                              .competitiveExistingStock
                              .entries
                              .map((e) => Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.key.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 6),
                                    // Expanded(child: Container()),
                                    Text(
                                      "Competitive Stock:",
                                      overflow: TextOverflow.ellipsis,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                    ),
                                    Text(
                                      e.value,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))
                              .toList(),
                        ),
                        Column(
                          children: context
                              .read<OrderScreenManagement>()
                              .ownExistingStock
                              .entries
                              .map((e) => Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.key.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 6),
                                    // Expanded(child: Container()),
                                    Text(
                                      "Own Stock:",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                    ),
                                    Text(
                                      "This is me. My name is sth. Hello, I am playling holi with you.",
                                      overflow: TextOverflow.ellipsis,textDirection: TextDirection.rtl,
                                      maxLines: 5,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))
                              .toList(),
                        )

                      ],
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
                clipBehavior: Clip.hardEdge,
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: MaterialButton(
                  onPressed: () {},
                  child: Center(
                    child: Text(
                      "CONFIRM AND SEND",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
          )
        ]),
      ),
    );
  }
}
