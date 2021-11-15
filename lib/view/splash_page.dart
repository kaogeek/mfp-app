import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/view/NavigationBar/nav_screen.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NavScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MColors.primaryColor,
        child: Column(
          children: [
            Expanded(
                child: Align(
                    alignment: FractionalOffset.center,
                    child: Image.asset(
                      'images/MFP-Logo-Horizontal-White-(min).png',
                      width: 230,
                      height: 80,
                    ))),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                child: Text(
                  '© 2021 พรรคก้าวไกล. ALL RIGHTS RESERVED.',
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: "Anakotmai-Light",
                    fontWeight: FontWeight.w300,
                    color: MColors.primaryWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
