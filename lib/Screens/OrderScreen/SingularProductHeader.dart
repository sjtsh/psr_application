import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/OrderScreenManagement.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';

class SingularProductHeader extends StatelessWidget {
  final int index;
  final SubGroup subgroup;
  final bool isExpanded;

  SingularProductHeader(this.index, this.subgroup, this.isExpanded);

  @override
  Widget build(BuildContext context) {
    return Material(
      color:  Color(0xf2f2f2),
      child: InkWell(
        onTap: () {
          context.read<OrderScreenManagement>().makeExpansion(index);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
          ),
          child: Container(
            height: 60,
            margin: EdgeInsets.all(12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.1),
                        ),
                        child: Image.asset(
                          "assets/oats.jpg",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Builder(builder: (context) {
                                  try {
                                    return Text(
                                      subgroup.productName,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 12,
                                      ),
                                    );
                                  } catch (e) {
                                    return Text(
                                      "No name Found",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 12,
                                      ),
                                    );
                                  }
                                }),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                            Text(
                              subgroup.name,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isExpanded ? Icons.arrow_drop_up :Icons.arrow_drop_down,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      SizedBox(
                        width: 12,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
