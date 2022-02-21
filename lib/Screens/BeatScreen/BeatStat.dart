import 'package:flutter/material.dart';

class BeatStat extends StatelessWidget {
  const BeatStat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text("SKU Target"),
        // Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: Container(
        //     height: 10,
        //     color: Colors.grey,
        //   ),
        // ),
        Text("Sales Target"),
        Row(
          children: [
            Text("0", style: TextStyle(fontSize: 10),),
            SizedBox(width: 6,),
            Expanded(
              child: Container(
                height: 10,
                child: Builder(builder: (context) {
                  double width = MediaQuery.of(context).size.width;
                  return Stack(
                    children: [
                      Container(
                        width: width,
                        color: Colors.grey,
                      ),
                      AnimatedContainer(
                        width: width * 0.5,
                        color: Colors.red,
                        duration: Duration(milliseconds: 200),
                      ),
                    ],
                  );
                }),
              ),
            ),
            SizedBox(width: 6,),
            Text("10000",  style: TextStyle(fontSize: 10),),
          ],
        )
      ],
    );
  }
}
