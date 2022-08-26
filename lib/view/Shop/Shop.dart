import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/view/Profile/profile.dart';
import 'package:mfp_app/view/Search/search.dart';

class ShopSC extends StatefulWidget {
  // DoingSC({Key? key}) : super(key: key);
   bool taptoload;

   ShopSC({Key key, this.taptoload}) : super(key: key);

  @override
  _ShopSCState createState() => _ShopSCState();
}

class _ShopSCState extends State<ShopSC> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  var token;

  var userid;

  var userimageUrl;

  var datagetuserprofile;

  var image;

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      Api.gettoke().then((value) => value({
            token = value,
          }));

      Api.getmyuid().then((value) => ({
            setState(() {
              userid = value;
            }),
            Api.getuserprofile("$userid").then((responseData) async => ({
                  if (responseData.statusCode == 200)
                    {
                      datagetuserprofile = jsonDecode(responseData.body),
                      setState(() {
                        image = datagetuserprofile["data"]["imageURL"];
                      }),
                    }
                })),
          }));
      Api.getimageURL().then((value) => ({
            setState(() {
              userimageUrl = value;
            }),
          }));
    });
  }

  Widget topImage(String image) {
    return Container(
      height: 250.0,
      child: FullScreenWidget(
        child: Center(
          child: Hero(
            tag: "smallImage",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget smallImage(String image) {
    return Container(
      height: 250.0,
      width: MediaQuery.of(context).size.width / 2.0,
      child: FullScreenWidget(
        child: Center(
          child: Hero(
            tag: "smallImage",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _goToElement(int index) {
    _trackingScrollController.animateTo(
        (100.0 *
            index), // 100 is the height of container and index of 6th element is 5
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
    setState(() {
      widget.taptoload = false;
    });
  }
  @override
  Widget build(BuildContext context) {
     if (widget.taptoload == true) {
      _goToElement(0);
    }
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(
                child: CustomScrollView(
                  controller: _trackingScrollController,
                  slivers: [
                    primaryAppBar(
                        context,
                        token,
                        userid,
                        image,
                        Search(),
                        ProfileSc(
                          userid: userid,
                          token: token,
                        )),

                    ///-----------APPBAR-----------------//
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                topImage('images/MFP-101.png'),
                                Container(
                                  color: Colors.grey[200],
                                  child: Padding(
                                      padding: const EdgeInsets.all(25),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '200 บาท',
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize:
                                                      AppTheme.BodyTextSize24,
                                                  fontFamily: AppTheme
                                                      .FontAnakotmaiBold,
                                                  color: MColors.primaryColor,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'เสื้อยืดคอกลมลายโลโก้ สีน้ำเงินเข้ม',
                                              style: TextStyle(
                                                  fontSize:
                                                      AppTheme.BodyTextSize,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: AppTheme
                                                      .FontAnakotmaiLight,
                                                  color: MColors.textDark,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                        ],
                                      )),
                                )
                              ],
                            ),
                          ),
                          //-----------------------
                          Container(
                            child: Column(
                              children: [
                                Row(children: [
                                  smallImage('images/MFP-101-IMG_8927.jpg'),
                                  smallImage('images/MFP-101-IMG_8954.jpg'),
                                ]),
                                Container(
                                  color: Colors.grey[200],
                                  child: Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        color: Colors.grey[200],
                                        child: Padding(
                                          padding: const EdgeInsets.all(25.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                '150 บาท',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize:
                                                        AppTheme.BodyTextSize24,
                                                    fontFamily: AppTheme
                                                        .FontAnakotmaiBold,
                                                    color: MColors.primaryColor,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              Text(
                                                'หมวกปักลายโลโก้',
                                                style: TextStyle(
                                                    fontSize:
                                                        AppTheme.BodyTextSize,
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: AppTheme
                                                        .FontAnakotmaiLight,
                                                    color: MColors.textDark,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.0,
                                        color: Colors.grey[200],
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 25.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                '79 บาท',
                                                maxLines: 1,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize:
                                                        AppTheme.BodyTextSize24,
                                                    fontFamily: AppTheme
                                                        .FontAnakotmaiBold,
                                                    color: MColors.primaryColor,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              AutoSizeText(
                                                'ถุงผ้าพิมพ์ลาย',
                                                maxLines: 1,
                                                textAlign: TextAlign.left,
                                                minFontSize: 14,
                                                maxFontSize: 18,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize:
                                                        AppTheme.BodyTextSize,
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: AppTheme
                                                        .FontAnakotmaiLight,
                                                    color: MColors.textDark,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          //---------------------
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    smallImage('images/MFP-101-IMG_9030.jpg'),
                                    smallImage('images/MFP-101-IMG_9078.jpg'),
                                  ],
                                ),
                                Container(
                                  color: Colors.grey[200],
                                  child: Row(
                                    children: [
                                      Container(
                                        color: Colors.grey[200],
                                        child: Padding(
                                          padding: const EdgeInsets.all(25.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                '500 บาท',
                                                maxLines: 1,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize:
                                                        AppTheme.BodyTextSize24,
                                                    fontFamily: AppTheme
                                                        .FontAnakotmaiBold,
                                                    color: MColors.primaryColor,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              Text(
                                                'เนคไทปักโลโก้',
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize:
                                                        AppTheme.BodyTextSize,
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: AppTheme
                                                        .FontAnakotmaiLight,
                                                    color: MColors.textDark,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        color: Colors.grey[200],
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 25.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                '250 บาท',
                                                maxLines: 1,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize:
                                                        AppTheme.BodyTextSize24,
                                                    fontFamily: AppTheme
                                                        .FontAnakotmaiBold,
                                                    color: MColors.primaryColor,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              Text(
                                                'เสื้อโปโลสีน้ำเงินเข้ม',
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize:
                                                        AppTheme.BodyTextSize,
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: AppTheme
                                                        .FontAnakotmaiLight,
                                                    color: MColors.textDark,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          //-------------------

                          Container(
                            child: Column(
                              children: [
                                topImage('images/MFP-101-IMG_9009.jpg'),
                                Container(
                                  color: Colors.grey[200],
                                  child: Padding(
                                      padding: const EdgeInsets.all(25),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '79 บาท',
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize:
                                                      AppTheme.BodyTextSize24,
                                                  fontFamily: AppTheme
                                                      .FontAnakotmaiBold,
                                                  color: MColors.primaryColor,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'แมสก์พร้อมสายคล้องคอปรับได้',
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize:
                                                      AppTheme.BodyTextSize,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: AppTheme
                                                      .FontAnakotmaiLight,
                                                  color: MColors.textDark,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                        ],
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///-----------SliverListปิดไปก่อนได้----------------//
                  ],
                ),
              ),
              Row(children: [
                // First child is TextInput
                Expanded(
                    child: Container(
                  height: 70,
                  color: MColors.primaryColor,
                  child: TextButton(
                    onPressed: () async {
                      HapticFeedback.lightImpact();

                      //('กด');
                      if (Platform.isAndroid) {
                        String uri = 'https://line.me/R/ti/p/@mfpshop';
                        if (await canLaunch(uri)) {
                          await launch(uri);
                        } else {
                          throw ScaffoldMessenger.of(context)
                              .showSnackBar(new SnackBar(
                            content: Text("ยังไม่ได้ลงLINE"),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                          ));
                        }
                      } else if (Platform.isIOS) {
                        // iOS
                        String uri = 'https://line.me/R/ti/p/@mfpshop';
                        if (await canLaunch(uri)) {
                          await launch(uri);
                        } else {
                          throw ScaffoldMessenger.of(context)
                              .showSnackBar(new SnackBar(
                            content: Text("ยังไม่ได้ลงLINE"),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                          ));
                        }
                      }
                    },
                    child: Text(
                      'สั่งสินค้าก้าวไกล',
                      style: TextStyle(
                        color: MColors.primaryWhite,
                        fontSize: AppTheme.BodyTextSize,
                        fontFamily: AppTheme.FontAnakotmaiLight,
                      ),
                    ),
                  ),
                )),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
