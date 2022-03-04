import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/OrderScreenManagement.dart';

class SingularProductHeader extends StatelessWidget {
  final int index;
  SingularProductHeader(this.index);

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
      Color(0xffC8E6C9),
      child: InkWell(
        onTap: () {
          //changeCurrentlyExpanded(subGroup.subGroupID);
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
                    // showDialog(
                    //   context: context,
                    //   builder: (_) {
                    //     return ProductDialogBox(subGroup);
                    //   },
                    // );
                  },
                  child: Row(
                    children: [
                      Stack(
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
                          Container(
                            height: 60,
                            width: 52,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.15),
                                shape: BoxShape.circle),
                            child: Center(
                              child: Icon(
                                Icons.zoom_in,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
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
                                Builder(
                                  builder: (context) {
                                   try {
                                    return Text(
                                      "Chiura"
,                                      // allProductGroupsLocal
                                      //     .firstWhere((element) =>
                                      //         subGroup.productGroupID ==
                                      //         element.productGroupID)
                                      //     .productGroupName,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 12,
                                      ),
                                    );
                                  }catch (e){
                                    return Text(
                                       "No name Found",
                                       style: TextStyle(
                                         color: Colors.black.withOpacity(0.5),
                                         fontSize: 12,
                                       ),
                                     );
                                   }
                                }
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                            Text(
                             " subGroup.subGroupName",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                       Icons.margin,
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
