// import 'dart:async';
import 'package:flutter/material.dart';
// import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer(
    //     Duration(seconds: 3),
    //     () => Navigator.of(context).pushReplacement(MaterialPageRoute(
    //         builder: (BuildContext context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Color(0xFFfbab66), Color(0xFFf7418c)],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // backgroundColor: Colors.white,
        body: Center(child: Image.asset('assets/img/garbadgeandpeople1.png')),
      ),
    );
  }
}
