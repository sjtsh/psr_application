import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../StateManagement/MapManagement.dart';

class MapSideUI extends StatelessWidget {
  const MapSideUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return    Positioned(
      top: height * 0.14,
      right: 12,
      child: Container(
        height: 100,
        width: 50,
        decoration:  BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(
                offset: Offset(0,2),
                blurRadius: 2,
                color: Colors.black.withOpacity(0.1)
            )]
        ),
        child: Column(
          children: [
            Expanded(child: Container()),
            IconButton(onPressed: () {  },
              icon:  Icon(Icons.info_outline,  size: 32,), color: Colors.blue,),
            Expanded(child: Container()),
            Divider(height: 1, thickness: 1,),
            Expanded(child: Container()),
            IconButton(onPressed: () {
              context.read<MapManagement>().getCurrentLocation();
            },
              icon:  Icon(Icons.home_filled,  size: 32,), color: Colors.blue,),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
