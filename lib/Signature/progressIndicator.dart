
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';

import '../StateManagement/SignatureManagement.dart';

class ProgressIndicatorLast extends StatelessWidget {
  const ProgressIndicatorLast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 150,
              width: 150,
              child: LiquidCircularProgressIndicator(
                value: context.watch<SignatureManagement>().cir/100,
                // Defaults to 0.5.
                valueColor: AlwaysStoppedAnimation(Color(0xff9cd2f1)),
                // Defaults to the current Theme's accentColor.
                backgroundColor: Colors.white,
                // Defaults to the current Theme's backgroundColor.
                borderColor: Colors.blue,
                borderWidth: 5.0,
                direction: Axis.vertical,
                // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                center: Text("Sending Order \n ${context.watch<SignatureManagement>().cir.toStringAsFixed(0)}%", textAlign: TextAlign.center
                  ,),
              ),
            ),
          ),
          SizedBox(height:  30,),
          Text("Please be patient. \n This process may take some time.",textAlign: TextAlign.center, maxLines: 2,)
        ],
      )
    );
  }
}
