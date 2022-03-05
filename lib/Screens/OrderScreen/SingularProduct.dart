import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../StateManagement/OrderScreenManagement.dart';
import 'SingularProductHeader.dart';
import 'SingularProductVariation.dart';

class SingularProduct extends StatelessWidget {
  int index;

  SingularProduct(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpandablePanel(
        controller: context
            .read<OrderScreenManagement>()
            .items[index],
        collapsed: SingularProductHeader(
            index, context.watch<OrderScreenManagement>().data[index], false),
        expanded: Column(
          children: [
            Container(
              height: 5,
              color: Colors.green
            ),
            SingularProductHeader(index,
                context.watch<OrderScreenManagement>().data[index], true),
            Builder(
              builder: (context) {
                return Column(children: [
                  ListView.builder(
                    controller:
                        context.read<OrderScreenManagement>().controller,
                    shrinkWrap: true,
                    itemCount: context
                        .watch<OrderScreenManagement>()
                        .data[index]
                        .skus
                        .length,
                    itemBuilder: (_, a) => SingularProductVariation(context
                        .watch<OrderScreenManagement>()
                        .data[index]
                        .skus[a], context
                        .watch<OrderScreenManagement>()
                        .data[index]),
                  )
                ]);
              },
            ),
            Container(
              height: 5,
                color: Colors.green
            ),
          ],
        ),
      ),
    );
  }
}
