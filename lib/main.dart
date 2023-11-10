import 'package:flutter/material.dart';
import 'package:taskuse/src/DB/provider/ManagerCache.dart';
import 'package:provider/provider.dart';
import 'package:taskuse/src/pages/home/homePage.dart';
import 'package:taskuse/src/pages/session/auth_formPage.dart';
import 'package:taskuse/src/utils/ColorPallete.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  ///await Firebase.initializeApp();
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
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            fontFamily:
                'Poppins', // Substitua 'YourFontFamily' pela fonte desejada
            fontSize: 16.0, // Tamanho de fonte desejado
            // Outras configurações de estilo, como fontWeight, fontStyle, etc.
          ),
        ),
        colorScheme:
            ColorScheme.fromSeed(seedColor: ColorsPalette.orangeMedium),
        useMaterial3: true,
      ),
      home:AuthForm(),
      debugShowCheckedModeBanner: false,
    );
  }
}
