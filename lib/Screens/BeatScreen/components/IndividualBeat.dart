import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/MapScreen/MapScreen.dart';
import 'package:psr_application/StateManagement/MapManagement.dart';

import '../../../apis/Entities/Beat.dart';

class IndividualBeat extends StatelessWidget {
  final Beat beat;

  IndividualBeat(this.beat);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
      ),
      child: GestureDetector(
        onTap: () {
          Geolocator.getCurrentPosition().then((event) {
            context
                .read<MapManagement>()
                .initializeMarkers(LatLng(event.latitude, event.longitude));
          });
          print("printing outlets");
          print(context
              .read<MapManagement>().allOutlets);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => MapScreen()));
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, -2),
                  blurRadius: 3,
                  spreadRadius: 3)
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(Icons.add),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(beat.name),
                      Text(
                        "30/50 outlets visited in last 15 days",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
