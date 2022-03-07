import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/OrderScreenManagement.dart';
import 'package:psr_application/apis/Entities/SKU.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';

class ConfirmVariation extends StatelessWidget {
  final MapEntry<SubGroup, Map<SKU, int>> e;

  ConfirmVariation(this.e);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Row(
              children: [
                Builder(builder: (context) {
                  return Text(
                    e.key.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
              ],
            ),
          ),
          Column(
            children: e.value.entries
                .map((f) => Material(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return ConfirmationModalSheet(f, updateReceiptData);
                          //   },
                          // );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 20,
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        f.key.name,
                                        maxLines: 3,
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      )),
                                ],
                              ),
                              Expanded(child: Container()),
                              Row(
                                children: [
                                  Text(
                                    (f.value ~/ f.key.cf).toString(),
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  Text(
                                    " ${f.key.primaryUnit}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    (f.value % f.key.cf).toString(),
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  Text(
                                    " ${f.key.secondaryUnit}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                context.read<OrderScreenManagement>().removeSKU(e.key, f.key);
                                },
                                child: Icon(
                                  Icons.cancel_outlined,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
