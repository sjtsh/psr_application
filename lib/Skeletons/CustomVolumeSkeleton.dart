import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomVolumeSkeleton extends StatelessWidget {
  const CustomVolumeSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(

      gradient: const LinearGradient(colors: [Colors.white, Colors.grey]),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 12.0, top: 6, right: 12.0, bottom: 12),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(height: 30,),
                ),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(height: 30,)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
