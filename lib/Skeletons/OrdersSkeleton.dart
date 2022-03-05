import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrdersSkeleton extends StatelessWidget {
  const OrdersSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: List.generate(
            7,
            (index) => Shimmer(
                  gradient: LinearGradient(colors: [Colors.white, Colors.grey]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 12),
                    child: Container(
                      decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 12),
                              child: Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffEA47B2),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 10,
                                          width: 100,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.black.withOpacity(0.1),
                              thickness: 1,
                            ),
                            Column(
                              children: [
                                ["", ""],
                                ["", ""],
                              ]
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 10,
                                            width: 120,
                                            color: Colors.grey,
                                          ),
                                          Expanded(child: Container()),
                                          Container(
                                            height: 10,
                                            width: 50,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )).toList());
  }
}
