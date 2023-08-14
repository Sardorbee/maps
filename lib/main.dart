import 'package:dio_example/data/network/api.dart';
import 'package:dio_example/services/provider/db_provider.dart';
import 'package:dio_example/services/provider/map_provider.dart';
import 'package:dio_example/services/provider/tab_provider.dart';
import 'package:dio_example/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TabProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              MapProvider(apiService: ApiService(), context: context),
        ),
        ChangeNotifierProvider(
          create: (context) => DatabaseProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
