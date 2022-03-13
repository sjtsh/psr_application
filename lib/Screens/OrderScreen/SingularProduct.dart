import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/NoOrder/NoOrderScreen.dart';
import 'package:psr_application/Screens/OrderScreen/SubGroupDetails.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';
import '../../StateManagement/OrderScreenManagement.dart';
import 'SingularProductHeader.dart';
import 'SingularProductVariation.dart';

class SingularProduct extends StatelessWidget {
  final SubGroup subGroup;

  SingularProduct(this.subGroup);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   height: 200,
            //   child: SingularProductHeader(index, subGroup),
            // ),
            Container(
              height: 400,
              child: Center(
                child: CarouselSlider.builder(
                  itemCount: subGroup.skus.length,
                  options: CarouselOptions(
                      height: 316,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      reverse: false,
                      viewportFraction: 0.7,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (int i, reason) {
                        //print(i);
                        context.read<OrderScreenManagement>().skuIndex = i;
                      }),
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/oats.jpg")));
                  },
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,
                        width: 60,
                        color: Colors.green,
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 12,
            ),
            Divider(
              height: 2,
              thickness: 4,
            ),
            SubgroupDetails(
                subGroup.skus[context.watch<OrderScreenManagement>().skuIndex],
                subGroup)
          ],
        ),
      ),
    );
  }
}
