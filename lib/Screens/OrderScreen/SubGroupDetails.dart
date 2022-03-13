
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../StateManagement/OrderScreenManagement.dart';
import '../../apis/Entities/SKU.dart';
import '../../apis/Entities/SubGroup.dart';

class SubgroupDetails extends StatefulWidget {
  SKU sku;
  SubGroup subGroup;
  SubgroupDetails(this.sku, this.subGroup);

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
      primary.text = (context
          .read<OrderScreenManagement>()
          .singularOrder[widget.subGroup]?[widget.sku] ==
          null
          ? ""
          : context
          .read<OrderScreenManagement>()
          .singularOrder[widget.subGroup]![widget.sku]! ~/
          widget.sku.cf)
          .toString();
      alternative.text = (context
          .read<OrderScreenManagement>()
          .singularOrder[widget.subGroup]?[widget.sku] ==
          null
          ? ""
          : context
          .read<OrderScreenManagement>()
          .singularOrder[widget.subGroup]![widget.sku]! %
          widget.sku.cf)
          .toString();
    }
  @override
  Widget build(BuildContext context) {
    return    Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
        child: Column(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              [
                "ID:",
                "#SK${widget.sku.id.toString().padLeft(4, "0")}"
              ],
              ["Name:", widget.sku.name],
              ["MRP:", widget.sku.mrp],
              ["PTR:", widget.sku.ptr],
              ["CF:", widget.sku.cf],
            ]
                .map(
                  (e) => Row(
                children: [
                  Text(e[0].toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                  Expanded(child: Container()),
                  Text(e[1].toString(), style: TextStyle(
                      color: Colors.grey)
                  )
                ],
              ),
            )
                .toList(),

          ),
          SizedBox(height: 12,),

          Row(
            children: [
              Text("Quantity"),
              Expanded(child: Container()),
              Container(
                height: 30,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                  Border.all(color: Colors.black.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 5.0),
                  child:
                  TextField(
                    controller: primary,
                    cursorWidth: 1,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.blue,
                    onChanged: (text) {
                      int a = (int.tryParse(primary.text) ?? 0) *
                          widget.sku.cf +
                          (int.tryParse(alternative.text) ?? 0);
                      if (a != 0) {
                        if (context
                            .read<OrderScreenManagement>()
                            .singularOrder
                            .containsKey(widget.subGroup)) {
                          context
                              .read<OrderScreenManagement>()
                              .singularOrder[widget.subGroup]![
                          widget.sku] = a;
                        } else {
                          context
                              .read<OrderScreenManagement>()
                              .singularOrder[widget.subGroup] = {
                            widget.sku: a
                          };
                        }
                      } else {
                        context
                            .read<OrderScreenManagement>()
                            .singularOrder[widget.subGroup]
                            ?.remove(widget.sku);
                        if (context
                            .read<OrderScreenManagement>()
                            .singularOrder[widget.subGroup]
                            ?.keys
                            .isEmpty ??
                            false) {
                          context
                              .read<OrderScreenManagement>()
                              .singularOrder
                              .remove(widget.subGroup);
                        }
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
                      hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.3)),
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
              Container(
                height: 30,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border:
                  Border.all(color: Colors.black.withOpacity(0.1)),
                ),
                child: Center(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 5.0),
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
                          if (context
                              .read<OrderScreenManagement>()
                              .singularOrder
                              .containsKey(widget.subGroup)) {
                            context
                                .read<OrderScreenManagement>()
                                .singularOrder[widget.subGroup]![
                            widget.sku] = a;
                          } else {
                            context
                                .read<OrderScreenManagement>()
                                .singularOrder[widget.subGroup] = {
                              widget.sku: a
                            };
                          }
                        } else {
                          context
                              .read<OrderScreenManagement>()
                              .singularOrder[widget.subGroup]
                              ?.remove(widget.sku);
                          if (context
                              .read<OrderScreenManagement>()
                              .singularOrder[widget.subGroup]
                              ?.keys
                              .isEmpty ??
                              false) {
                            context
                                .read<OrderScreenManagement>()
                                .singularOrder
                                .remove(widget.subGroup);
                          }
                        }
                      },
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintText: widget.sku.secondaryUnit,
                        hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.3)),
                        border: InputBorder.none,
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
