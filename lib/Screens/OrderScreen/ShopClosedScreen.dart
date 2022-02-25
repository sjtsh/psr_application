import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/ImagePreviewScreen.dart';
import 'package:psr_application/StateManagement/ShopClosedController.dart';

import '../../StateManagement/LogInManagement.dart';

class ShopClosedScreen extends StatefulWidget {
  const ShopClosedScreen({Key? key}) : super(key: key);

  @override
  State<ShopClosedScreen> createState() => _ShopClosedScreenState();
}

class _ShopClosedScreenState extends State<ShopClosedScreen> {
  @override
  Widget build(BuildContext context) {
    return (!(context
                .watch<ShopClosedController>()
                .controller
                ?.value
                .isInitialized ??
            false))
        ? Container()
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: WillPopScope(
              onWillPop: () {
                Navigator.pop(context);
                context.watch<ShopClosedController>().dispose();
                return Future.value(false);
              },
              child: Scaffold(
                body: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Expanded(
                        child: CameraPreview(
                            context.watch<ShopClosedController>().controller!,
                            child: context
                                            .watch<ShopClosedController>()
                                            .orientation ==
                                        NativeDeviceOrientation.landscapeLeft ||
                                    context
                                            .watch<ShopClosedController>()
                                            .orientation ==
                                        NativeDeviceOrientation.landscapeRight
                                ? Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: RotatedBox(
                                        quarterTurns: context
                                                    .watch<
                                                        ShopClosedController>()
                                                    .orientation ==
                                                NativeDeviceOrientation
                                                    .landscapeLeft
                                            ? 1
                                            : 3,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffF1F2F6)
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Please set the orientation to landscape first",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 30.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffF1F2F6)
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                                "Please set the orientation to landscape first"),
                                          ),
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                    ],
                                  )),
                      ),
                      Container(
                        height: 60,
                        color: Colors.black,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                )),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: context
                                                .watch<ShopClosedController>()
                                                .orientation ==
                                            NativeDeviceOrientation
                                                .landscapeLeft ||
                                        context
                                                .watch<ShopClosedController>()
                                                .orientation ==
                                            NativeDeviceOrientation
                                                .landscapeRight
                                    ? GestureDetector(
                                        onTap: () {
                                          print("clicked");
                                          context
                                              .read<ShopClosedController>()
                                              .controller
                                              ?.takePicture()
                                              .then((XFile value) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) {
                                                  return ImagePreviewScreen(
                                                      value.path);
                                                },
                                              ),
                                            );
                                          });
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2),
                                              shape: BoxShape.circle,
                                              color: Colors.black),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
