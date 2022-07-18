import 'package:budget_tracker/services/them_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeService>(
      create: (_) => ThemeService(),
      child: Builder(builder: (BuildContext context) {
        final themeService = Provider.of<ThemeService>(context);
        return MaterialApp(
          title: 'Tracker App',
          theme: ThemeData(
            // colorScheme from seed generate an entire system theme based
            // on MUI 3 from a single initial color
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.indigo,
              brightness:
                  themeService.darkTheme ? Brightness.dark : Brightness.light,
            ),
          ),
          home: const Home(),
        );
      }),
    );
  }
}
