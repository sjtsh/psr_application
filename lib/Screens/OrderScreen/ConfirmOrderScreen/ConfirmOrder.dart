import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Signature/signature_page.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';

import '../../../StateManagement/OrderScreenManagement.dart';

class ConfirmNoOrder extends StatelessWidget {
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
               Padding(
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
                                      Expanded(
                                        child: Padding(
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
                                              Text(
                                                "No Order Reasons:",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                              ),
                                              SizedBox(height: 6),
                                              Text(
                                                e.value,
                                                textDirection: TextDirection.ltr,
                                                style: TextStyle(color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                              .toList(),
                        ),
                        context
                            .read<OrderScreenManagement>()
                            .noOrderReasons.isNotEmpty &&  context
                            .read<OrderScreenManagement>()
                            .competitiveExistingStock.isNotEmpty ?  Divider(height: 3, thickness: 2,): Container(),
                        Column(
                          children: context
                              .read<OrderScreenManagement>()
                              .competitiveExistingStock
                              .entries
                              .map((e) => Row(
                            children: [
                              Expanded(
                                child: Padding(
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
                                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                      ),
                                      Text(
                                        e.value,
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ))
                              .toList(),
                        ),
                        context
                            .read<OrderScreenManagement>()
                            .competitiveExistingStock.isNotEmpty &&context
                            .read<OrderScreenManagement>()
                            .ownExistingStock.isNotEmpty ?  Divider(height: 3, thickness: 2,): Container(),
                        Column(
                          children: context
                              .read<OrderScreenManagement>()
                              .ownExistingStock
                              .entries
                              .map((e) => Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                          e.value["stock_count"].toString(),
                                          overflow: TextOverflow.ellipsis,textDirection: TextDirection.rtl,
                                          maxLines: 5,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  Expanded(child: Container()),
                                    SizedBox(
                                      height: 50,
                                      width: 60,
                                      child: Image.file(
                                        File(e.value["img"].toString(),
                                        ),
                                        fit: BoxFit.contain,
                                      ),
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
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=> SignaturePage()));
                  },
                  child: Center(
                    child: Text(
                      "CONFIRM AND SEND",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
          ),
          SizedBox(height: 12,)
        ]),
      ),
    );
  }
}
