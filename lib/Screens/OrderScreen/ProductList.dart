import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'SingularProduct.dart';
import 'SingularProductHeader.dart';

class ProductList extends StatefulWidget {
  // final List<SubGroup> subGroupList;
  // final ScrollController _scrollController;
  // final List<TextEditingController> _textEditingControllers;
  // final Distributor currentDistributor;
  //
  // ProductList(
  //   this.subGroupList,
  //   this._scrollController,
  //   this._textEditingControllers,
  //   this.currentDistributor,
  // );

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int currentlyExpanded = 0;

  changeCurrentlyExpanded(int currentlyExpanded) {
    setState(() {
      if (this.currentlyExpanded == currentlyExpanded) {
        this.currentlyExpanded = 0;
      } else {
        this.currentlyExpanded = currentlyExpanded;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
     // controller: widget._scrollController,
      children:[
        // SingularProduct(index)
      // widget.subGroupList
      //     .map(
      //       (item) => SingularProduct(
      //         item,
      //         currentlyExpanded,
      //         changeCurrentlyExpanded,
      //         widget._textEditingControllers,
      //         widget.currentDistributor,
      //       ),
      //     )
      //     .toList(),
    ]
    );
  }
}
