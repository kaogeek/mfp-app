

import 'package:flutter/material.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Detilmenu extends StatefulWidget {
  // DoingSC({Key? key}) : super(key: key);

  @override
  _DetilmenuState createState() => _DetilmenuState();
}

class _DetilmenuState extends State<Detilmenu> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(

            backgroundColor:Colors.white,
           iconTheme: IconThemeData(
    color: Colors.black, //change your color here
  ),
            title:Text('บริจาค'),
      
        
          ),
          body:WebView(
        initialUrl: "https://donation.moveforwardparty.org/donation/",
        javascriptMode: JavascriptMode.unrestricted,
      ),
        ),
      ),
    );

  }
}
