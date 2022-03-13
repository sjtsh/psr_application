import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/NoOrder/NoOrderScreen.dart';
import 'package:psr_application/Screens/OrderScreen/SubGroupDetails.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: [
          // Container(
          //   height: 200,
          //   child: SingularProductHeader(index, subGroup),
          // ),
          Container(
            // height: 300,
            // color: Color(0xffF6F6F6),
            child: CarouselSlider.builder(
              options: CarouselOptions(
                height: 350,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                viewportFraction: 0.8,
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (int index,i){
                  context.read<OrderScreenManagement>().skuIndex = index;
                }
              ),
             itemCount: subGroup.skus.length, itemBuilder: (BuildContext context, int index, int realIndex) {
              return SingularProductVariation(subGroup.skus[index], subGroup);
            },
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Wrap(
            direction: Axis.horizontal,
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.spaceAround,
            spacing: 12,
            children: List.generate(
              subGroup.skus.length,
              (index) => GestureDetector(
                onTap: () {
                  index = 0;
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: index == 0 ? Colors.black : Colors.transparent,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage("assets/oats.jpg"),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Divider(
            indent: 20,
            endIndent: 20,
            thickness: 3,
            height: 4,
            color: Colors.grey,
          ),
          SubgroupDetails(
              subGroup.skus[context.watch<OrderScreenManagement>().skuIndex],
              subGroup),
        ],
      ),
    );
  }
}
