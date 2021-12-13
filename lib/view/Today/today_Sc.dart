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
import 'package:mfp_app/model/postModel.dart';
import 'package:mfp_app/model/searchpostlistModel.dart';
import 'package:mfp_app/allWidget/CarouselsLoading.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/allWidget/fontsize.dart';
import 'package:mfp_app/allWidget/PostButton.dart';
import 'package:mfp_app/utils/internetConnectivity.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/view/Auth/login-register.dart';
import 'package:mfp_app/view/NavigationBar/nav_screen.dart';
import 'package:mfp_app/view/Profile/Profile.dart';
import 'package:mfp_app/view/Search/search.dart';
import 'package:mfp_app/view/Today/detail_emergency.dart';

import 'package:mfp_app/view/Today/post_details.dart';
import 'package:mfp_app/view/Today/story_page.dart';

class TodaySc extends StatefulWidget {
  final String userid;
  bool taptoload;

  TodaySc({Key key, this.userid, this.taptoload}) : super(key: key);
  @override
  _TodayScState createState() => _TodayScState();
}

class _TodayScState extends State<TodaySc> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();
  ScrollController _scrollController = ScrollController();
  int _currentMax = 0;
  final EmergencyController emergencyController =
      Get.put(EmergencyController());
  final TodayPostController todayController = Get.put(TodayPostController());

  var userid;
  bool _isLoadMoreRunning = false;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  bool islike = false;
  String token;
  var datagetuserprofile;

  var displayName1;

  var gender;

  var firstName;

  var lastName;

  var id;

  var email;

  var image;

  var userimageUrl;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String mode = "";

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
    checkInternetConnectivity().then((value) {
      value == true
          ? () {
              setState(() {
                _scrollController.addListener(_loadMore);
                Api.gettoke().then((value) => value({
                      setState(() {
                        token = value;
                      }),
                    }));
                Api.getmodelogin().then((value) => value({
                      setState(() {
                        mode = value;
                      }),
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
                  print('delayedgetpost');
                  await todayController.getpost(0);
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
    print('_handleRefresh');
    setState(() {
      emergencyController.emergencyevList.clear();
      todayController.postList.clear();
      todayController.recompageList.clear();
    });
    try {
      await emergencyController.getmergencyevents();
      todayController.onInit();
    } finally {}
  }

  void _loadMore() async {
    print('_loadMore');
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      print('AT end');
      await new Future.delayed(const Duration(milliseconds: 100));

      setState(() {
        _currentMax = _currentMax + 5;
        todayController.firstload.value = false;
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      try {
        print('_loadMoregetpost');
        await todayController.getpost(_currentMax);
      } catch (err) {
        print('Something went wrong!');
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _trackingScrollController.dispose();
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
                    ? Navigate.pushPageReplacement(context, NavScreen())
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
                        // margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                        // padding: EdgeInsets.all(20),
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
                    Search(
                      userid: userid,
                    ),
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
                    height: 50,
                    color: MColors.primaryGrey,
                    child: Center(
                      child: titletimeline("ไทม์ไลน์"),
                    ),
                  ),
                ),
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
                            return FadeAnimation(
                                (1.0 + index / 4),
                                postlist(
                                  nDataList1.post.title,
                                  nDataList1.post.detail,
                                  nDataList1.page.name,
                                  nDataList1.post.createdDate,
                                  nDataList1.post.gallery,
                                  nDataList1.post.likeCount,
                                  nDataList1.post.commentCount,
                                  nDataList1.post.shareCount,
                                  nDataList1.post.repostCount,
                                  nDataList1.post.id,
                                  nDataList1.page.id,
                                  nDataList1.page.imageUrl,
                                  nDataList1.page.name,
                                  false,
                                  nDataList1.page.pageUsername,
                                  nDataList1.page.isOfficial,
                                  nDataList1,
                                  nDataList1.post.type,
                                ));
                          });
                  }),
                ),
                // listModelPostClass.length == 0
                //     ? SliverToBoxAdapter(child: Container())
                //     : SliverToBoxAdapter( ==true? BuildRecommendedUserPage():SizedBox.shrink()),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future cacheImage(BuildContext context, String urlImage) =>
      precacheImage(CachedNetworkImageProvider(urlImage), context);

  Widget postlist(
    String posttitle,
    String subtitle,
    String authorposttext,
    DateTime dateTime,
    List<GalleryPostSearchModel> gallery,
    int likeCount,
    int commentCount,
    int shareCount,
    int repostCount,
    String postid,
    String pageid,
    String pageimage,
    String pagename,
    bool isFollow,
    String pageUsername,
    bool isOfficial,
    nDataList1,
    String type,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return PostDetailsSC(
                  posttitle: posttitle,
                  subtitle: subtitle,
                  authorposttext: authorposttext,
                  dateTime: dateTime,
                  gallery: gallery,
                  likeCount: likeCount,
                  commentCount: commentCount,
                  shareCoun: shareCount,
                  id: postid,
                  userid: userid,
                  token: token,
                  userimage: userimageUrl,
                  pageid: pageid,
                  pageimage: pageimage,
                  pagename: pagename,
                  isFollow: isFollow,
                  pageUsername: pageUsername,
                  isOfficial: isOfficial);
            },
          ),
        );
      },
      child: Container(
        width: 200,
        color: MColors.containerWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topImage(gallery[0].signUrl.toString()),
            // gallery.length != 0
            //     ? myAlbumCard(gallery, context)
            //     : SizedBox.shrink(),
            // Image.network(gallery[0].signUrl),
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: texttitlepost(posttitle, context),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: subtexttitlepost(subtitle, context),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                                userid: userid,
                                token: token,
                              ));
                        },
                        child: textreadstory('อ่านสตอรี่..')),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      fixtextauthor(),
                      authorpost(
                          authorposttext,
                          context,
                          dateTime,
                          pageid,
                          pageimage,
                          pagename,
                          isFollow,
                          pageUsername,
                          isOfficial,
                          id,
                          true),
                      SizedBox(
                        width: 2,
                      ),
                      texttimetimestamp(dateTime),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            islike == false
                                ? PostButton(
                                    icon: Icon(
                                      Icons.favorite_outline,
                                      color: MColors.primaryBlue,
                                      // size: 15.0,
                                    ),
                                    width: 8.0,
                                    label: '${nDataList1.post.likeCount} ถูกใจ',
                                    onTap: () async {
                                      HapticFeedback.lightImpact();
                                      var jsonResponse;
                                      token == null || token == ""
                                          ? Navigate.pushPage(
                                              context, Loginregister())
                                          : mode != "FB"
                                              ? await Api.islike(
                                                      postid, userid, token, "")
                                                  .then((value) => ({
                                                        jsonResponse =
                                                            jsonDecode(
                                                                value.body),
                                                        // print(
                                                        //     'message${jsonResponse['message']}'),
                                                        if (value.statusCode ==
                                                            200)
                                                          {
                                                            if (jsonResponse[
                                                                    'message'] ==
                                                                "Like Post Success")
                                                              {
                                                                setState(() {
                                                                  islike = jsonResponse[
                                                                          'data']
                                                                      [
                                                                      'isLike'];
                                                                  nDataList1
                                                                      .post
                                                                      .likeCount++;
                                                                }),
                                                              }
                                                            else if (jsonResponse[
                                                                    'message'] ==
                                                                "UnLike Post Success")
                                                              {
                                                                setState(() {
                                                                  islike = jsonResponse[
                                                                          'data']
                                                                      [
                                                                      'isLike'];

                                                                  nDataList1
                                                                      .post
                                                                      .likeCount--;
                                                                }),
                                                              }
                                                          }
                                                      }))
                                              : await Api.islike(postid, userid,
                                                      token, mode)
                                                  .then((value) => ({
                                                        jsonResponse =
                                                            jsonDecode(
                                                                value.body),
                                                        // print(
                                                        //     'message${jsonResponse['message']}'),
                                                        if (value.statusCode ==
                                                            200)
                                                          {
                                                            if (jsonResponse[
                                                                    'message'] ==
                                                                "Like Post Success")
                                                              {
                                                                setState(() {
                                                                  islike = jsonResponse[
                                                                          'data']
                                                                      [
                                                                      'isLike'];
                                                                  nDataList1
                                                                      .post
                                                                      .likeCount++;
                                                                }),
                                                              }
                                                            else if (jsonResponse[
                                                                    'message'] ==
                                                                "UnLike Post Success")
                                                              {
                                                                setState(() {
                                                                  islike = jsonResponse[
                                                                          'data']
                                                                      [
                                                                      'isLike'];

                                                                  nDataList1
                                                                      .post
                                                                      .likeCount--;
                                                                }),
                                                              }
                                                          }
                                                      }));
                                      // print("กดlike");
                                    },
                                  )
                                : PostButton(
                                    icon: Icon(
                                      Icons.favorite,
                                      color: MColors.primaryBlue,
                                      // size: 15.0,
                                    ),
                                    label: '${nDataList1.post.likeCount} ถูกใจ',
                                    width: 8.0,
                                    onTap: () async {
                                      HapticFeedback.lightImpact();

                                      var jsonResponse;
                                      token == null
                                          ? Navigate.pushPage(
                                              context, Loginregister())
                                          : mode != "FB"
                                              ? await Api.islike(
                                                      postid, userid, token, "")
                                                  .then((value) => ({
                                                        jsonResponse =
                                                            jsonDecode(
                                                                value.body),
                                                        // print(
                                                        //     'message${jsonResponse['message']}'),
                                                        if (value.statusCode ==
                                                            200)
                                                          {
                                                            if (jsonResponse[
                                                                    'message'] ==
                                                                "Like Post Success")
                                                              {
                                                                setState(() {
                                                                  islike = jsonResponse[
                                                                          'data']
                                                                      [
                                                                      'isLike'];
                                                                  nDataList1
                                                                      .post
                                                                      .likeCount++;
                                                                }),
                                                              }
                                                            else if (jsonResponse[
                                                                    'message'] ==
                                                                "UnLike Post Success")
                                                              {
                                                                setState(() {
                                                                  islike = jsonResponse[
                                                                          'data']
                                                                      [
                                                                      'isLike'];

                                                                  nDataList1
                                                                      .post
                                                                      .likeCount--;
                                                                }),
                                                              }
                                                          }
                                                      }))
                                              : await Api.islike(postid, userid,
                                                      token, mode)
                                                  .then((value) => ({
                                                        jsonResponse =
                                                            jsonDecode(
                                                                value.body),
                                                        // print(
                                                        //     'message${jsonResponse['message']}'),
                                                        if (value.statusCode ==
                                                            200)
                                                          {
                                                            if (jsonResponse[
                                                                    'message'] ==
                                                                "Like Post Success")
                                                              {
                                                                setState(() {
                                                                  islike = jsonResponse[
                                                                          'data']
                                                                      [
                                                                      'isLike'];
                                                                  nDataList1
                                                                      .post
                                                                      .likeCount++;
                                                                }),
                                                              }
                                                            else if (jsonResponse[
                                                                    'message'] ==
                                                                "UnLike Post Success")
                                                              {
                                                                setState(() {
                                                                  islike = jsonResponse[
                                                                          'data']
                                                                      [
                                                                      'isLike'];

                                                                  nDataList1
                                                                      .post
                                                                      .likeCount--;
                                                                }),
                                                              }
                                                          }
                                                      }));
                                      // print("กดlike");
                                    },
                                  ),
                            PostButton(
                              icon: Icon(
                                MdiIcons.commentOutline,
                                color: MColors.primaryBlue,
                                // size: 20.0,
                              ),
                              label: '$commentCount ความคิดเห็น',
                              width: 4.1,
                              onTap: () => print('Comment'),
                            ),
                            PostButton(
                              icon: Icon(
                                Icons.share,
                                color: MColors.primaryBlue,
                                // size: 25.0,
                              ),
                              width: 8.0,
                              label: '$shareCount แชร์',
                              onTap: () => print('Share'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget videorecommendList(
      // String posttitle, String subtitle, String authorposttext,
      //   DateTime dateTime, List<Gallery> gallery,int likeCount,int commentCount,int shareCount
      ) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 300,
        height: 200,
        color: MColors.containerWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.network(gallery[0].signUrl),
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
                        // fixtextauthor(),
                        // authorpost(authorposttext, context),
                        // texttimetimestamp(dateTime),
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
    return InkWell(
      onTap: () {},
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                                  child: data.imageUrl == null ||
                                          data.imageUrl == ""
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
                                    side:
                                        BorderSide(color: MColors.primaryColor),
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
                                                      if (jsonResponse[
                                                              'message'] ==
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
                                                                      .circular(
                                                                          24),
                                                            ),
                                                            margin: EdgeInsets
                                                                .fromLTRB(0, 0,
                                                                    0, 50),
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
                                                                      .circular(
                                                                          24),
                                                            ),
                                                            margin: EdgeInsets
                                                                .fromLTRB(0, 0,
                                                                    0, 50),
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
        ),
      ),
    );
  }

  Widget carouselslider(List<EmergencyEventsContent> emc, context, userimage) {
    return CarouselSlider(
      carouselController: _controller,
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
        height: MediaQuery.of(context).size.height / 1.9,
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
            return InkWell(
              onTap: () {
                Navigate.pushPage(
                    context,
                    DTEmergenSc(
                      token: token,
                      hashtagstitle: emcs.title,
                      emergencyEventId: emcs.data.emergencyEventId,
                      userimage: userimage,
                      userid: userid,
                    ));
              },
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://today-api.moveforwardparty.org/api${emcs.coverPageUrl}/image"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Stack(
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
                      Row(
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
                                          : Colors.black)
                                      .withOpacity(
                                          _current == entry.key ? 0.9 : 0.2)),
                            ),
                          );
                        }).toList(),
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
