import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/Screen_view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final height = MediaQuery.sizeOf(context).height * 1;
    // ignore: unused_local_variable
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/splash_pic.png",
              fit: BoxFit.cover,
              width: width * 9,
              height: height * .5,
            ),
            SizedBox(
              height: height * .06,
            ),
            Text(
              'TOP HEDLINS',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
            ),
            SizedBox(
              height: height * .02,
            ),
            SpinKitChasingDots(
              color: Colors.blue,
              size: 40,
            )
          ],
        ),
      ),
    );
  }
}
