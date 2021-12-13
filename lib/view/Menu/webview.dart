import 'package:flutter/material.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewSc extends StatefulWidget {
  final String url;
  WebviewSc({Key key, this.url}) : super(key: key);

  @override
  _WebviewScState createState() => _WebviewScState();
}

class _WebviewScState extends State<WebviewSc> {
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
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Text('บริจาค'),
          ),
          body: WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}
