import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/OrderVariation.dart';

import '../../../StateManagement/OrderScreenManagement.dart';
import '../../../apis/Entities/SKU.dart';
import '../../../apis/Entities/SubGroup.dart';

class SubgroupDetails extends StatefulWidget {
  final SKU sku;
  final SubGroup subGroup;

  SubgroupDetails(
    this.sku,
    this.subGroup,
  );

  @override
  _SubgroupdetailsState createState() => _SubgroupdetailsState();
}

class _SubgroupdetailsState extends State<SubgroupDetails> {
  TextEditingController primary = TextEditingController();
  TextEditingController alternative = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(context.read<OrderVariation>().tempSubGroupVariation);
    if (context.read<OrderVariation>().tempSubGroupVariation[widget.sku] !=
        null) {
      primary.text =
          (context.read<OrderVariation>().tempSubGroupVariation[widget.sku]! ~/
                  widget.sku.cf)
              .toString();
      alternative.text =
          (context.read<OrderVariation>().tempSubGroupVariation[widget.sku]! %
                  widget.sku.cf)
              .toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
        child: Column(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ["ID:", "#SK${widget.sku.id.toString().padLeft(4, "0")}"],
              ["Name:", widget.sku.name],
              ["MRP:", widget.sku.mrp],
              ["PTR:", widget.sku.ptr],
              ["CF:", widget.sku.cf],
              ["Profit:", widget.sku.mrp - widget.sku.ptr],
            ]
                .map(
                  (e) => Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            e[0].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Container()),
                          Text(e[1].toString(),
                              style: TextStyle(color: Colors.grey))
                        ],
                      ),
                      SizedBox(height: 6,),
                    ],
                  ),
                )
                .toList(),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Text("Quantity"),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: TextField(
                      controller: primary,
                      cursorWidth: 1,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.blue,
                      onChanged: (text) {
                        int a =
                            (int.tryParse(primary.text) ?? 0) * widget.sku.cf +
                                (int.tryParse(alternative.text) ?? 0);
                        if (a != 0) {
                          context
                              .read<OrderVariation>()
                              .tempSubGroupVariation[widget.sku] = a;
                        } else {
                          context
                              .read<OrderVariation>()
                              .tempSubGroupVariation
                              .remove(widget.sku);
                        }
                      },
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintText: widget.sku.primaryUnit,
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.3)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black.withOpacity(0.1)),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: TextField(
                        controller: alternative,
                        cursorWidth: 1,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.blue,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        onChanged: (input) {
                          int a = (int.tryParse(primary.text) ?? 0) *
                                  widget.sku.cf +
                              (int.tryParse(alternative.text) ?? 0);
                          if (a != 0) {
                            context
                                .read<OrderVariation>()
                                .tempSubGroupVariation[widget.sku] = a;
                          } else {
                            context
                                .read<OrderVariation>()
                                .tempSubGroupVariation
                                .remove(widget.sku);
                          }
                        },
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: widget.sku.secondaryUnit,
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.3)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
