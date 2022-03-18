import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/NoOrder/NoOrderScreen.dart';
import 'package:psr_application/Screens/OrderScreen/SubGroupDetails.dart';
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
                            color: Color(0Xfff2f2f2),
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
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   height: 200,
                          //   child: SingularProductHeader(index, subGroup),
                          // ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              color: const Color(0xffF6F6F6),
                              child: CarouselSlider.builder(
                                carouselController: controller,
                                options: CarouselOptions(
                                    initialPage: 0,
                                    height: height / 3,
                                    enableInfiniteScroll: false,
                                    reverse: false,
                                    viewportFraction: 0.6,
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
                                            image: DecorationImage(
                                              image:
                                                  AssetImage("assets/oats.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                            // color: Color(0xffE8F5E9),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 3,
                                                offset: Offset(0, 3),
                                              ),
                                            ]),
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
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: 70,
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
                                          height: 70,
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
                            thickness: 3,
                            height: 4,
                            color: Colors.grey,
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
