import 'package:flutter/material.dart';
import 'home.dart';
import 'classy.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Home.id,
      routes: {
        Home.id:(context) => Home(),
        Classy.id:(context) => Classy(),
      },
    );
  }
}