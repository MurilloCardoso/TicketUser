import 'package:flutter/material.dart';
import 'package:taskuse/src/DB/provider/ManagerCache.dart';

import 'package:provider/provider.dart';
import 'package:taskuse/src/pages/home/homePage.dart';
import 'package:taskuse/src/utils/ColorPallete.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ManagerCache()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: ColorsPalette.orangeMedium),
        useMaterial3: true,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
