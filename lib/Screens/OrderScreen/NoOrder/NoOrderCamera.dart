import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/ImagePreviewScreen.dart';
import 'package:psr_application/StateManagement/ShopClosedController.dart';


class NoOrderCamera extends StatefulWidget {
  @override
  State<NoOrderCamera> createState() => _NoOrderCamera();
}

class _NoOrderCamera extends State<NoOrderCamera> {
  @override
  Widget build(BuildContext context) {
    return (!(context
                .watch<ShopClosedController>()
                .controller
                ?.value
                .isInitialized ??
            false))
        ? Container(
            color: Colors.white,
          )
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
                        ),
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
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<ShopClosedController>()
                                        .controller
                                        ?.takePicture()
                                        .then((XFile value) {
                                      context
                                          .read<ShopClosedController>()
                                          .noOrderPhotoLocalUrl = value.path;
                                          Navigator.pop(context);
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),
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
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
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
