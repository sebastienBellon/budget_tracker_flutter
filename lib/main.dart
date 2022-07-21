// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:budget_tracker/services/theme_service.dart';

import 'screens/home.dart';
import 'view_models/budget_view_model.dart';
import 'services/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localStorageService = LocalStorageService();
  await localStorageService.initializeHive();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const MyApp({
    Key? key,
    required this.sharedPreferences,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeService>(
            create: (_) => ThemeService(sharedPreferences)),
        ChangeNotifierProvider<BudgetViewModel>(
            create: (_) => BudgetViewModel()),
      ],
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
