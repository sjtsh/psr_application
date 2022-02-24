import 'package:flutter/material.dart';
class MapHeader extends StatelessWidget {
  const MapHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(
                offset: Offset(0,2),
                blurRadius: 2,
                color: Colors.black.withOpacity(0.1)
            )]
        ),
        child: Row(
          children: [
            SizedBox(width: 12,),
            Icon(Icons.arrow_back),
            Expanded(child: Container()),
            Text("Beat Name", style: TextStyle(fontSize:16 ),),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }
}
