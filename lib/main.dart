import 'package:flutter/material.dart';

import 'Screens/classy.dart';
import 'Screens/home.dart';
import 'Screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.route,
      routes: {
        Home.id: (context) => Home(),
        Classy.id: (context) => Classy(),
        SplashScreen.route: (context) => SplashScreen()
      },
    );
  }
}
