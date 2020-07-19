import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_deck/Screens/home.dart';

class SplashScreen extends StatefulWidget {
  static String route = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.of(context).pushReplacementNamed(Home.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Spacer(
                flex: 10,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: new Container(
                  child: Image.asset('assets/logo-white.jpg'),
                ),
                radius: 200,
              ),
              Spacer(
                flex: 10,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Made with ❤ in India',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
