import 'package:flutter/material.dart';

class IndividualBeat extends StatelessWidget {
  const IndividualBeat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
      ),
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
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text("Large Text"),
                    Text(
                      "30/50 outlets visited in last 15 days",
                      style: TextStyle(
                        color:
                        Colors.black.withOpacity(0.5),
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
    );
  }
}
