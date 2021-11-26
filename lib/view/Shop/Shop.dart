import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
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
                    primaryAppBar(context, token, userid, userimageUrl),

                    ///-----------APPBAR-----------------//
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => Confirmproduct()),
                              // );
                              print("กด");
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 250.0,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('images/MFP-101.png'),
                                        fit: BoxFit.fill,
                                      ),
                                      //shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey[200],
                                    child: Padding(
                                        padding: const EdgeInsets.all(25),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '200 บาท',
                                                  style: TextStyle(
                                                    fontSize:
                                                        AppTheme.BodyTextSize24,
                                                    fontFamily: AppTheme
                                                        .FontAnakotmaiBold,
                                                    color: MColors.primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'เสื้อยืดคอกลมลายโลโก้ สีน้ำเงินเข้ม',
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
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 250.0,
                                      width: MediaQuery.of(context).size.width /
                                          2.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              AssetImage('images/MFP-102.png'),
                                          fit: BoxFit.fill,
                                        ),
                                        //shape: BoxShape.circle,
                                      ),
                                    ),
                                    Container(
                                      height: 250.0,
                                      width: MediaQuery.of(context).size.width /
                                          2.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              AssetImage('images/MFP-102.png'),
                                          fit: BoxFit.fill,
                                        ),
                                        //shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  color: Colors.grey[200],
                                  child: Row(
                                    children: [
                                      Container(
                                        color: Colors.grey[200],
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: RichText(
                                            text: TextSpan(
                                              text: '150 บาท\n',
                                              style: TextStyle(
                                                fontSize:
                                                    AppTheme.BodyTextSize24,
                                                fontFamily:
                                                    AppTheme.FontAnakotmaiBold,
                                                color: MColors.primaryColor,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'หมวกปีกลายโลโก้',
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
                                      ),
                                      Container(
                                        color: Colors.grey[200],
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: RichText(
                                            text: TextSpan(
                                              text: '150 บาท\n',
                                              style: TextStyle(
                                                fontSize:
                                                    AppTheme.BodyTextSize24,
                                                fontFamily:
                                                    AppTheme.FontAnakotmaiBold,
                                                color: MColors.primaryColor,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'หมวกปีกลายโลโก้',
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
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
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
