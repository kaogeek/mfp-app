import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/animation/FadeAnimation.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/controller/emergency_provider.dart';
import 'package:mfp_app/controller/today_post_provider.dart';
import 'package:mfp_app/model/gallery.dart';
import 'package:mfp_app/model/postModel.dart';
import 'package:mfp_app/model/searchpostlistModel.dart';
import 'package:mfp_app/allWidget/CarouselsLoading.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/allWidget/fontsize.dart';
import 'package:mfp_app/allWidget/PostButton.dart';
import 'package:mfp_app/utils/app.size.config.dart';
import 'package:mfp_app/utils/app.style.config.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/utils/internetConnectivity.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/view/Auth/login-register.dart';
import 'package:mfp_app/view/NavigationBar/nav_screen.dart';
import 'package:mfp_app/view/Profile/Profile.dart';
import 'package:mfp_app/view/Search/search.dart';
import 'package:mfp_app/view/Today/detail_emergency.dart';

import 'package:mfp_app/view/Today/post_details.dart';
import 'package:mfp_app/view/Today/show_full_image.dart';
import 'package:mfp_app/view/Today/story_page.dart';
import 'package:mfp_app/view/Today/webview_emergency.dart';
import 'package:share_plus/share_plus.dart';

class TodaySc extends StatefulWidget {
  final String userid;
  bool taptoload;

  TodaySc({Key key, this.userid, this.taptoload}) : super(key: key);
  @override
  _TodayScState createState() => _TodayScState();
}

class _TodayScState extends State<TodaySc> {
  
  ScrollController _scrollController = ScrollController();
  int _currentMax = 0;
  final EmergencyController emergencyController =
      Get.put(EmergencyController());
  final TodayPostController todayController = Get.put(TodayPostController());

  var userid;
  bool _isLoadMoreRunning = false;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  String token = "";
  var datagetuserprofile;

  var displayName1;

  var gender;

  var firstName;

  var lastName;

  var id;

  var email;

  var image;

  var userimageUrl;
  bool islike = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var mode = "";

  bool _hasNextPage = true;

