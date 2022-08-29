import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mfp_app/Api/Api.dart';
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
  final String iconimage;

  Webview_EmergencySC(
      {Key key, this.url, this.texttitle, this.checkurl, this.iconimage})
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
      await Api.gettoke().then((value) => value({
            token = value,
          }));
      await Api.getmyuid().then((value) => value({
            userid = value,
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
            titleSpacing: 0.0,

            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                      "https://today-api.moveforwardparty.org/api${widget.iconimage}/image"),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    widget.texttitle == null ? "" : widget.texttitle,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppTheme.FontAnakotmaiLight,
                        color: MColors.textDark,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),

            leadingWidth: 50,
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
                  if (action.url.replaceAll(postid, "") == widget.checkurl) {
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

                    Platform.isAndroid
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostSearch(
                                      label: hashtag,
                                    )),
                          )
                        : hashtag == action.url
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
                    Platform.isAndroid
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profliess(
                                      id: page,
                                    )),
                          )
                        : page == action.url
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
                        : NavigationDecision.navigate;
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
