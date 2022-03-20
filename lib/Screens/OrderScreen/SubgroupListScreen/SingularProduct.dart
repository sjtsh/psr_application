import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/NoOrder/NoOrderScreen.dart';
import 'package:psr_application/Screens/OrderScreen/SubgroupListScreen/SubGroupDetails.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';
import '../../../StateManagement/LogInManagement.dart';
import '../../../StateManagement/OrderScreenManagement.dart';
import '../../../StateManagement/OrderVariation.dart';

class SingularProduct extends StatelessWidget {
  final SubGroup subGroup;

  SingularProduct(
    this.subGroup,
  );

  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      double height =
          MediaQuery.of(context).size.height - kBottomNavigationBarHeight;
      return SafeArea(
        child: Scaffold(
          body: LayoutBuilder(builder: (context, BoxConstraints size) {
            print(height.toString() + " " + size.maxHeight.toString());
            return SingleChildScrollView(
              child: SizedBox(
                height: height,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.arrow_back_ios)),
                                Expanded(
                                  child: Center(
                                      child: Text("SKU Header",
                                          style: TextStyle(fontSize: 20))),
                                ),
                                Text(
                                  " ${context
                                      .watch<OrderScreenManagement>()
                                      .skuIndex +1 }/${subGroup.skus.length}"),
                                SizedBox(width: 12,)
                              ],
                            ),
                          ),
                          // Container(
                          //   height: 200,
                          //   child: SingularProductHeader(index, subGroup),
                          // ),
                          Expanded(
                            // flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              child: CarouselSlider.builder(
                                carouselController: controller,
                                options: CarouselOptions(
                                    initialPage: 0,
                                    height: 350,
                                    enableInfiniteScroll: false,
                                    reverse: false,
                                    viewportFraction: 0.8,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                    onPageChanged: (int index, i) {
                                      context
                                          .read<OrderScreenManagement>()
                                          .skuIndex = index;
                                    }),
                                itemCount: subGroup.skus.length,
                                itemBuilder: (BuildContext context, int index,
                                    int realIndex) {
                                  return Stack(
                                    clipBehavior: Clip.none,
                                    // overflow: Overflow.visible,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            image: DecorationImage(
                                              image:
                                                  AssetImage("assets/oats.jpg"),
                                              fit: BoxFit.contain,
                                            ),
                                            // color: Color(0xffE8F5E9),
                                        ),
                                      ),
                                      subGroup.skus[index].reward != 0
                                          ? Positioned(
                                              right: -6,
                                              top: -18,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xffDCF1F8),
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color:
                                                          Colors.greenAccent),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0, 2),
                                                        blurRadius: 2,
                                                        color: Colors.black
                                                            .withOpacity(0.1)),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    children: [
                                                      Text("⭐"),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(subGroup
                                                          .skus[index].reward
                                                          .toString()),
                                                    ],
                                                  ),
                                                ),
                                              ))
                                          : Container()
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: 80,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: ListView(
                              dragStartBehavior: DragStartBehavior.start,
                              controller: context
                                  .read<OrderScreenManagement>()
                                  .scrollController,
                              scrollDirection: Axis.horizontal,
                              children: [
                                SizedBox(
                                  width: 164,
                                ),
                                ...List.generate(subGroup.skus.length,
                                    (int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.animateToPage(index,
                                          duration: Duration(
                                            milliseconds: 500,
                                          ),
                                          curve: Curves.easeInOutCubic);
                                    },
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(6),
                                          height: 80,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: index ==
                                                      context
                                                          .watch<
                                                              OrderScreenManagement>()
                                                          .skuIndex
                                                  ? Colors.black
                                                  : Colors.transparent,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 3,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                            image: const DecorationImage(
                                              image:
                                                  AssetImage("assets/oats.jpg"),

                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        subGroup.skus[index].reward != 0
                                            ? Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: Colors
                                                                .transparent)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: Center(
                                                          child: Text("🎖️")),
                                                    )))
                                            : Container()
                                      ],
                                    ),
                                  );
                                }),
                                SizedBox(
                                  width: 164,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Divider(
                            indent: 20,
                            endIndent: 20,
                            thickness: 2,
                            height: 2,
                            color: Color(0xffc2c0c0),
                          ),
                          Expanded(
                            flex: 1,
                            child: PageView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: context
                                  .read<OrderScreenManagement>()
                                  .detailsController,
                              children: subGroup.skus
                                  .map((e) => SubgroupDetails(e, subGroup))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 12, left: 12, top: 8, bottom: 12),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: MaterialButton(
                          height: 50,
                          onPressed: () async {
                            if (context
                                .read<OrderVariation>()
                                .tempSubGroupVariation
                                .isNotEmpty) {
                              context
                                      .read<OrderScreenManagement>()
                                      .singularOrder[subGroup] =
                                  context
                                      .read<OrderVariation>()
                                      .tempSubGroupVariation;
                              context
                                      .read<OrderScreenManagement>()
                                      .singularOrder =
                                  context
                                      .read<OrderScreenManagement>()
                                      .singularOrder;
                              context.read<OrderScreenManagement>().validation(context);
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Please insert quantity")));
                            }
                          },
                          child: Center(
                            child: !context.watch<LogInManagement>().isLoading
                                ? const Text(
                                    "Confirm ",
                                    style: TextStyle(color: Colors.white),
                                  )
                                : CircularProgressIndicator(
                                    color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}
