import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/view/Today/post_details.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview_EmergencySC extends StatefulWidget {
  final String url;
  final String texttitle;
  final String checkurl;

  Webview_EmergencySC({Key key, this.url, this.texttitle, this.checkurl}) : super(key: key);

  @override
  _Webview_EmergencySCState createState() => _Webview_EmergencySCState();
}

class _Webview_EmergencySCState extends State<Webview_EmergencySC> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();
  bool isLoading = true;
  final _key = UniqueKey();
  Completer<WebViewController> _controller = Completer<WebViewController>();

  var token, userid;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      print('delayedgetpost');
      await Api.gettoke().then((value) => value({
            token = value,
            print('token$token'),
          }));
      await Api.getmyuid().then((value) => value({
            userid = value,
            print('token$userid'),
          }));
    });
    super.initState();
  }

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
          body: Stack(
            children: <Widget>[
              WebView(
                key: _key,
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                },
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                navigationDelegate: (action) {
                  if (action.url == action.url) {
                    // var str = action.url.toString();
                    var postid = action.url.toString().replaceAll(
                        "${widget.checkurl}", "");
                    // var start = "https://today.moveforwardparty.org/post";
                    // var end = "/";

                    // final startIndex = str.indexOf(start);
                    // final endIndex =
                    //     str.indexOf(end, startIndex + start.length);

                    // print(str.substring(startIndex + start.length, endIndex));
                    print('ใช่');
                    print(action.url);
                    print('replaceurl$postid');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return PostDetailsSC(
                            onfocus: false,
                            
                            postid: postid,
                          );
                        },
                      ),
                    );
                    return NavigationDecision.prevent;
                  } else {
                    return NavigationDecision.navigate;
                  }
                },
                debuggingEnabled: true,
                gestureNavigationEnabled: true,
              ),
              //           GestureDetector(
              //  onTap: (()=>print('กด '))),

              isLoading
                  ? LinearProgressIndicator(
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        MColors.primaryColor,
                      ),
                      value: 0.8,
                    )
                  : Stack(),
            ],
          ),
        ),
      ),
    );
  }
}
