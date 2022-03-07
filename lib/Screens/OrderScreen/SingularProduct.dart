import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';
import '../../StateManagement/OrderScreenManagement.dart';
import 'SingularProductHeader.dart';
import 'SingularProductVariation.dart';

class SingularProduct extends StatelessWidget {
  final int index;
  final SubGroup subGroup;

  SingularProduct(this.index, this.subGroup);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SingularProductHeader(index,
              subGroup),
          Builder(
            builder: (context) {
              if (context.watch<OrderScreenManagement>().currentlyExpanded ==
                  index) {
                return Column(children: [
                  ListView.builder(
                    controller:
                    context.read<OrderScreenManagement>().controller,
                    shrinkWrap: true,
                    itemCount: subGroup
                        .skus
                        .length,
                    itemBuilder: (_, a) => SingularProductVariation(
                        subGroup
                            .skus[a],
                        subGroup),
                  )
                ]);
              } else {
                return Container();
              }
            },
          ),
        ],
      )
    );
  }
}
