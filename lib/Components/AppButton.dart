import 'package:flutter/material.dart';
import 'package:psr_application/Components/AppColors.dart';
import 'package:psr_application/Components/AppContainer.dart';
import 'package:psr_application/Components/MyAppTextStyle.dart';
class AppButton extends StatelessWidget {
  Function ? OnButtonPressFunction;
  double ? borderRadius;
  Color ? buttonBgColor;
  String ?buttonText;
  AppButton({this.OnButtonPressFunction,this.borderRadius, this.buttonBgColor, required this.buttonText,} );

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: (){
        // TODO: on press function
      },
      child: Container(
        height: 50,
        width: 100,
        decoration: AppContainer().appBoxDecoration(boxColor: AppColors.bgColor),
        child: Center(child: Text(buttonText!, style: MyAppTextStyle().textStyle(appfontWeight: FontWeight.bold),)),
      ) ,
    );
  }
}
