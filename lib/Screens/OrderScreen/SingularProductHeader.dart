import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/OrderScreenManagement.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';

class SingularProductHeader extends StatelessWidget {
  final int index;
  final SubGroup subgroup;

  SingularProductHeader(this.index, this.subgroup);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xfff2f2f2),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xfff2f2f2),
          border: Border(
            bottom: BorderSide(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/oats.jpg"),
                        fit: BoxFit.contain,
                      )),
                ),
              ),
            ),
            SizedBox(height: 12,),
            Text(
              subgroup.productName,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 20,
              ),
            ),
            SizedBox(height: 6,),
            Text(
              subgroup.name,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(height: 12,),
          ],
        ),
      ),
    );
  }
}
