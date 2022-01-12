import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/view/Profile/Profliess.dart';
import 'package:mfp_app/view/Search/post_search.dart';
import 'package:mfp_app/view/Today/post_details.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview_EmergencySC extends StatefulWidget {
  final String url;
  final String texttitle;
  final String checkurl;

  Webview_EmergencySC({Key key, this.url, this.texttitle, this.checkurl})
      : super(key: key);

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
      //('delayedgetpost');
      await Api.gettoke().then((value) => value({
            token = value,
            //('token$token'),
          }));
      await Api.getmyuid().then((value) => value({
            userid = value,
            //('token$userid'),
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
                navigationDelegate: (action) {
                  var postid = action.url
                      .toString()
                      .replaceAll("${widget.checkurl}", "");
                  var hashtag = Uri.decodeComponent(action.url)
                      .toString()
                      .replaceAll(
                          "${Uri.decodeComponent("https://today.moveforwardparty.org/search?hashtag=")}",
                          "");
                  var page = Uri.decodeComponent(action.url).toString().replaceAll(
                      "${Uri.decodeComponent("https://today.moveforwardparty.org/page/")}",
                      "");

                  print('page$page');

                  if (action.url.replaceAll(postid, "") == widget.checkurl) {
                    //('ใช่');
                    //(action.url);
                    //('replaceurl$postid');
                    Platform.isAndroid
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return PostDetailsSC(
                                  onfocus: false,
                                  postid: postid,
                                );
                              },
                            ),
                          )
                        : postid == action.url
                            ? () {}()
                            : Future.delayed(Duration.zero, () async {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return PostDetailsSC(
                                      onfocus: false,
                                      postid: postid,
                                    );
                                  },
                                ));
                              });

                    return Platform.isAndroid
                        ? NavigationDecision.prevent
                        : NavigationDecision.navigate;
                  }
                  if (Uri.decodeComponent(action.url).replaceAll(hashtag, "") ==
                      "https://today.moveforwardparty.org/search?hashtag=") {
                    //print('ใช่');
                    //(action.url);
                    //('replaceurl$postid');
                    Platform.isAndroid
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostSearch(
                                      label: hashtag,
                                    )),
                          )
                        : postid == action.url
                            ? () {}()
                            : Future.delayed(Duration.zero, () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostSearch(
                                            label: hashtag,
                                          )),
                                );
                              });

                    return Platform.isAndroid
                        ? NavigationDecision.prevent
                        : NavigationDecision.navigate;
                  }
                  if (Uri.decodeComponent(action.url).replaceAll(page, "") ==
                      "https://today.moveforwardparty.org/page/") {
                    //print('ใช่');
                    //(action.url);
                    //('replaceurl$postid');
                    Platform.isAndroid
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profliess(
                                      id: page,
                                    )),
                          )
                        : postid == action.url
                            ? () {}()
                            : Future.delayed(Duration.zero, () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profliess(
                                            id: page,
                                          )),
                                );
                              });

                    return Platform.isAndroid
                        ? NavigationDecision.prevent
                        : NavigationDecision.navigate;
                  } else {
                    return Platform.isAndroid
                        ? NavigationDecision.prevent
                        : NavigationDecision.prevent;
                  }
                },
                gestureNavigationEnabled: true,
              ),
              //           GestureDetector(
              //  onTap: (()=>//('กด '))),

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
