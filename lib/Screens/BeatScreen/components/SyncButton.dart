import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../../StateManagement/DataManagement.dart';

class SyncButton extends StatefulWidget {
  @override
  State<SyncButton> createState() => _SyncButtonState();
}

class _SyncButtonState extends State<SyncButton> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  bool condition = true;
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );
  SuperTooltip tooltip = SuperTooltip(
    popupDirection: TooltipDirection.down,
    content: Container(),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void close() {
    if (tooltip.isOpen) {
      tooltip.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffF1F2F6),
      child: InkWell(
        onTap: () async {
          tooltip = SuperTooltip(
              arrowTipDistance: 0,
              borderColor: Colors.transparent,
              shadowColor: Colors.black.withOpacity(0.2),
              content: SizedBox(
                height: 80,
                width: 190,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.sync),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Last Sync Date",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 12,
                                  decoration: TextDecoration.none,
                                  fontFamily: "lato"),
                            ),
                            FutureBuilder(
                              future: SharedPreferences.getInstance(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  SharedPreferences prefs = snapshot.data;
                                  return Text(
                                    prefs.getString("lastUpdated") ??
                                        "Not synced yet",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        decoration: TextDecoration.none,
                                        fontFamily: "lato"),
                                  );
                                }
                                return Text(
                                  "Not synced yet",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      decoration: TextDecoration.none,
                                      fontFamily: "lato"),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 3,
                                offset: Offset(0, 2))
                          ],
                        ),
                        child: !condition
                            ? Container(
                                alignment: Alignment.center,
                                height: 30,
                                color: Color(0xff60D74D),
                                child: Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : Material(
                                color: Colors.white,
                                child: InkWell(
                                  onTap: () async {
                                    tooltip.close();
                                    setState(() {
                                      condition = false;
                                    });

                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString(
                                        "lastUpdated",
                                        NepaliDateTime.now()
                                            .toString()
                                            .substring(0, 19));
                                    try {
                                      await context.read<DataManagement>().syncAll(context);
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("Unsuccessful")));
                                      print(e);
                                    }
                                    setState(() {
                                      condition = true;
                                    });
                                    tooltip.show(context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    color: Color(0xff60D74D),
                                    child: Builder(builder: (context) {
                                      return Text(
                                        "SYNC NOW",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "lato",
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              popupDirection: TooltipDirection.down);
          tooltip.show(context);
        },
        child: !condition
            ? RotationTransition(

                turns: _animation,
                child: const Icon(
                  Icons.sync,
                  color: Colors.blue,
                  size: 40,
                ),
              )
            : Icon(
                Icons.sync,
                color: Colors.black,
              ),
      ),
    );
  }
}
