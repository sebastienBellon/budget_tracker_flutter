import 'package:flutter/material.dart';

import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracker App',
      theme: ThemeData(
        // colorScheme from seed generate an entire system theme based
        // on MUI 3 from a single initial color
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      home: const Home(),
    );
  }
}
