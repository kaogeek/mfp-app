import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/Api/apipost.dart';
import 'package:mfp_app/animation/FadeAnimation.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/model/RecommendedUserPageModel.dart';
import 'package:mfp_app/model/postModel.dart';
import 'package:mfp_app/model/searchpostlistModel.dart';
import 'package:mfp_app/allWidget/CarouselsLoading.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/allWidget/fontsize.dart';
import 'dart:io' show Platform;
import 'package:mfp_app/allWidget/PostButton.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/view/Auth/login-register.dart';
import 'package:mfp_app/view/Profile/Profile.dart';
import 'package:mfp_app/view/Search/Search.dart';
import 'package:mfp_app/view/Today/Dtemergencyevent.dart';

import 'package:mfp_app/view/Today/PostDetailsSc.dart';

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

  int _currentMax = 5;
  Future refpost;
  String messger = "";

  StreamController _postsController;
  List<PostSearchModel> listModelPostClass = [];
  List<EmergencyEventsContent> listemergencyEvents = [];
  List<RecomUserPageModel> listRecomUserPageModel = [];

  bool loading = true;
  var dataht, datapostlist, userid, dataht1;
  Future getDataPostListFuture;
  bool isLoading = true;
  bool isLoadingHastag = true;
  bool fistload = true;
  int _page = 0;
  bool _isLoadMoreRunning = false;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  bool islike = false;
  var token;

  var datagetuserprofile;

  var displayName1;

  var gender;

  var firstName;

  var lastName;

  var id;

  var email;

  var image;

  var userimageUrl;
  @override
  void dispose() {
    _trackingScrollController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

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
    super.initState();
    setState(() {
      _scrollController.addListener(_loadMore);
      setState(() {
        Api.gettoke().then((value) => value({
              token = value,
              // print('checktoken$checktoken'),
            }));
        Api.getmyuid().then((value) => ({
              setState(() {
                userid = value;
              }),
              // print('myuidhome$userid'),
            }));
        Api.getimageURL().then((value) => ({
              setState(() {
                userimageUrl = value;
              }),
              // print('myuidhome$userid'),
            }));
      });
      //   () async {
      //   if (_scrollController.position.pixels ==
      //       _scrollController.position.maxScrollExtent) {
      //     print('At the End');
      //     setState(() {
      //       _currentMax = _currentMax + 5;
      //       Api.getPostList(_currentMax).then((value) => {
      //             if (value.statusCode == 200)
      //               {
      //                 datapostlist = jsonDecode(value.body),
      //                 for (Map i in datapostlist["data"])
      //                   {
      //                     listModelPostClass.add(PostSearchModel.fromJson(i)),
      //                     _postsController.add(value),
      //                   },
      //               }
      //           });

      //       //-------------------------------
      //       Api.getRecommendedUserPage().then((value) => {
      //             listRecomUserPageModel.clear(),
      //             if (value.statusCode == 200)
      //               {
      //                 datapostlist = jsonDecode(value.body),
      //                 for (Map i in datapostlist["data"])
      //                   {
      //                     listRecomUserPageModel
      //                         .add(RecomUserPageModel.fromJson(i)),
      //                   },
      //               }
      //           });
      //     });
      //   }
      // });
      Api.getuserprofile("$userid").then((responseData) => ({
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
                print('displayName1$displayName1'),
                print('gender$gender'),
                print('firstName$firstName'),
                print('lastName$lastName'),
                print('id$id'),
                print('email$email'),
                print('${datagetuserprofile["data"]["username"]}'),
              }
          }));
    

      //-----------------------------//
      Api.getPostemergencyEventsList().then((responseData) => ({
            print('getPostList'),
            setState(() {
              isLoadingHastag = true;
            }),
            if (responseData.statusCode == 200)
              {
                datapostlist = jsonDecode(responseData.body),
                for (Map i in datapostlist["data"]["emergencyEvents"]
                    ["contents"])
                  {
                    setState(() {
                      listemergencyEvents
                          .add(EmergencyEventsContent.fromJson(i));
                    }),
                  },
                setState(() {
                  isLoadingHastag = false;
                }),
              }
            else if (responseData.statusCode == 400)
              {}
          }));

      refpost = Api.getPostList(_currentMax).then((value) => {
            if (value.statusCode == 200)
              {
                setState(() {
                  isLoading = true;
                  fistload = true;
                }),
                datapostlist = jsonDecode(value.body),
                for (Map i in datapostlist["data"])
                  {
                    listModelPostClass.add(PostSearchModel.fromJson(i)),
                    _postsController.add(value),
                  },
                setState(() {
                  isLoading = false;
                }),
              }
          });
      //-------------//
      Api.getRecommendedUserPage().then((value) => {
            if (value.statusCode == 200)
              {
                datapostlist = jsonDecode(value.body),
                for (Map i in datapostlist["data"])
                  {
                    listRecomUserPageModel.add(RecomUserPageModel.fromJson(i)),
                  },
              }
          });

      _postsController = new StreamController();
    });
  }

  Widget BuildVideorecom() {
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
                        return Videorecommend();
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
    new Future.delayed(const Duration(seconds: 3));
    setState(() {
      listemergencyEvents.clear();
      listModelPostClass.clear();
      listRecomUserPageModel.clear();
      fistload = true;
    });
    try {
      await Api.getPostemergencyEventsList().then((responseData) => ({
            print('getPostList'),
            if (responseData.statusCode == 200)
              {
                datapostlist = jsonDecode(responseData.body),
                for (Map i in datapostlist["data"]["emergencyEvents"]
                    ["contents"])
                  {
                    setState(() {
                      listemergencyEvents
                          .add(EmergencyEventsContent.fromJson(i));
                    }),
                  },
              }
            else if (responseData.statusCode == 400)
              {}
          }));
      //-----------------------------------------------
      await Api.getPostList(_currentMax).then((value) => {
            if (value.statusCode == 200)
              {
                datapostlist = jsonDecode(value.body),
                for (Map i in datapostlist["data"])
                  {
                    setState(() {
                      listModelPostClass.add(PostSearchModel.fromJson(i));
                      _postsController.add(value);
                    }),
                  },
              }
          });
      //-----------------------------------------------

      await Api.getRecommendedUserPage().then((value) => {
            if (value.statusCode == 200)
              {
                datapostlist = jsonDecode(value.body),
                for (Map i in datapostlist["data"])
                  {
                    listRecomUserPageModel.add(RecomUserPageModel.fromJson(i)),
                  },
              }
          });
    } finally {}
  }

  void _loadMore() async {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      print('AT end');
      await new Future.delayed(const Duration(milliseconds: 100));

      setState(() {
        _currentMax = _currentMax + 5;
        fistload = false;
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom

        try {
          Api.getPostList(_currentMax).then((value) => {
                if (value.statusCode == 200)
                  {
                    setState(() {
                      isLoading = true;
                    }),
                    datapostlist = jsonDecode(value.body),
                    for (Map i in datapostlist["data"])
                      {
                        listModelPostClass.add(PostSearchModel.fromJson(i)),
                        _postsController.add(value),
                      },
                    setState(() {
                      isLoading = false;
                      _isLoadMoreRunning =
                          false; // Display a progress indicator at the bottom
                    }),
                  }
              });
        } catch (err) {
          print('Something went wrong!');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('taptoload${widget.taptoload}');
    if (widget.taptoload == true) {
      _goToElement(0);
    }
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: () => () async {
              HapticFeedback.mediumImpact();
              print('RefreshIndicator');
              await _handleRefresh();
              await Api.getRecommendedUserPage();
              await Api.getPostList(_currentMax);
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
                primaryAppBar(context, token, userid, userimageUrl, Search(
              userid: userid,
            ),true,
                    ProfileSc(
                      userid:  widget.userid,
                      token:   token,
                    )),

                ///-----------APPBAR-----------------//
                isLoadingHastag
                    ? SliverToBoxAdapter(child: CarouselLoading())
                    : SliverToBoxAdapter(
                        child: Carouselslider(
                            listemergencyEvents, context, userimageUrl)),

                // ///-----------เลื่อนสไลด์-----------------//
                listModelPostClass.length == 0
                    ? SliverToBoxAdapter(child: Container())
                    : SliverToBoxAdapter(
                        child: Container(
                          width: double.infinity,
                          // height: 40,
                          color: MColors.primaryGrey,
                          child: Center(
                            child: titletimeline("ไทม์ไลน์"),
                          ),
                        ),
                      ),

                // ///-----------คำว่าไทม์ไลน์-----------------//

                isLoading == true
                    ? SliverToBoxAdapter(child: CarouselLoading())
                    : SliverToBoxAdapter(
                        child: StreamBuilder(
                          stream: _postsController.stream,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CarouselLoading());
                            }
                            // if (snapshot.connectionState == ConnectionState.none) {
                            //   return Center(child: Text(messger));
                            // }
                            return Builder(
                              builder: (BuildContext context) {
                                return Scrollbar(
                                  isAlwaysShown: true,
                                  child: ListView.builder(
                                      // controller: _scrollController,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      // padding: const EdgeInsets.all(8.0),
                                      scrollDirection: Axis.vertical,
                                      itemCount: listModelPostClass.length,
                                      itemBuilder: (
                                        BuildContext context,
                                        int index,
                                      ) {
                                        // if (listModelPostClass.length == 0) {
                                        //   return Center(
                                        //       child: CupertinoActivityIndicator());
                                        // }
                                        final nDataList1 =
                                            listModelPostClass[index];

                                        //   if(fistload==true){
                                        // if (index == listModelPostClass.length - 3) {

                                        // return  BuildRecommendedUserPage();
                                        //  }
                                        // }else{
                                        //   return SizedBox.shrink();
                                        // }
                                        if (index ==
                                            listModelPostClass.length - 3) {
                                          return fistload == true
                                              ? BuildRecommendedUserPage()
                                              : SizedBox.shrink();
                                        }
                                        if (index ==
                                            listModelPostClass.length) {
                                          print('เท่ากัน');
                                        }

                                        //  else {
                                        //   PostList(
                                        //     nDataList1.post.title,
                                        //     nDataList1.post.detail,
                                        //     nDataList1.page.name,
                                        //     nDataList1.page.createdDate,
                                        //     nDataList1.post.gallery,
                                        //     nDataList1.post.likeCount,
                                        //     nDataList1.post.commentCount,
                                        //     nDataList1.post.shareCount,
                                        //   );
                                        // }

                                        return  FadeAnimation((1.0 + index) / 4, PostList(
                                          nDataList1.post.title,
                                          nDataList1.post.detail,
                                          nDataList1.page.name,
                                          nDataList1.post.createdDate,
                                          nDataList1.post.gallery,
                                          nDataList1.post.likeCount,
                                          nDataList1.post.commentCount,
                                          nDataList1.post.shareCount,
                                          nDataList1.post.id,
                                          nDataList1.page.id,
                                          nDataList1.page.imageUrl,
                                          nDataList1.page.name,
                                          false,
                                          nDataList1.page.pageUsername,
                                          nDataList1.page.isOfficial,
                                          nDataList1,
                                        ));
                                      }),
                                );
                              },
                            );
                          },
                        ),
                      ),
                // when the _loadMore function is running

                ///-----------ListViewPost-----------------//

                // /-----------SliverListปิดไปก่อนได้----------------//
                // listModelPostClass.length == 0
                //     ? SliverToBoxAdapter(child: Container())
                //     : SliverToBoxAdapter(child: fistload==true? BuildRecommendedUserPage():SizedBox.shrink()),

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

  // getItems(img_path, img_path2, count) {
  //   return Container(
  //     width: double.infinity,
  //     child: Row(
  //       // crossAxisAlignment :CrossAxisAlignment.center,
  //       // mainAxisSize: MainAxisSize.max,
  //       children: <Widget>[
  //         // SizedBox(width: 5,),
  //         ClipRRect(
  //           child: Image.network(
  //             img_path,
  //             height: 140,
  //             width: 190,
  //             fit: BoxFit.cover,
  //             filterQuality: FilterQuality.low,
  //           ),
  //         ),
  //         SizedBox(
  //           width: 11,
  //         ),
  //         (count > 0)
  //             ? Stack(
  //                 overflow: Overflow.visible,
  //                 children: <Widget>[
  //                   ClipRRect(
  //                     // borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),),
  //                     child: Image.network(
  //                       img_path2,
  //                       height: 140,
  //                       width: 190,
  //                       fit: BoxFit.cover,
  //                       filterQuality: FilterQuality.low,
  //                     ),
  //                   ),
  //                   (count > 0)
  //                       ? Positioned(
  //                           child: Container(
  //                             height: 140,
  //                             width: 190,
  //                             decoration: BoxDecoration(color: Colors.black38),
  //                             child: Center(
  //                               child: Text(
  //                                 "$count +",
  //                                 style: TextStyle(
  //                                   color: Colors.white,
  //                                   fontSize: 20,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         )
  //                       : Center()
  //                 ],
  //               )
  //             : ClipRRect(
  //                 child: Image.network(
  //                   img_path2,
  //                   height: 140,
  //                   width: 190,
  //                   fit: BoxFit.cover,
  //                   filterQuality: FilterQuality.low,
  //                 ),
  //               ),
  //       ],
  //     ),
  //   );
  // }

  Widget PostList(
    String posttitle,
    String subtitle,
    String authorposttext,
    DateTime dateTime,
    List<Gallery> gallery,
    int likeCount,
    int commentCount,
    int shareCount,
    String postid,
    String pageid,
    String pageimage,
    String pagename,
    bool isFollow,
    String pageUsername,
    bool isOfficial,
    nDataList1,
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
               pageid:  pageid,
pageimage:pageimage,
                pagename:          pagename,
              isFollow:            isFollow,
                   pageUsername:       pageUsername,
               isOfficial     :      isOfficial
              );
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
            gallery.length != 0 ? myAlbumCard(gallery) : SizedBox.shrink(),
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
                          userid),
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
                                      size: 20.0,
                                    ),
                                    width: 100,
                                    label: '${   nDataList1.post.likeCount} ถูกใจ',
                                    onTap: () async {
                                      HapticFeedback.lightImpact();
                                      var jsonResponse;
                                      token == null || token == ""
                                          ? Navigate.pushPage(
                                              context, Loginregister())
                                          : await Api.islike(
                                                  postid, userid, token)
                                              .then((value) => ({
                                                    jsonResponse =
                                                        jsonDecode(value.body),
                                                    print(
                                                        'message${jsonResponse['message']}'),
                                                    if (value.statusCode == 200)
                                                      {
                                                        if (jsonResponse[
                                                                'message'] ==
                                                            "Like Post Success")
                                                          {
                                                            setState(() {
                                                              islike =
                                                                  jsonResponse[
                                                                          'data']
                                                                      [
                                                                      'isLike'];
  nDataList1.post.likeCount++;
                                                            }),
                                                          }
                                                        else if (jsonResponse[
                                                                'message'] ==
                                                            "UnLike Post Success")
                                                          {
                                                            setState(() {
                                                              islike =
                                                                  jsonResponse[
                                                                          'data']
                                                                      [
                                                                      'isLike'];

                                                           nDataList1.post.likeCount--;
                                                            }),
                                                          }
                                                      }
                                                  }));
                                      print("กดlike");
                                    },
                                  )
                                : PostButton(
                                    icon: Icon(
                                      Icons.favorite,
                                      color: MColors.primaryBlue,
                                      size: 20.0,
                                    ),
                                    label: '${  nDataList1.post.likeCount} ถูกใจ',
                                    width: 100,
                                    onTap: () async {
                                      HapticFeedback.lightImpact();

                                      var jsonResponse;
                                      token == null
                                          ? Navigate.pushPage(
                                              context, Loginregister())
                                          : await Api.islike(
                                                  postid, userid, token)
                                              .then((value) => ({
                                                    jsonResponse =
                                                        jsonDecode(value.body),
                                                    print(
                                                        'message${jsonResponse['message']}'),
                                                    if (value.statusCode == 200)
                                                      {
                                                        if (jsonResponse[
                                                                'message'] ==
                                                            "Like Post Success")
                                                          {
                                                            setState(() {
                                                           

                                                              islike =
                                                                  jsonResponse[
                                                                          'data']
                                                                      [
                                                                      'isLike'];
                                                           nDataList1.post.likeCount++;
                                                            }),
                                                          }
                                                        else if (jsonResponse[
                                                                'message'] ==
                                                            "UnLike Post Success")
                                                          {
                                                            setState(() {
                                                              islike =
                                                                  jsonResponse[
                                                                          'data']
                                                                      [
                                                                      'isLike'];

                                                           nDataList1.post.likeCount--;
                                                            }),
                                                          }
                                                      }
                                                  }));
                                      print("กดlike");
                                    },
                                  ),
                            PostButton(
                              icon: Icon(
                                MdiIcons.commentOutline,
                                color: MColors.primaryBlue,
                                size: 20.0,
                              ),
                              label: '$commentCount ความคิดเห็น',
                              width: 110,
                              onTap: () => print('Comment'),
                            ),
                            PostButton(
                              icon: Icon(
                                Icons.share,
                                color: MColors.primaryBlue,
                                size: 25.0,
                              ),
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

  Widget Videorecommend(
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

  Widget BuildRecommendedUserPage() {
    return InkWell(
      onTap: () {},
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: texttitle("แนะนำให้ติดตามส.ส. กทม", context),
            ),
            SizedBox(
              height: 10,
            ),
            Builder(
              builder: (BuildContext context) {
                return ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: listRecomUserPageModel.length,
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      var data = listRecomUserPageModel[index];
                      return Card(
                        child: Container(
                          child: ListTile(
                            leading: new CircleAvatar(
                              radius: 30,
                              backgroundImage: data.imageUrl != null
                                  ? NetworkImage(
                                      "https://today-api.moveforwardparty.org/api${data.imageUrl}/image")
                                  : NetworkImage(
                                      "https://www.pngfind.com/pngs/m/610-6104451_image-placeholder-png-user-profile-placeholder-image-png.png"),
                              backgroundColor: Colors.transparent,

                              // child: Container(
                              //   height: 81,
                              //   width: 347,
                              //   color: Colors.white,
                              //   child: Image.network(
                              //       "https://today-api.moveforwardparty.org/api${data.imageUrl}/image"),
                              // ),
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
                                      :  await Api.sendfollowPage(data.id,
                                              token, userid)
                                          .then((value) => ({
                                                jsonResponse =
                                                    jsonDecode(value.body),
                                                print(
                                                    'message${jsonResponse['message']}'),
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
                                                              .fromLTRB(
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
                                                                    .circular(
                                                                        24),
                                                          ),
                                                          margin: EdgeInsets
                                                              .fromLTRB(
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
              },
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "ดูเพิ่มเติม",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Carouselslider(List<EmergencyEventsContent> emc, context, userimage) {
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
