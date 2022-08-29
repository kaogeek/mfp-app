import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/model/user_page_model.dart';
import 'package:mfp_app/utils/app.size.config.dart';
import 'package:mfp_app/utils/app.style.config.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/view/NavigationBar/nav_screen.dart';
import 'package:mfp_app/view/Profile/Profliess.dart';
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

  var datapageuser;

  List<UserPageModel> userpageList = <UserPageModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      token = await Api.gettoke();

      mode = await Api.getmodelogin();

      userid = await Api.getmyuid();
      Api.getpageuser(token, userid).then((responseData) => ({
            if (responseData.statusCode == 200)
              {
                datapageuser = jsonDecode(responseData.body),
                print(datapageuser),
                for (Map i in datapageuser["data"])
                  {
                    setState(() {
                      userpageList.add(UserPageModel.fromJson(i));
                    }),
                  }
              }
          }));

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
              }
          }));
    });
  }

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  showAlertDialog(BuildContext context, String text, String text1, String text2,
      double width, double height) {
    // set up the buttons

    Dialog dialog = Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width / width,
        height: MediaQuery.of(context).size.height / height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [primaryColor, secondaryColor]),
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CircleAvatar(
                  backgroundColor: MColors.primaryBlue.withOpacity(.05),
                  radius: 25,
                  child: Image.asset(
                    "images/Group 11925.png",
                    fit: BoxFit.fill,
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: AutoSizeText(text1,
                    maxLines: 5,
                    minFontSize: 16,
                    maxFontSize: 18,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: MColors.primaryWhite,
                      fontSize: 16,
                      fontFamily: AppTheme.FontAnakotmaiMedium,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: AutoSizeText(text2,
                    maxLines: 8,
                    minFontSize: 16,
                    maxFontSize: 18,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: MColors.primaryWhite,
                      fontSize: 14,
                      fontFamily: AppTheme.FontAnakotmaiMedium,
                    )),
              ),
            ],
          ),
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return displayName1 == ""
        ? Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                color: MColors.primaryColor,
              ),
            ))
        : Container(
            color: Colors.white,
            child: SafeArea(
              bottom: false,
              child: Scaffold(
                backgroundColor: MColors.primaryWhite,
                body: CustomScrollView(
                  controller: _trackingScrollController,
                  slivers: [
                    primaryAppBar(context, widget.token, widget.userid, image,
                        Search(), null),
                    SliverToBoxAdapter(
                        child: Divider(
                      thickness: 1.0,
                    )),
                    SliverToBoxAdapter(
                      child: Container(
                          height: AppStyle(context).getHeight(percent: 13.5),
                          width: MediaQuery.of(context).size.width,
                          padding:
                              AppStyle(context).getEdgeInsetsFromRatio(all: 2),
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 35.0,
                                    backgroundImage: image == ""
                                        ? NetworkImage(
                                            'https://via.placeholder.com/150')
                                        : NetworkImage(
                                            'https://today-api.moveforwardparty.org/api$image/image'),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  const SizedBox(
                                    width: 15.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        displayName1,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: AppTheme.BodyTextSize,
                                          fontFamily:
                                              AppTheme.FontAnakotmaiMedium,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        email,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 15.5,
                                          fontFamily:
                                              AppTheme.FontAnakotmaiLight,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    size: 25.0,
                                    color: primaryColor,
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                    SliverToBoxAdapter(
                        child: Divider(
                      thickness: 1.0,
                    )),

                    SliverToBoxAdapter(
                      child: Center(
                        child: Container(
                          height: AppStyle(context).getHeight(percent: 22.0),
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.yellow,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  color: Colors.white,
                                  child: Text(
                                    'เพจที่ดูแล',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: AppTheme.BodyTextSize,
                                      fontFamily: AppTheme.FontAnakotmaiLight,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              userpageList.length != 0
                                  ? Container(
                                      margin: EdgeInsets.all(30),
                                      child: Center(
                                          child: Text(
                                        'ไม่มีเพจที่ดูแล',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily:
                                                AppTheme.FontAnakotmaiMedium),
                                      )),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [],
                                        ),
                                        // Container(
                                        //   child: Column(
                                        //     // mainAxisAlignment:
                                        //     //     MainAxisAlignment.center,
                                        //     // crossAxisAlignment:
                                        //     //     CrossAxisAlignment.center,
                                        //     children: [
                                        //       Padding(
                                        //         padding: const EdgeInsets.only(
                                        //             left: 10, right: 5),
                                        //         child: Stack(
                                        //           children: [
                                        //             FDottedLine(
                                        //               color: Colors.grey[300],
                                        //               height: 70.0,
                                        //               width: 70.0,
                                        //               strokeWidth: 2.0,
                                        //               dottedLength: 8.0,
                                        //               space: 2.0,

                                        //               /// Set corner
                                        //               corner:
                                        //                   FDottedLineCorner.all(50),
                                        //               child: Container(
                                        //                   width: 75,
                                        //                   height: 75,
                                        //                   decoration: BoxDecoration(
                                        //                       shape: BoxShape.circle),
                                        //                   child: Icon(
                                        //                     Icons.add,
                                        //                     size: 30,
                                        //                     color: Colors.grey[400],
                                        //                   )),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ),
                                        //       Padding(
                                        //         padding: const EdgeInsets.all(10.0),
                                        //         child: Text(
                                        //           'สร้างเพจ',
                                        //           style: TextStyle(
                                        //             color: Colors.black54,
                                        //             fontSize: AppTheme.SmallTextSize,
                                        //             fontFamily:
                                        //                 AppTheme.FontAnakotmaiLight,
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2),
                                          child: Container(
                                            height: AppStyle(context)
                                                .getHeight(percent: 15.7),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1,
                                            // color: Colors.black,
                                            child: ListView.builder(
                                                physics:
                                                    AlwaysScrollableScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: userpageList.length,
                                                itemBuilder: (
                                                  BuildContext context,
                                                  int index,
                                                ) {
                                                  final nDataList =
                                                      userpageList[index];
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Navigate.pushPage(
                                                          context,
                                                          Profliess(
                                                            id: nDataList
                                                                .page.id,
                                                          ));
                                                    },
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: 75,
                                                          height: 75,
                                                          decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .white),
                                                          child: ClipOval(
                                                            child: nDataList.page
                                                                            .imageUrl ==
                                                                        null ||
                                                                    nDataList
                                                                            .page
                                                                            .imageUrl ==
                                                                        ""
                                                                ? new Image
                                                                    .network(
                                                                    "https://www.pngfind.com/pngs/m/610-6104451_image-placeholder-png-user-profile-placeholder-image-png.png",
                                                                    width: 75,
                                                                    height: 75,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )
                                                                : Image.network(
                                                                    "https://today-api.moveforwardparty.org/api${nDataList.page.imageUrl}/image",
                                                                    width: 75,
                                                                    height: 75,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    loadingBuilder: (BuildContext
                                                                            context,
                                                                        Widget
                                                                            child,
                                                                        ImageChunkEvent
                                                                            loadingProgress) {
                                                                      if (loadingProgress ==
                                                                          null)
                                                                        return child;
                                                                      return Center(
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          color:
                                                                              MColors.primaryColor,
                                                                          value: loadingProgress.expectedTotalBytes != null
                                                                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                                                              : null,
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: 90,
                                                            child: Text(
                                                              nDataList
                                                                  .page.name,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: AppTheme
                                                                    .SmallTextSize,
                                                                fontFamily: AppTheme
                                                                    .FontAnakotmaiLight,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: Divider(
                      thickness: 1.0,
                    )),

                    SliverToBoxAdapter(
                      child: GestureDetector(
                        onTap: () => showAlertDialog(context, "พรรคก้าวไกล",
                            "ระบบอยู่ในระหว่างการพัฒนา", "", 1.5, 5.5),
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
                                    fontFamily: AppTheme.FontAnakotmaiLight,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Spacer(
                                flex: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Text(
                                  'ยังไม่ได้เป็นสมาชิก',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: AppTheme.BodyTextSize,
                                    fontFamily: AppTheme.FontAnakotmaiLight,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
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
                    ),
                    SliverToBoxAdapter(
                        child: Divider(
                      color: Colors.transparent,
                      height: 3,
                      thickness: 6.0,
                    )),
                    SliverToBoxAdapter(
                      child: GestureDetector(
                        onTap: () => showAlertDialog(context, "พรรคก้าวไกล",
                            "ระบบอยู่ในระหว่างการพัฒนา", "", 1.5, 5.5),
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
                                    fontFamily: AppTheme.FontAnakotmaiLight,
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
                    ),
                    SliverToBoxAdapter(
                        child: Divider(
                      color: Colors.transparent,
                      height: 3,
                      thickness: 6.0,
                    )),
                    SliverToBoxAdapter(
                      child: GestureDetector(
                        onTap: () => showAlertDialog(context, "พรรคก้าวไกล",
                            "ระบบอยู่ในระหว่างการพัฒนา", "", 1.5, 5.5),
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
                                    fontFamily: AppTheme.FontAnakotmaiLight,
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
                    ),
                    SliverToBoxAdapter(
                        child: Divider(
                      color: Colors.transparent,
                      height: 3,
                      thickness: 6.0,
                    )),
                    SliverToBoxAdapter(
                      child: GestureDetector(
                        onTap: () => showAlertDialog(context, "พรรคก้าวไกล",
                            "ระบบอยู่ในระหว่างการพัฒนา", "", 1.5, 5.5),
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
                                    fontFamily: AppTheme.FontAnakotmaiLight,
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
                    ),
                    SliverToBoxAdapter(
                        child: Divider(
                      color: Colors.transparent,
                      height: 3,
                      thickness: 6.0,
                    )),
                    SliverToBoxAdapter(
                      child: GestureDetector(
                        onTap: () => showAlertDialog(context, "พรรคก้าวไกล",
                            "ระบบอยู่ในระหว่างการพัฒนา", "", 1.5, 5.5),
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
                                    fontFamily: AppTheme.FontAnakotmaiLight,
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

                    widget.token == "" || widget.token == null
                        ? SliverToBoxAdapter(child: Container())
                        : SliverToBoxAdapter(
                            child: InkWell(
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        new CupertinoAlertDialog(
                                          title: new Text(
                                            "คุณต้องการออกจากระบบ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          actions: [
                                            CupertinoDialogAction(
                                              isDefaultAction: true,
                                              child: Text('ยกเลิก',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: AppTheme
                                                          .FontAnakotmaiLight,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: MColors
                                                          .primaryColor)),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                            CupertinoDialogAction(
                                              child: new Text('ยืนยัน',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: AppTheme
                                                          .FontAnakotmaiBold,
                                                      color: MColors
                                                          .primaryColor)),
                                              onPressed: () async {
                                                await Api.logout();
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        CupertinoPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                NavScreen()),
                                                        (Route<dynamic>
                                                                route) =>
                                                            false);
                                              },
                                            ),
                                          ],
                                        ));
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
                                              AppTheme.FontAnakotmaiLight,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 4, right: 10),
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
            ),
          );
  }
}
