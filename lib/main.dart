import 'package:flutter/material.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/view/NavigationBar/nav_screen.dart';
import 'package:mfp_app/view/splash_page.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: AppTheme.textTheme,

    
        primarySwatch: Colors.blue,
      
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
    );
  }
}
