import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newspaper/view/splash_screen.dart';
import 'package:newspaper/view/theme.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'models/categories_model.dart';
import 'models/favourite_model.dart';
import 'models/general_model.dart';
import 'models/news_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => news()),
        ChangeNotifierProvider(create: (_) => generalnews()),
        ChangeNotifierProvider(create: (_) => generacategories()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => favourite()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Theme Demo',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
        home: splash()
    );
  }
}

//testing github upload