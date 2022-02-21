import 'package:flutter/material.dart';

class MyAppTextStyle {

  TextStyle textStyle(
      {double ? appfontSize, Color ?textColor, FontWeight ? appfontWeight}) {
    return TextStyle(fontSize: appfontSize ?? 14,
        color: textColor ?? Colors.black,
        fontWeight: appfontWeight ?? FontWeight.normal);
  }
}