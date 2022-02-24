import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/ImagePreviewScreen.dart';

import '../../StateManagement/LogInManagement.dart';

class ShopClosedScreen extends StatefulWidget {
  const ShopClosedScreen({Key? key}) : super(key: key);

  @override
  State<ShopClosedScreen> createState() => _ShopClosedScreenState();
}

class _ShopClosedScreenState extends State<ShopClosedScreen> {
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
        context.read<LogInManagement>().cameras[0], ResolutionPreset.max);
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!(controller?.value.isInitialized ?? false)) {
      return Container();
    }
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, Orientation orientation) {
        print(orientation);
          return CameraPreview(
            controller!,
            child: orientation == Orientation.landscape
                ? Column(
                    children: [
                      Expanded(
                        child: Align(
                        alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffF1F2F6),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                    "Please set the orientation to landscape first"),
                              ),
                            ),
                          ),
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
                                    controller?.takePicture().then((XFile value) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) {
                                            return ImagePreviewScreen(value.path);
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
                                )),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF1F2F6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                "Please set the orientation to landscape first"),
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
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
                                    controller?.takePicture().then((XFile value) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) {
                                            return ImagePreviewScreen(value.path);
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
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        }
      ),
    );
  }
}