  void _goToElement(int index) {
    _scrollController.animateTo(
        (100.0 *
            index), // 100 is the height of container and index of 6th element is 5
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
    setState(() {
      widget.taptoload = false;
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      // print('Futuredelayed');
      //--token
      token = await Api.gettoke();
      // print('tokenhome$token');
      //--mode
      mode = await Api.getmodelogin();
      // print('mode$mode');
      //--userid
      userid = await Api.getmyuid();
      // print('userid$userid');
      print('''
         Logged in!
         userid: $userid
        token: $token
         mode: $mode
         ''');
    });
    checkInternetConnectivity().then((value) async {
      value == true
          ? () async {
              setState(() {
                _scrollController.addListener(_loadMore);

                Api.getmodelogin().then((value) => value({
                      setState(() {
                        mode = value;
                      }),
                      print('model$mode'),
                    }));
                Api.getmyuid().then((value) => ({
                      setState(() {
                        userid = value;
                      }),
                      Api.getuserprofile("$userid").then((responseData) async =>
                          ({
                            if (responseData.statusCode == 200)
                              {
                                datagetuserprofile =
                                    jsonDecode(responseData.body),
                                setState(() {
                                  displayName1 =
                                      datagetuserprofile["data"]["displayName"];
                                  gender = datagetuserprofile["data"]["gender"];
                                  firstName =
                                      datagetuserprofile["data"]["firstName"];
                                  lastName =
                                      datagetuserprofile["data"]["lastName"];
                                  id = datagetuserprofile["data"]["id"];
                                  email = datagetuserprofile["data"]["email"];
                                  image =
                                      datagetuserprofile["data"]["imageURL"];
                                }),
                              }
                          })),
                    }));
                Api.getimageURL().then((value) => ({
                      setState(() {
                        userimageUrl = value;
                      }),
                      // print('myuidhome$userid'),
                    }));

                Future.delayed(Duration.zero, () async {
                  // print('delayedgetpost');
                  todayController.postList.clear();
                  todayController.recompageList.clear();
                  emergencyController.emergencyevList.clear();

                  await emergencyController.getmergencyevents();
                  await todayController.getpost(
                      0, userid == null ? "" : userid);
                  await todayController.getrecompage();
                });
              });
            }()
          : Navigate.pushPageDialog(context, nonet(context));

      if (value == false) {
        setState(() {
          emergencyController.isLoading.value = false;
          todayController.isLoading.value = false;
        });
      }
    });

    super.initState();
  }

  Widget videorecommend() {
    return Card(
      child: Container(
        width: double.infinity,
        height: 350.84,
        // color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 20),
              child:
                  texttitleVideorecommend("วิดีโอสำหรับคุณโดยเฉพาะ", context),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 2),
              child: textsubVideorecommend(
                  "เพลิดเพลินกับเพลย์ลิสต์ที่ปรับให้เหมาะกับคุณจาก Youtube",
                  context),
            ),
            SizedBox(
              height: 240.0,
              child: Builder(
                builder: (BuildContext context) {
                  return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (
                        BuildContext context,
                        int index,
                      ) {
                        return videorecommendList();
                      });
                },
              ),
            ),
            Center(
              child: Text(
                "ดูวิดีโอเพิ่มเติมบน Youtube",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    // print('_handleRefresh');
    setState(() {
      emergencyController.emergencyevList.clear();
      todayController.postList.clear();
      todayController.recompageList.clear();
    });
    try {
      emergencyController.getmergencyevents();
      todayController.getpost(0, userid == null ? "" : userid);
      todayController.getrecompage();
    } finally {}
  }

  void _loadMore() async {
    // print('_loadMore');
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // print('AT end');

      setState(() {
        _currentMax = _currentMax + 5;
        todayController.firstload.value = false;
        _isLoadMoreRunning = true;
        _hasNextPage = true;
        // Display a progress indicator at the bottom
      });

      try {
        // print('_loadMoregetpost');
        await todayController.getpost(
            _currentMax, userid == null ? "" : userid);
      } catch (err) {
        // print('Something went wrong!');
      }
    }
  }

  @override
  void didChangeDependencies() {
    setState(() {
      todayController.getpost(_currentMax, userid == null ? "" : userid);
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
          key: _scaffoldKey,
          body: RefreshIndicator(
            onRefresh: () => () async {
              HapticFeedback.mediumImpact();
              await checkInternetConnectivity().then((value) {
                value == true
                    ? () {}()
                    : ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                        content: Text(
                          ' There Was A Problem With The Network',
                          textAlign: TextAlign.center,
                        ),
                        behavior: SnackBarBehavior.floating,
                        width: MediaQuery.of(context).size.width / 1.2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        backgroundColor: MColors.primaryColor,
                        duration: Duration(milliseconds: 5000),
                      ));
              });
              await _handleRefresh();
            }(),
            child: CustomScrollView(
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                // Platform.isAndroid
                //     ? SliverToBoxAdapter(
                //         child: SizedBox.shrink(
                //         child: Container(),
                //       ))
                //     :
                primaryAppBar(
                    context,
                    token,
                    userid,
                    image,
                    Search(),
                    ProfileSc(
                      userid: widget.userid,
                      token: token,
                    )),

                ///-----------APPBAR-----------------//
                SliverToBoxAdapter(
                  child: Obx(() {
                    if (emergencyController.isLoading.value)
                      return CarouselLoading();
                    else
                      return carouselslider(emergencyController.emergencyevList,
                          context, userimageUrl);
                  }),
                ),
                // ///-----------เลื่อนสไลด์-----------------//
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 16.0,
                    color: MColors.primaryGrey,
                    child: Center(
                      child: titletimeline("ไทม์ไลน์",context),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                    child: const SizedBox(
                  height: 7,
                )),

                SliverToBoxAdapter(
                  child: Obx(() {
                    if (todayController.isLoading.value)
                      return CarouselLoading();
                    else
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: todayController.postList.length,
                          itemBuilder: (
                            BuildContext context,
                            int index,
                          ) {
                            final nDataList1 = todayController.postList[index];
                            if (index == todayController.postList.length - 3) {
                              return todayController.firstload.value
                                  ? buildrecommendeduserpage()
                                  : SizedBox.shrink();
                            }

                            return postlist(
                                nDataList1.post.title,
                                nDataList1.post.detail,
                                nDataList1.page,
                                nDataList1.post.createdDate,
                                nDataList1.post.gallery,
                                nDataList1.post.likeCount,
                                nDataList1.post.commentCount,
                                nDataList1.post.shareCount,
                                nDataList1.post.repostCount,
                                nDataList1.post.id,
                                nDataList1.page == null
                                    ? ""
                                    : nDataList1.page.id,
                                nDataList1.page == null
                                    ? ""
                                    : nDataList1.page.imageUrl,
                                nDataList1.page == null
                                    ? ""
                                    : nDataList1.page.name,
                                nDataList1.page == null
                                    ? ""
                                    : nDataList1.page.pageUsername,
                                nDataList1,
                                nDataList1.post.type,
                                nDataList1.post.story,
                                nDataList1.page == null
                                    ? nDataList1.user
                                    : nDataList1.page);
                          });
                  }),
                ),
                if (_isLoadMoreRunning == true)
                  SliverToBoxAdapter(
                    child: Center(
                        child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              MColors.primaryColor)),
                    )),
                  ),
                if (_hasNextPage == false)
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.only(top: 30, bottom: 40),
                      color: Colors.amber,
                      child: Center(
                        child: Text('You have fetched all of the content'),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget postlist(
      String posttitle,
      String subtitle,
      pageName_displayName,
      DateTime dateTime,
      List<Gallery> gallery,
      int likeCount,
      int commentCount,
      int shareCount,
      int repostCount,
      String postid,
      String pageid,
      String pageimage,
      String pagename,
      String pageUsername,
      nDataList1,
      String type,
      story,
      datauser) {
        final appStyle = AppStyle(context);
        bool isstory =true;
        if(pageName_displayName==null){
          isstory=false;

        }
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2, bottom: 2, top: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // topImage(gallery[0].signUrl.toString()),
            gallery.length != 0
                ? InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SliderShowFullmages(
                            listImagesModel: gallery, current: _current))),
                    child: myAlbumCard(gallery, context))
                : Container(),
            // Image.network(gallery[0].signUrl),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return PostDetailsSC(
                                postid: postid,
                                pagename: pageName_displayName == null
                                ? nDataList1.user.displayName.toString()
                                : nDataList1.page.name.toString(),
                                onfocus: false,
                                story: story,
                              );
                            },
                          ),
                        );
                      },
                      child: texttitlepost(posttitle, context)),
                ),
                Padding(
                  padding: appStyle.getEdgeInsetsFromRatio(left: 3,top: 1),
                  child: subtexttitlepost(subtitle, context),
                ),
                story != null
                    ? Padding(
                        padding: appStyle.getEdgeInsetsFromRatio(left: 3,top: 1.5,bottom: 1),
                        child: InkWell(
                            onTap: () async {
                              Navigate.pushPage(
                                  context,
                                  StroyPageSc(
                                    postid: postid,
                                    titalpost: posttitle,
                                    imagUrl: gallery,
                                    type: type,
                                    createdDate: dateTime,
                                    postby: pagename,
                                    imagepage: pageimage,
                                    likeCount: likeCount,
                                    commentCount: commentCount,
                                    shareCount: shareCount,
                                    repostCount: repostCount,
                                    token: token,
                                    userid: userid,
                                    mode: mode,
                                  ));
                            },
                            child: textreadstory('อ่านสตอรี่...',context)),
                      )
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // fixtextauthor(),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0,top: 3),
                        child: authorpost(
                            pageName_displayName == null
                                ? nDataList1.user.displayName.toString()
                                : nDataList1.page.name.toString(),
                            context,
                            nDataList1.page == null ? "" : nDataList1.page.id,
                            isstory),
                      ),
                    ),

                    // SizedBox(
                    //   width: 2,
                    // ),
                    texttimetimestamp(dateTime,context),
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 10, right: 10),
                //   child: Divider(),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Divider(
                        thickness: 1.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PostButton(
                            icon: Icon(
                              nDataList1.post.islike != true
                                  ? Icons.favorite_outline
                                  : Icons.favorite,
                              color: MColors.primaryBlue,
                              size: 19.0,

                              // size: 15.0,
                            ),
                            width: 0.14,
                            containerwidth: 3.4,
                            label: '${nDataList1.post.likeCount} ถูกใจ',
                            onTap: () {
                              HapticFeedback.lightImpact();
                              var jsonResponse;
                              print(nDataList1.post.islike);
                              switch (mode) {
                                case "FB":
                                  print('FB');
                                  if (nDataList1.post.islike == false ||
                                      nDataList1.post.islike == null ||
                                      nDataList1.post.likeCount < 0) {
                                    setState(() {
                                      nDataList1.post.islike = true;
                                      nDataList1.post.likeCount++;
                                    });
                                    Api.islike(postid, userid, token, "FB");
                                  } else if (nDataList1.post.islike == true) {
                                    setState(() {
                                      nDataList1.post.islike = false;
                                      nDataList1.post.likeCount--;
                                    });
                                    Api.islike(postid, userid, token, "FB");
                                  }
                                  break;
                                case "TWITTER":
                                  print('TWITTER');
                                  if (nDataList1.post.islike == false ||
                                      nDataList1.post.islike == null ||
                                      nDataList1.post.likeCount < 0) {
                                    setState(() {
                                      nDataList1.post.islike = true;
                                      nDataList1.post.likeCount++;
                                    });
                                    Api.islike(postid, userid, token, "TW");
                                  } else if (nDataList1.post.islike == true) {
                                    setState(() {
                                      nDataList1.post.islike = false;
                                      nDataList1.post.likeCount--;
                                    });
                                    Api.islike(postid, userid, token, "TW");
                                  }
                                  break;
                                default:
                                  if (token == null || token == "") {
                                    Navigate.pushPage(context, Loginregister());
                                  } else {
                                    setState(() {
                                      if (nDataList1.post.islike == false ||
                                          nDataList1.post.islike == null ||
                                          nDataList1.post.likeCount < 0) {
                                        nDataList1.post.islike = true;
                                        nDataList1.post.likeCount++;
                                        Api.islike(postid, userid, token, "");
                                      } else if (nDataList1.post.islike ==
                                          true) {
                                        nDataList1.post.islike = false;
                                        nDataList1.post.likeCount--;
                                        Api.islike(postid, userid, token, "");
                                      }
                                    });
                                  }
                                  break;
                              }
                            },
                          ),
                          PostButton(
                            icon: Icon(
                              MdiIcons.commentOutline,
                              color: MColors.primaryBlue,
                              size: 19.0,
                            ),
                            label: '$commentCount ความคิดเห็น',
                            width: 0.24,
                            containerwidth: 2.9,
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return PostDetailsSC(
                                      gallery: gallery,
                                      postid: postid,
                                      onfocus: true,
                                      story: story,
                                      pagename: pageName_displayName == null
                                ? nDataList1.user.displayName.toString()
                                : nDataList1.page.name.toString(),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          PostButton(
                            icon: Icon(
                              Icons.share,
                              color: MColors.primaryBlue,
                              size: 19.0,
                            ),
                            width: 0.15,
                            containerwidth: 3.7,
                            label: ' แชร์',
                            onTap: () async {
                              final box =
                                  context.findRenderObject() as RenderBox;

                              await Share.share(
                                  "https://today.moveforwardparty.org/post/$postid",
                                  subject:
                                      "https://today.moveforwardparty.org/post/$postid",
                                  sharePositionOrigin:
                                      box.localToGlobal(Offset.zero) &
                                          box.size);
                            },
                          ),
                        ],
                      ),
                      //  Divider(),
                      const SizedBox(
                        height: 7,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget videorecommendList() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 300,
        height: 200,
        color: MColors.containerWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'images/wightimage.jpg',
                        height: 123,
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            child: CircleAvatar(
                              radius: 25.0,
                              backgroundImage: NetworkImage(
                                  'https://via.placeholder.com/150'),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('อนาคตใหม่ - Future Forward'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildrecommendeduserpage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          thickness: 1.0,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 50.0,
        ),
        Center(
          child: texttitle("แนะนำให้ติดตามส.ส. กทม", context),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 50.0,
        ),
        Builder(
          builder: (BuildContext context) {
            return Obx(() {
              return ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: todayController.recompageList.length,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    var data = todayController.recompageList[index];
                    return Card(
                      child: Container(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child:
                                  data.imageUrl == null || data.imageUrl == ""
                                      ? new Image.network(
                                          "https://www.pngfind.com/pngs/m/610-6104451_image-placeholder-png-user-profile-placeholder-image-png.png",
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          "https://today-api.moveforwardparty.org/api${data.imageUrl}/image",
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                            ),
                          ),
                          title: new Text(
                              '${data.displayName == null ? data.name : data.displayName}'),
                          subtitle: new Text(
                              '${data.pageUsername == null ? "" : data.pageUsername}'),
                          trailing: Container(
                            margin: EdgeInsets.all(10),
                            height: 50.0,
                            width: 95,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                side: BorderSide(color: MColors.primaryColor),
                              ),
                              onPressed: () async {
                                var jsonResponse;
                                token == "" || token == null
                                    ? Navigate.pushPage(
                                        context, Loginregister())
                                    : await Api.sendfollowPage(
                                            data.id, token, userid)
                                        .then((value) => ({
                                              jsonResponse =
                                                  jsonDecode(value.body),
                                              // print(
                                              //     'message${jsonResponse['message']}'),
                                              if (value.statusCode == 200)
                                                {
                                                  if (jsonResponse['message'] ==
                                                      "Followed Page Success")
                                                    {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              new SnackBar(
                                                        content: Text(
                                                            jsonResponse[
                                                                'message']),
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(24),
                                                        ),
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 0, 50),
                                                      )),
                                                    }
                                                  else if (jsonResponse[
                                                          'message'] ==
                                                      "Unfollow Page Success")
                                                    {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              new SnackBar(
                                                        content: Text(
                                                            jsonResponse[
                                                                'message']),
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(24),
                                                        ),
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 0, 50),
                                                      )),
                                                    }
                                                }
                                            }));
                              },
                              color: Colors.white,
                              child: Text("ติดตาม",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: MColors.primaryColor)),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            });
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 50.0,
        ),
        Center(
          child: Text(
            "ดูเพิ่มเติม",
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 50.0,
        ),
      ],
    );
  }

  Widget carouselslider(List<EmergencyEventsContent> emc, context, userimage) {
        final appStyle =AppStyle(context);

    return CarouselSlider(
      carouselController: _controller,
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
        height: appStyle.getHeight(percent: 48.5),
        // aspectRatio: 16 / 9,
        enableInfiniteScroll: true,
        initialPage: 0,
        viewportFraction: 0.99,
        scrollPhysics: BouncingScrollPhysics(),
        reverse: false,
        autoPlay: false,
        disableCenter: true,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: emc.map((emcs) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return Webview_EmergencySC(
                    url:
                        "https://today.moveforwardparty.org/emergencyevent/${emcs.data.emergencyEventId}?hidebar=true",
                    texttitle: emcs.title,
                    iconimage: emcs.coverPageUrl,
                    checkurl: "https://today.moveforwardparty.org/post/",
                  );
                }));
                // Navigate.pushPage(
                //     context,
                //     DTEmergenSc(
                //       token: token,
                //       hashtagstitle: emcs.title,
                //       emergencyEventId: emcs.data.emergencyEventId,
                //       userimage: userimage,
                //       userid: userid,
                //     ));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://today-api.moveforwardparty.org/api${emcs.coverPageUrl}/image"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 16.0,
                        color: MColors.primaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: texthashtags(emcs.title),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                'ดูเพิ่มเติม >',
                                style: TextStyle(
                                  fontFamily: 'Anakotmai-Light',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: MColors.primaryWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: emc.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 8.0,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.white)
                                        .withOpacity(
                                            _current == entry.key ? 0.9 : 0.2)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
