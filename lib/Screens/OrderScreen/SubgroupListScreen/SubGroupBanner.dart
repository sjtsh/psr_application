import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../StateManagement/NoOrderManagement.dart';
import '../../../StateManagement/OrderScreenManagement.dart';
import '../../../StateManagement/OrderVariation.dart';
import '../../../apis/Entities/SubGroup.dart';
import '../NoOrder/NoOrderScreen.dart';
import 'SingularProduct.dart';

class SubGroupBanner extends StatefulWidget {
  final int i;
  final SubGroup subgroup;

  SubGroupBanner(this.i, this.subgroup);

  @override
  State<SubGroupBanner> createState() => _SubGroupBannerState();
}

class _SubGroupBannerState extends State<SubGroupBanner> {
  // String message = "Order to be taken";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Builder(builder: (context) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.i % 2 == 0
                        ? "assets/cornflakes_banner-100.jpg"
                        : "assets/cornflakes_banner_2-100.jpg"),
                    fit: BoxFit.cover),
              ),
              height: 200,
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.black.withOpacity(0.75),
                  Colors.transparent
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                color: Colors.red,
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${widget.subgroup.name} ",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "- ${widget.subgroup.productName}",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${widget.subgroup.skus.length} SKUs available",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          Tooltip(
                            message: context
                                    .watch<OrderScreenManagement>()
                                    .singularOrder
                                    .containsKey(widget.subgroup)
                                ? "Order taken"
                                : context
                                        .watch<OrderScreenManagement>()
                                        .noOrderReasons
                                        .containsKey(widget.subgroup)
                                    ? "No Order Available"
                                    : context
                                            .watch<OrderScreenManagement>()
                                            .ownExistingStock
                                            .containsKey(widget.subgroup)
                                        ? "Own Stock"
                                        : context
                                                .watch<OrderScreenManagement>()
                                                .competitiveExistingStock
                                                .containsKey(widget.subgroup)
                                            ? "Competitive Stock"
                                            : "Order to be taken",
                            key: context
                                        .watch<OrderScreenManagement>()
                                        .singularOrder
                                        .containsKey(widget.subgroup) ||
                                    context
                                        .watch<OrderScreenManagement>()
                                        .noOrderReasons
                                        .containsKey(widget.subgroup) ||
                                    context
                                        .watch<OrderScreenManagement>()
                                        .ownExistingStock
                                        .containsKey(widget.subgroup) ||
                                    context
                                        .watch<OrderScreenManagement>()
                                        .competitiveExistingStock
                                        .containsKey(widget.subgroup)
                                ? null
                                : context
                                    .read<OrderScreenManagement>()
                                    .keys[widget.i],
                            verticalOffset: 10,
                            triggerMode: TooltipTriggerMode.tap,
                            showDuration: const Duration(seconds: 5),
                            child: Icon(
                              Icons.info,
                              color: context
                                          .watch<OrderScreenManagement>()
                                          .singularOrder
                                          .containsKey(widget.subgroup) ||
                                      context
                                          .watch<OrderScreenManagement>()
                                          .noOrderReasons
                                          .containsKey(widget.subgroup) ||
                                      context
                                          .watch<OrderScreenManagement>()
                                          .ownExistingStock
                                          .containsKey(widget.subgroup) ||
                                      context
                                          .watch<OrderScreenManagement>()
                                          .competitiveExistingStock
                                          .containsKey(widget.subgroup)
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<OrderVariation>()
                                      .tempSubGroupVariation = {};
                                  context
                                      .read<OrderVariation>()
                                      .tempSubGroupVariation
                                      .addAll(context
                                              .read<OrderScreenManagement>()
                                              .singularOrder[widget.subgroup] ??
                                          {});
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return SingularProduct(widget.subgroup);
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width: 150,
                                  color: Colors.white,
                                  child: const Center(
                                    child: Text("Take Order"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<NoOrderManagement>()
                                      .initializeNoOrder(
                                          widget.subgroup, context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return NoOrderScreen(
                                          widget.subgroup,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width: 150,
                                  color: Colors.white,
                                  child: const Center(
                                    child: Text("No Order"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
