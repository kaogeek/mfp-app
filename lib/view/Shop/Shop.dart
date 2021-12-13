import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/view/Profile/profile.dart';
import 'package:mfp_app/view/Search/search.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopSC extends StatefulWidget {
  // ShopSC({Key? key}) : super(key: key);

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
    print('initState');
    super.initState();
    setState(() {
      Api.gettoke().then((value) => value({
            token = value,
            print('token$token'),
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
                        // displayName1 =
                        //     datagetuserprofile["data"]
                        //         ["displayName"];
                        // gender = datagetuserprofile["data"]
                        //     ["gender"];
                        // firstName = datagetuserprofile["data"]
                        //     ["firstName"];
                        // lastName = datagetuserprofile["data"]
                        //     ["lastName"];
                        // id = datagetuserprofile["data"]["id"];
                        // email =
                        //     datagetuserprofile["data"]["email"];
                        image = datagetuserprofile["data"]["imageURL"];
                      }),
                      print('image$image'),
                    }
                })),
            print('userid$userid'),
          }));
      Api.getimageURL().then((value) => ({
            setState(() {
              userimageUrl = value;
            }),
            print('userimageUrl$userimageUrl'),
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

  @override
  Widget build(BuildContext context) {
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
                        Search(
                          userid: userid,
                        ),
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
                                // Container(
                                //   height: 250.0,
                                //   width: double.infinity,
                                //   decoration: BoxDecoration(
                                //     image: DecorationImage(
                                //       image: AssetImage('images/MFP-101.png'),
                                //       fit: BoxFit.fill,
                                //     ),
                                //     //shape: BoxShape.circle,
                                //   ),
                                // ),
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
                                              style: TextStyle(
                                                fontSize:
                                                    AppTheme.BodyTextSize24,
                                                fontFamily:
                                                    AppTheme.FontAnakotmaiBold,
                                                color: MColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'เสื้อยืดคอกลมลายโลโก้ สีน้ำเงินเข้ม',
                                              style: TextStyle(
                                                fontSize: AppTheme.BodyTextSize,
                                                fontWeight: FontWeight.w300,
                                                fontFamily:
                                                    AppTheme.FontAnakotmaiLight,
                                                color: MColors.textDark,
                                              ),
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
                                Row(
                                  children: [
                                    smallImage('images/MFP-101-IMG_8927.jpg'),
                                    // Container(
                                    //   height: 250.0,
                                    //   width: MediaQuery.of(context).size.width /
                                    //       2.0,
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.white,

                                    //     image: DecorationImage(
                                    //       image: AssetImage(
                                    //           'images/MFP-101-IMG_8927.jpg'),
                                    //       fit: BoxFit.cover,
                                    //     ),
                                    //     //shape: BoxShape.circle,
                                    //   ),
                                    // ),
                                    smallImage('images/MFP-101-IMG_8954.jpg'),

                                    // Container(
                                    //   height: 250.0,
                                    //   width: MediaQuery.of(context).size.width /
                                    //       2.0,
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.white,

                                    //     image: DecorationImage(
                                    //       image: AssetImage(
                                    //           'images/MFP-101-IMG_8954.jpg'),
                                    //       fit: BoxFit.cover,
                                    //     ),
                                    //     //shape: BoxShape.circle,
                                    //   ),
                                    // ),
                                  ],
                                ),
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
                                                ),
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
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        color: Colors.grey[200],
                                        child: Padding(
                                          padding: const EdgeInsets.all(25.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                '79 บาท',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize:
                                                      AppTheme.BodyTextSize24,
                                                  fontFamily: AppTheme
                                                      .FontAnakotmaiBold,
                                                  color: MColors.primaryColor,
                                                ),
                                              ),
                                              Text(
                                                'ถุงผ้าพิมพ์ลาย',
                                                style: TextStyle(
                                                  fontSize:
                                                      AppTheme.BodyTextSize,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: AppTheme
                                                      .FontAnakotmaiLight,
                                                  color: MColors.textDark,
                                                ),
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

                                    // Container(
                                    //   height: 250.0,
                                    //   width: MediaQuery.of(context).size.width /
                                    //       2.0,
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.white,

                                    //     image: DecorationImage(
                                    //       image: AssetImage(
                                    //           'images/MFP-101-IMG_9030.jpg'),
                                    //       fit: BoxFit.scaleDown,
                                    //     ),
                                    //     //shape: BoxShape.circle,
                                    //   ),
                                    // ),
                                    smallImage('images/MFP-101-IMG_9078.jpg'),

                                    // Container(
                                    //   height: 250.0,
                                    //   width: MediaQuery.of(context).size.width /
                                    //       2.0,
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.white,

                                    //     image: DecorationImage(
                                    //       image: AssetImage(
                                    //           'images/MFP-101-IMG_9078.jpg'),
                                    //       fit: BoxFit.scaleDown,
                                    //     ),
                                    //     //shape: BoxShape.circle,
                                    //   ),
                                    // ),
                                  ],
                                ),
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
                                                '500 บาท',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize:
                                                      AppTheme.BodyTextSize24,
                                                  fontFamily: AppTheme
                                                      .FontAnakotmaiBold,
                                                  color: MColors.primaryColor,
                                                ),
                                              ),
                                              Text(
                                                'เนคไทปักโลโก้',
                                                style: TextStyle(
                                                  fontSize:
                                                      AppTheme.BodyTextSize,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: AppTheme
                                                      .FontAnakotmaiLight,
                                                  color: MColors.textDark,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        color: Colors.grey[200],
                                        child: Padding(
                                          padding: const EdgeInsets.all(25.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                '250 บาท',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize:
                                                      AppTheme.BodyTextSize24,
                                                  fontFamily: AppTheme
                                                      .FontAnakotmaiBold,
                                                  color: MColors.primaryColor,
                                                ),
                                              ),
                                              Text(
                                                'เสื้อโปโลสีน้ำเงินเข้ม',
                                                style: TextStyle(
                                                  fontSize:
                                                      AppTheme.BodyTextSize,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: AppTheme
                                                      .FontAnakotmaiLight,
                                                  color: MColors.textDark,
                                                ),
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
                                // Container(
                                //   height: 250.0,
                                //   width: double.infinity,
                                //   decoration: BoxDecoration(
                                //     image: DecorationImage(
                                //       image: AssetImage(
                                //           'images/MFP-101-IMG_9009.jpg'),
                                //       fit: BoxFit.fill,
                                //     ),
                                //     //shape: BoxShape.circle,
                                //   ),
                                // ),
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
                                              style: TextStyle(
                                                fontSize:
                                                    AppTheme.BodyTextSize24,
                                                fontFamily:
                                                    AppTheme.FontAnakotmaiBold,
                                                color: MColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'แมสก์พร้อมสายคล้องคอปรับได้',
                                              style: TextStyle(
                                                fontSize: AppTheme.BodyTextSize,
                                                fontWeight: FontWeight.w300,
                                                fontFamily:
                                                    AppTheme.FontAnakotmaiLight,
                                                color: MColors.textDark,
                                              ),
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

                      print('กด');
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
                        String uri = 'line://oaMessage/@mfpshop/สนใจ';
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
                        fontFamily: AppTheme.FontAnakotmaiMedium,
                      ),
                    ),
                  ),
                )),
                // Second child is button
              ]),
            ],
          ),
        ),
      ),
    );

    // Scaffold(
    //   appBar: AppBar(),

    //   body:

    // );
  }
}
