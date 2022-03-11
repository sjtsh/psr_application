import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/OrderScreen.dart';
import 'package:psr_application/StateManagement/OrderScreenManagement.dart';

import 'NoOrder/NoOrderScreen.dart';

class SubGroupListScreen extends StatelessWidget {
  const SubGroupListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color(0Xfff2f2f2),
          child: Column(
            children: [
              Container(
                height: 50,
                color: Colors.white,
                child: Center(
                    child: Text("Take Order", style: TextStyle(fontSize: 20))),
              ),
              Expanded(
                child: ListView(
                  children: context
                      .watch<OrderScreenManagement>()
                      .data
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.75),
                                    Colors.transparent
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                              color: Colors.red,
                            ),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${e.name} ",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  "- ${e.productName}",
                                                  style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "${e.skus.length} SKUs available",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(child: Container()),
                                        PopupMenuButton(
                                          icon: Icon(
                                            Icons.menu,
                                            color: Colors.white,
                                          ),
                                          itemBuilder: (BuildContext context) {
                                            return [
                                              PopupMenuItem(
                                                child: Text(
                                                  "Archive",
                                                ),
                                              )
                                            ];
                                          },
                                        ),
                                      ],
                                    ),
                                    Expanded(child: Container()),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (_) {
                                                  return OrderScreen();
                                                }));
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 150,
                                                color: Colors.white,
                                                child: const Center(
                                                  child: Text("Take Order"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) {
                                                      return NoOrderScreen();
                                                    },
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 150,
                                                color: Colors.white,
                                                child: const Center(
                                                  child: Text("No Order"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
