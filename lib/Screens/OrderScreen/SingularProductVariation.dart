import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SingularProductVariation extends StatelessWidget {
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
                  //  controller: widget._textEditingControllerPrimary,
                    cursorWidth: 1,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.blue,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
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
                  //  controller: widget._textEditingControllerSecondary,
                    cursorWidth: 1,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.blue,
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
