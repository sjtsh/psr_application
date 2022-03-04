import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../StateManagement/OrderScreenManagement.dart';
import 'SingularProductHeader.dart';
import 'SingularProductVariation.dart';

class SingularProduct extends StatefulWidget {
  int index;

  SingularProduct(this.index);

  @override
  _SingularProductState createState() => _SingularProductState();
}

class _SingularProductState extends State<SingularProduct> {
  @override
  Widget build(BuildContext context) {
    // if (widget.currentlyExpanded == widget.item.subGroupID) {
    //   _expandableController.expanded = true;
    // } else {
    //   _expandableController.expanded = false;
    // }
   // return SingularProductHeader(widget.index);
    return Container(
      child: ExpandablePanel(
        controller: context
            .read<OrderScreenManagement>()
            .items[widget.index]
            .expandableController,
        collapsed: SingularProductHeader(widget.index),
        expanded: Column(
          children: [
            SingularProductHeader(widget.index),
            Builder(builder: (context) {
              return Column(children: [
                ListView.builder(
                 controller: context.read<OrderScreenManagement>().controller,
                  shrinkWrap: true,
                  itemCount: context.read<OrderScreenManagement>().data[widget.index].length ,itemBuilder: (_, index)=>
                    SingularProductVariation(),
                )

              ]
                  // allSKULocal
                  //     .where((element) =>
                  //         element.subGroupID == widget.item.subGroupID &&
                  //         !element.deactivated)
                  //     .map((item) => SingularProductVariation(
                  //         item,
                  //         widget._textEditingControllers[
                  //             allSKULocal.indexOf(item) * 2],
                  //         widget._textEditingControllers[
                  //             allSKULocal.indexOf(item) * 2 + 1],
                  //         widget.currentDistributor))
                  //     .toList(),
                  );
            }),
          ],
        ),
      ),
    );
  }
}
