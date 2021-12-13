import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/view/Menu/webview.dart';
import 'package:mfp_app/view/Profile/profile.dart';
import 'package:mfp_app/view/Search/search.dart';

class MenuSC extends StatefulWidget {
  // MenuSC({Key? key}) : super(key: key);

  @override
  _MenuSCState createState() => _MenuSCState();
}

class _MenuSCState extends State<MenuSC> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  var token;

  var userid;

  var userimageUrl;

  var datagetuserprofile;

  var image;

  String msg = "ยังไม่เปิดให้บริการ";

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

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: Text("Close"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text(msg),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
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
              SliverToBoxAdapter(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      ' ข้อมูลเกี่ยวกับพรรค',
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Anakotmai-Bold',
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: InkWell(
                  onTap: () async {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (BuildContext context) {
                      return WebviewSc(
                        url: "https://donation.moveforwardparty.org/donation/",
                      );
                    }));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: 100,
                    height: MediaQuery.of(context).size.height / 5.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ]),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 10,
                          right: 0,
                          child: Image.asset("images/Group 11904.png"),
                          width: 99,
                          height: 99,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 28, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'บริจาค',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Anakotmai-Bold',
                                    fontSize: 24),
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              Text(
                                'ซื้อสินค้าพรรคก้าวไกล สนับสนุนการ\nทำงานเพื่อประชาธิปไตย',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: AppTheme.SmallTextSize,
                                  fontFamily: AppTheme.FontAnakotmaiLight,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: InkWell(
                  onTap: () async {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (BuildContext context) {
                      return WebviewSc(
                        url: "https://www.moveforwardparty.org/about/",
                      );
                    }));
                  },
                  child: Container(
                    margin: EdgeInsets.all(14),
                    width: 100,
                    height: MediaQuery.of(context).size.height / 5.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: MColors.primaryBlue,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ]),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 10,
                          right: 0,
                          child: Image.asset("images/Group 11925.png"),
                          width: 99,
                          height: 99,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 28, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'เกี่ยวกับพรรค',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppTheme.FontAnakotmaiBold,
                                  fontSize: AppTheme.TitleTextSize,
                                ),
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              Text(
                                'ซื้อสินค้าพรรคก้าวไกล สนับสนุนการ\nทำงานเพื่อประชาธิปไตย',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppTheme.SmallTextSize,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: AppTheme.FontAnakotmaiLight,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      ' ข้อมูลเกี่ยวกับพรรค',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppTheme.FontAnakotmaiMedium,
                        fontSize: AppTheme.BodyTextSize16,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => showAlertDialog(context),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.grey[200],
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(1),
                                          blurRadius: 0.5,
                                          spreadRadius: 0.5,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "images/Group_11912.png",
                                          width: 65,
                                          height: 55,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'ช่องทางการติดต่อ',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MColors.primaryBlue,
                                              fontWeight: FontWeight.bold,
                                              fontFamily:
                                                  AppTheme.FontAnakotmaiBold,
                                              fontSize:
                                                  AppTheme.BodyTextSize16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () => showAlertDialog(context),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.grey[200],
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(1),
                                          blurRadius: 0.5,
                                          spreadRadius: 0.5,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "images/Group 11924.png",
                                          width: 65,
                                          height: 55,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'ร้องเรียน',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MColors.primaryBlue,
                                              fontWeight: FontWeight.bold,
                                              fontFamily:
                                                  AppTheme.FontAnakotmaiBold,
                                              fontSize:
                                                  AppTheme.BodyTextSize16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => showAlertDialog(context),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.grey[200],
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(1),
                                          blurRadius: 0.5,
                                          spreadRadius: 0.5,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "images/Group 11961.png",
                                          width: 65,
                                          height: 55,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'อาสาสมัคร',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MColors.primaryBlue,
                                              fontWeight: FontWeight.bold,
                                              fontFamily:
                                                  AppTheme.FontAnakotmaiBold,
                                              fontSize:
                                                  AppTheme.BodyTextSize16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () async {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (BuildContext context) {
                                    return WebviewSc(
                                      url:
                                          "https://www.moveforwardparty.org/person/parliament/",
                                    );
                                  }));
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.grey[200],
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(1),
                                          blurRadius: 0.5,
                                          spreadRadius: 0.5,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "images/Group 11962.png",
                                          width: 65,
                                          height: 55,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'บุคลากร',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MColors.primaryBlue,
                                              fontWeight: FontWeight.bold,
                                              fontFamily:
                                                  AppTheme.FontAnakotmaiBold,
                                              fontSize:
                                                  AppTheme.BodyTextSize16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
