import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'StateManagement/CameraUpload.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => CameraUpload(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: context.watch<Counter>().currentScreenWidget,
          ),
          Container(
            height: 60,
            color: Colors.green,
            child: Row(
                children: [Icons.add, Icons.clear, Icons.cancel]
                    .asMap()
                    .entries
                    .map((e) => Expanded(
                            child: GestureDetector(
                          onTap: () => context.read<Counter>().increment(e.key),
                          child: Center(
                            child: Icon(
                              e.value,
                              color: context.watch<Counter>().currentScreen ==
                                      e.key
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                            ),
                          ),
                        )))
                    .toList()),
          ),
        ],
      ),
    );
  }
}
