import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../StateManagement/OrderScreenManagement.dart';

class SingularProductVariation extends StatefulWidget {
  int index;

  SingularProductVariation(this.index);

  @override
  State<SingularProductVariation> createState() =>
      _SingularProductVariationState();
}

class _SingularProductVariationState extends State<SingularProductVariation> {
  TextEditingController _textEditingController1 = TextEditingController();

  TextEditingController _textEditingController2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SKUStock mySKUStock;
    // SKU sku =
    //     allSKULocal.firstWhere((element) => element.SKUID == widget.item.SKUID);
    // try {
    //   mySKUStock = allSKUStocksLocal.firstWhere((element) =>
    //       element.distributorID == widget.currentDistributor.distributorID &&
    //       element.SKUID == widget.item.SKUID);
    // } catch (e) {
    //   mySKUStock = SKUStock(0, widget.item.SKUID,
    //       widget.currentDistributor.distributorID, meSOID!, false);
    // }
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        color: Color(0xffE8F5E9),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Text(
              "  widget.item.SKUName",
            ),
            Expanded(child: Container()),
            Container(
              height: 30,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black.withOpacity(0.1)),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: TextField(
                    controller: _textEditingController1,
                    cursorWidth: 1,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.blue,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    onChanged: (input) {
                      //first text editing controller (primary count)
                        context
                            .read<OrderScreenManagement>()
                            .singularOrder[widget.index.toString()] =
                            (int.tryParse(_textEditingController1.text) ?? 0) +
                                (int.tryParse(_textEditingController2.text) ??
                                    0) *
                                    2;
                      print(context
                          .read<OrderScreenManagement>()
                          .singularOrder[widget.index.toString()]);
                    },
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: "all uni",
                      // allUnitsLocal
                      //     .firstWhere((element) =>
                      //         element.unitID == sku.primaryUnitID)
                      //     .unitName,
                      hintStyle:
                      TextStyle(color: Colors.black.withOpacity(0.3)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 6,
            ),
            Container(
              height: 30,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: TextField(
                    controller: _textEditingController2,
                    cursorWidth: 1,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.blue,
                    onChanged: (text) {
                      context
                          .read<OrderScreenManagement>()
                          .singularOrder[widget.index.toString()] =
                          (int.tryParse(_textEditingController1.text) ?? 0) +
                              (int.tryParse(_textEditingController2.text) ??
                                  0) *
                                  2;
                      print(context
                          .read<OrderScreenManagement>()
                          .singularOrder[widget.index.toString()]);
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: "unit",
                      // allUnitsLocal
                      //     .firstWhere((element) =>
                      //         element.unitID == sku.alternativeUnitID)
                      //     .unitName,
                      border: InputBorder.none,
                      hintStyle:
                      TextStyle(color: Colors.black.withOpacity(0.3)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
