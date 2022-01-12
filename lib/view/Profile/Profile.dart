import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/view/NavigationBar/nav_screen.dart';
import 'package:mfp_app/view/Search/search.dart';

class ProfileSc extends StatefulWidget {
  final String userid;
  final String userimageUrl;
  final String token;

  ProfileSc({Key key, this.userid, this.userimageUrl, this.token})
      : super(key: key);

  @override
  _ProfileScState createState() => _ProfileScState();
}

class _ProfileScState extends State<ProfileSc> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  var checktoken;

  var datagetuserprofile;

  var displayName1 = "";

  var gender;

  var firstName;

  var lastName;

  var id;

  var email = "";

  var image;

  var token;

  var mode;

  var userid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      //print('Futuredelayed');
      //--token
      token = await Api.gettoke();
      //('tokenhome$token');
      //--mode
      mode = await Api.getmodelogin();
      //('mode$mode');
      //--userid
      userid = await Api.getmyuid();
      //('userid$userid');
      //('''
        //  Logged in! 
        //  userid: $userid
        // token: $token
        //  mode: $mode
        //  ''');
      await Api.getuserprofile("${widget.userid}").then((responseData) => ({
            if (responseData.statusCode == 200)
              {
                datagetuserprofile = jsonDecode(responseData.body),
                setState(() {
                  displayName1 = datagetuserprofile["data"]["displayName"];
                  gender = datagetuserprofile["data"]["gender"];
                  firstName = datagetuserprofile["data"]["firstName"];
                  lastName = datagetuserprofile["data"]["lastName"];
                  id = datagetuserprofile["data"]["id"];
                  email = datagetuserprofile["data"]["email"];
                  image = datagetuserprofile["data"]["imageURL"];
                }),
                //('displayName1$displayName1'),
                //('gender$gender'),
                //('firstName$firstName'),
                //('lastName$lastName'),
                //('id$id'),
                //('email$email'),
                //('${datagetuserprofile["data"]["username"]}'),
              }
          }));
    });
  }

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return displayName1 == ""? Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                color: MColors.primaryColor,
              ),
            ))
        :  SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              body: CustomScrollView(
                controller: _trackingScrollController,
                slivers: [
                  primaryAppBar(context, widget.token, widget.userid, image,
                      Search(), null),
                  SliverToBoxAdapter(
                      child: Divider(
                    color: Colors.transparent,
                    height: 3,
                    thickness: 6.0,
                  )),
                  SliverToBoxAdapter(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 5.5,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 2.0, left: 25.0),
                                child: CircleAvatar(
                                  radius: 42.0,
                                  backgroundImage: image == ""
                                      ? NetworkImage(
                                          'https://via.placeholder.com/150')
                                      : NetworkImage(
                                          'https://today-api.moveforwardparty.org/api$image/image'),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 38.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      displayName1,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: AppTheme.BodyTextSize,
                                          fontFamily:
                                              AppTheme.FontAnakotmaiMedium,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          email,
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15.5,
                                            fontFamily:
                                                AppTheme.FontAnakotmaiLight,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        // mode == "FB"
                                        //     ? Container(
                                        //         color: MColors.textDark,
                                        //         child: Image.asset(
                                        //           'images/facebook.png',
                                        //           width: 20,
                                        //           height: 20,
                                        //         ))
                                        //     : Container(),
                                        // mode == "EMAIL"
                                        //     ? Container(
                                        //         decoration: BoxDecoration(
                                        //             border: Border.all(
                                        //           color: MColors.primaryWhite,
                                        //         )),
                                        //         child: Image.asset(
                                        //           'images/Email.png',
                                        //           width: 20,
                                        //           height: 20,
                                        //         ))
                                        //     : Container(),
                                        //  mode=="EMAIL"?   Container(
                                        // color: MColors.textDark,
                                        // child: Image.asset('images/twitter.png',width: 20,height: 20,))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 28.0,
                            color: primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Divider(
                    color: Colors.transparent,
                    height: 3,
                    thickness: 6.0,
                  )),
                  SliverToBoxAdapter(
                      child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(top: 18.0, left: 25.0),
                      child: Text(
                        'เพจที่ดูแล',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: AppTheme.BodyTextSize,
                          fontFamily: AppTheme.FontAnakotmaiMedium,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )),
                  SliverToBoxAdapter(
                    child: Center(
                      child: Container(
                        height: 150,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(top: 18.0, left: 30.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Column(
                                      children: [],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 36.0,
                                          backgroundImage: NetworkImage(
                                              'https://via.placeholder.com/150'),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            'สร้างเพจ',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: AppTheme.SmallTextSize,
                                              fontFamily:
                                                  AppTheme.FontAnakotmaiLight,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Divider(
                    color: Colors.transparent,
                    height: 3,
                    thickness: 6.0,
                  )),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 60.0,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 2.0, left: 25.0),
                            child: Text(
                              'สมาชิกพรรค',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: AppTheme.BodyTextSize,
                                fontFamily: AppTheme.FontAnakotmaiMedium,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          Text(
                            'ยังไม่ได้เป็นสมาชิก',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: AppTheme.BodyTextSize,
                              fontFamily: AppTheme.FontAnakotmaiMedium,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4, right: 10.0),
                            child: Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 18.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Divider(
                    color: Colors.transparent,
                    height: 3,
                    thickness: 6.0,
                  )),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 60.0,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 2.0, left: 25.0),
                            child: Text(
                              'ประวัติการบริจาค',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: AppTheme.BodyTextSize,
                                fontFamily: AppTheme.FontAnakotmaiMedium,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4, right: 10.0),
                            child: Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 18.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Divider(
                    color: Colors.transparent,
                    height: 3,
                    thickness: 6.0,
                  )),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 60.0,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 2.0, left: 25.0),
                            child: Text(
                              'ติดตาม',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: AppTheme.BodyTextSize,
                                fontFamily: AppTheme.FontAnakotmaiMedium,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4, right: 10.0),
                            child: Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 18.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Divider(
                    color: Colors.transparent,
                    height: 3,
                    thickness: 6.0,
                  )),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 60.0,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 2.0, left: 25.0),
                            child: Text(
                              'ประวัติ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: AppTheme.BodyTextSize,
                                fontFamily: AppTheme.FontAnakotmaiMedium,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4, right: 10.0),
                            child: Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 18.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Divider(
                    color: Colors.transparent,
                    height: 3,
                    thickness: 6.0,
                  )),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 60.0,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 2.0, left: 25.0),
                            child: Text(
                              'เชื่อมต่อ social media',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: AppTheme.BodyTextSize,
                                fontFamily: AppTheme.FontAnakotmaiMedium,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4, right: 10),
                            child: Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 18.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Divider(
                    color: Colors.transparent,
                    height: 3,
                    thickness: 6.0,
                  )),

                  widget.token == "" || widget.token == null
                      ? SliverToBoxAdapter(child: Container())
                      : SliverToBoxAdapter(
                          child: InkWell(
                            onTap: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SimpleDialog(
                                      title: Text('ออกจากระบบ'),
                                      children: <Widget>[
                                        SimpleDialogOption(
                                          onPressed: () async {
                                            await Api.logout();
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    CupertinoPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            NavScreen()),
                                                    (Route<dynamic> route) =>
                                                        false);
                                          },
                                          child: Text('ยืนยัน'),
                                        ),
                                        // SimpleDialogOption(
                                        //   onPressed: handleImageSelecting,
                                        //   child: Text('select a pic'),
                                        // ),
                                        SimpleDialogOption(
                                          child: Text('ยกเลิก'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              height: 60.0,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 2.0, left: 25.0),
                                    child: Text(
                                      'ออกจากระบบ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: AppTheme.BodyTextSize,
                                        fontFamily:
                                            AppTheme.FontAnakotmaiMedium,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4, right: 10),
                                    child: Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      size: 18.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  SliverToBoxAdapter(
                      child: Divider(
                    color: Colors.transparent,
                    height: 3,
                    thickness: 6.0,
                  )),
                  // SliverToBoxAdapter(
                  //     child: Container(
                  //   color: Colors.white,
                  //   height: 26.0,
                  // )),
                ],
              ),
            ),
          );
  }
}
