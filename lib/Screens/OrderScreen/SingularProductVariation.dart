import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';

import '../../StateManagement/OrderScreenManagement.dart';
import '../../apis/Entities/SKU.dart';

class SingularProductVariation extends StatefulWidget {
  SKU sku;
  SubGroup subGroup;

  SingularProductVariation(this.sku, this.subGroup);

  @override
  State<SingularProductVariation> createState() =>
      _SingularProductVariationState();
}

class _SingularProductVariationState extends State<SingularProductVariation> {
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
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
        color: Color(0xffE8F5E9),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.1),
                  image: DecorationImage(
                    image: AssetImage("assets/oats.jpg"),
                    fit: BoxFit.contain,
                  )),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ["id:", "#SK${widget.sku.id.toString().padLeft(4, "0")}"],
                      ["Name:", widget.sku.name],
                      ["MRP:", widget.sku.mrp],
                      ["PTR:", widget.sku.ptr],
                      ["CF:", widget.sku.cf],
                    ]
                        .map(
                          (e) => Row(
                            children: [
                              Text(e[0].toString()),
                              Expanded(child: Container()),
                              Text(e[1].toString())
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
                Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 6),
                          child: Text(
                            "Promoted",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 6),
                          child: Text("Trending",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 6),
                          child: Text("New",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10)),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                    SizedBox(width: 6,),
                      Expanded(
                        child: Container(
                          height: 30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.black.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: TextField(
                                controller: primary,
                                cursorWidth: 1,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.blue,
                                onChanged: (text) {
                                  context.read<OrderScreenManagement>().primary(text);
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
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Container(
                          height: 30,
                          width: double.infinity,
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
                                  context.read<OrderScreenManagement>().primary(input);
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
                      ),
                      SizedBox(width: 6,),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 12,
          ),
        ],
      ),
    );
  }
}
