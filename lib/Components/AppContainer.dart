import 'package:flutter/material.dart';
class AppContainer{
  BoxDecoration appBoxDecoration({Color?  boxColor, double ? borderRadius,List <BoxShadow> ? boxShadow }){
    return BoxDecoration(color : boxColor ?? Colors.white ,borderRadius: BorderRadius.circular(borderRadius ?? 12),
      boxShadow: boxShadow
    );
  }

  BoxShadow appBoxShadow( ){
    return BoxShadow(color:Colors.black.withOpacity(0.1), offset: Offset(0,2), blurRadius: 2,  );
  }

}
