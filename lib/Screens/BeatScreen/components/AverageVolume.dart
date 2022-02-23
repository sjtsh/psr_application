import 'package:flutter/material.dart';

class AverageVolume extends StatelessWidget {
  const AverageVolume({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: Color(0xffEFEFF0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                  children: ["W", "M"]
                      .map((e) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(e),
                                ),
                              ),
                            ),
                          ))
                      .toList()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: Color(0xffEFEFF0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                  ),
                  Text("data"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
