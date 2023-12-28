import 'package:flutter/material.dart';
import 'package:movie/pages/main_page.dart';
import 'package:movie/pages/splash_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() {
  runApp(
    SplashPage(
      key: UniqueKey(),
      onInitializationComplete: () => runApp(
        ProviderScope(child:  MyApp(),)

      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movies",
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) =>  MainPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
