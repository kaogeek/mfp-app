import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/CarouselsLoading.dart';
import 'package:mfp_app/allWidget/PostButton.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/allWidget/fontsize.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/controller/today_post_provider.dart';
import 'package:mfp_app/model/searchpostlist.dart';
import 'package:mfp_app/model/searchpostlistModel.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/view/Auth/login-register.dart';
import 'package:mfp_app/view/Today/post_details.dart';
import 'package:mfp_app/view/Today/story_page.dart';

class PostSearch extends StatefulWidget {
  final String label;
  PostSearch({Key key, this.label}) : super(key: key);

  @override
  _PostSearchState createState() => _PostSearchState();
}

class _PostSearchState extends State<PostSearch> {
  final TodayPostController todayController = Get.put(TodayPostController());

  var token;
  ScrollController _scrollController = ScrollController();

  var mode;

  var userid;
  bool islike = false;
  bool isloadmore = false;

  int _currentMax = 0;
  var storytestreplaceAll;

  var datagetuserprofile;

  var userprofileimage = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //print('At the End');
        Text('loading');
        _loadMore();
      }
    });

    Future.delayed(Duration.zero, () async {
      //('delayedgetpost');
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
          }));
      storytestreplaceAll = widget.label.replaceAll("#", "");
      await Api.getuserprofile(userid).then((responseData) async => ({
            if (responseData.statusCode == 200)
              {
                datagetuserprofile = jsonDecode(responseData.body),
                setState(() {
                  // displayName1 =
                  //     datagetuserprofile["data"]["displayName"];
                  // gender = datagetuserprofile["data"]["gender"];
                  // firstName =
                  //     datagetuserprofile["data"]["firstName"];
                  // lastName =
                  //     datagetuserprofile["data"]["lastName"];
                  // id = datagetuserprofile["data"]["id"];
                  // email = datagetuserprofile["data"]["email"];
                  userprofileimage = datagetuserprofile["data"]["imageURL"];
                }),
              }
          }));
      //('storytestreplaceAll$storytestreplaceAll');
      await todayController.getsearchpostList(storytestreplaceAll, "", 0,
          pagenumber: 0)();
    });
  }

  void _loadMore() async {
    //('_loadMore');
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      //('AT end');
      await new Future.delayed(const Duration(milliseconds: 100));

      setState(() {
        _currentMax = _currentMax + 5;
        todayController.firstload.value = false;
        isloadmore = true;
        // _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      try {
        //('_loadMoregetpost');
        await todayController.getsearchpostList(
            storytestreplaceAll, "", _currentMax,
            pagenumber: _currentMax);
      } catch (err) {
        //('Something went wrong!');
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      maintainBottomViewPadding: true,
      child: Scaffold(
        // key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xffF47932),
          title: Text('${widget.label}'),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // loading == true ? Text('${widget.label}') : Container(),
              Obx(() {
                if (todayController.isLoading.value)
                  return CarouselLoading();
                else
                  return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      // controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      itemCount: todayController.serarchpostList.length,
                      itemBuilder: (
                        BuildContext context,
                        int index,
                      ) {
                        final nDataList1 =
                            todayController.serarchpostList[index];

                        return postlist(
                          nDataList1.post.title,
                          nDataList1.post.detail,
                          nDataList1.page.name ?? "",
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
                          nDataList1.post.coverImage,
                          nDataList1.post.story,
                        );
                      });
              }),
              if (isloadmore == true)
                Center(
                    child: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          MColors.primaryColor)),
                )),
            ],
          ),
        ),
      ),
    );
  }

  Widget postlist(
      String posttitle,
      String subtitle,
      String authorposttext,
      DateTime dateTime,
      List gallery,
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
      String coverimage,
      story) {
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
                postid: postid,
                userimage: pageimage,
                pageid: pageid,
                pageimage: pageimage,
                pagename: pagename,
                isFollow: isFollow,
                pageUsername: pageUsername,
                isOfficial: isOfficial,
                onfocus: false,
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
            //  coverimage!=null? Image.network("https://today-api.moveforwardparty.org/api$coverimage/image",width: double.infinity,):
            // gallery[0].imageUrl!=null? Image.network("https://today-api.moveforwardparty.org/api${gallery[0].imageUrl}/image",):Image.network("https://today-api.moveforwardparty.org/api${gallery[0].signUrl}/image",),
            gallery.length != 0 ? myAlbumCard(gallery, context) : Container(),
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
                  story != null
                      ? Padding(
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
                                      token: token,
                                      userid: userid,
                                    ));
                              },
                              child: textreadstory('อ่านสตอรี่..')),
                        )
                      : Container(),
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
                          userid,
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
                          children: <Widget>[
                            PostButton(
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
                                                      jsonDecode(value.body),
                                                  // //(
                                                  //     'message${jsonResponse['message']}'),
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
                                                                    ['isLike'];
                                                            nDataList1.post
                                                                .likeCount++;
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
                                                                    ['isLike'];

                                                            nDataList1.post
                                                                .likeCount--;
                                                          }),
                                                        }
                                                    }
                                                }))
                                        : await Api.islike(
                                                postid, userid, token, mode)
                                            .then((value) => ({
                                                  jsonResponse =
                                                      jsonDecode(value.body),
                                                  // //(
                                                  //     'message${jsonResponse['message']}'),
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
                                                                    ['isLike'];
                                                            nDataList1.post
                                                                .likeCount++;
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
                                                                    ['isLike'];

                                                            nDataList1.post
                                                                .likeCount--;
                                                          }),
                                                        }
                                                    }
                                                }));
                                // //("กดlike");
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
                                        postid: postid,
                                        userimage: userprofileimage,
                                        pageid: pageid,
                                        pageimage: pageimage,
                                        pagename: pagename,
                                        isFollow: isFollow,
                                        pageUsername: pageUsername,
                                        isOfficial: isOfficial,
                                        onfocus: true,
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
                                // size: 25.0,
                              ),
                              width: 8.0,
                              label: '$shareCount แชร์',
                              onTap: () => {},
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
}
