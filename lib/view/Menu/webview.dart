import 'package:flutter/material.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewSc extends StatefulWidget {
  final String url;
  final String texttitle;
  WebviewSc({Key key, this.url, this.texttitle}) : super(key: key);

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
            title: Text(
              widget.texttitle == null ? "" : widget.texttitle,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: AppTheme.FontAnakotmaiMedium,
                  color: MColors.textDark),
            ),
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
