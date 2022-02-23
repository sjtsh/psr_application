import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../StateManagement/LogIn.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: 30,
              ),
              SizedBox(
                width: 12,
              ),
              Stack(
                children: [
                  Container(
                    width: 150,
                    height: 5,
                    color: Colors.grey,
                  ),
                  AnimatedContainer(
                    width: 150 * (context.watch<LogIn>().loadingAt / 100),
                    height: 5,
                    color: Colors.orange,
                    duration: const Duration(milliseconds: 200),
                  ),
                ],
              ),
              SizedBox(
                width: 12,
              ),
              Text(context.watch<LogIn>().loadingText),
            ],
          ),
        ),
      ),
    );
  }
}
