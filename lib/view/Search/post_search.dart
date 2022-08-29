import 'dart:convert';

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

import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/view/Auth/login-register.dart';
import 'package:mfp_app/view/Today/post_details.dart';
import 'package:mfp_app/view/Today/show_full_image.dart';
import 'package:mfp_app/view/Today/story_page.dart';
import 'package:share_plus/share_plus.dart';

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

  var mode="";

  var userid;
  bool islike = false;
  bool isloadmore = false;

  int _currentMax = 0;
  var storytestreplaceAll;

  var datagetuserprofile;

  var userprofileimage = "";

  String msg = "กำลังโหลด";

  int indexlist;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Text('loading');
        _loadMore();
      }
    });

    Future.delayed(Duration.zero, () async {
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
      await Api.getuserprofile(userid == null ? "" : userid).then((responseData) async => ({
            if (responseData.statusCode == 200)
              {
                datagetuserprofile = jsonDecode(responseData.body),
                setState(() {
                  userprofileimage = datagetuserprofile["data"]["imageURL"];
                }),
              }
          }));
      await todayController.getsearchpostList(storytestreplaceAll,userid == null ? "" : userid, "", 0,
          pagenumber: 0)();
    });
  }

  void _loadMore() async {
    //('_loadMore');
    double _scrollPosition;

    if (_scrollController.offset >= _scrollController.position.pixels) {
      //('AT end');

      setState(() {
        _currentMax = _currentMax + 5;
        todayController.firstload.value = false;
        isloadmore = true;
      });

      try {
        //('_loadMoregetpost');
        await todayController.getsearchpostList(
            storytestreplaceAll,userid == null ? "" : userid, "", _currentMax,
            pagenumber: _currentMax);
      } catch (err) {}
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
          titleSpacing: 0.0,
          backgroundColor: Color(0xffF47932),
          title: Text('${widget.label}'),
          leading: IconButton(
            splashRadius: AppTheme.splashRadius,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Get.reset();
              Navigator.pop(context);
              //('กด');
            },
          ),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Obx(() {
                if (todayController.isLoading.value)
                  return CarouselLoading();
                else
                  return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: todayController.serarchpostList.length,
                      itemBuilder: (
                        BuildContext context,
                        int index,
                      ) {
                        final nDataList1 =
                            todayController.serarchpostList[index];
                        indexlist = index;
                        if (index ==
                            todayController.serarchpostList.length - 1) {
                          isloadmore = false;
                          msg = "ไม่มีโพสแล้ว";
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
                        
                          nDataList1.page== null
                                    ? ""
                                    : nDataList1.page.imageUrl,
                          false,
                          nDataList1,
                          nDataList1.post.type,
                          nDataList1.post.coverImage,
                          nDataList1.post.story,

                        );
                      });
              }),
              // if (todayController.isLoadingmore.value == false)
              //   Center(
              //       child: Container(
              //     margin: EdgeInsets.only(bottom: 30),
              //     child: Container(
              //             height: 50,
              //             padding: const EdgeInsets.only(bottom: 20),
              //             color: MColors.primaryWhite,
              //             child: Center(
              //               child: Text(msg,
              //               style:TextStyle(fontSize: 14)
              //               ),
              //             ),
              //           ),
              //   )),
              //  indexlist!=todayController.serarchpostList.length-1?
              //       Center(
              //         child: Container(
              //       margin: EdgeInsets.only(bottom: 20),
              //       child: CircularProgressIndicator(
              //           valueColor: AlwaysStoppedAnimation<Color>(
              //               MColors.primaryColor)),
              //     )):Center(
              //     child: Container(
              //   margin: EdgeInsets.only(bottom: 30),
              //   child: Container(
              //           height: 50,
              //           padding: const EdgeInsets.only(bottom: 20),
              //           color: MColors.primaryWhite,
              //           child: Center(
              //             child: Text(msg,
              //             style:TextStyle(fontSize: 14)
              //             ),
              //           ),
              //         ),
              // )),
            ],
          ),
        ),
      ),
    );
  }

  Widget postlist(
      String posttitle,
      String subtitle,
       listPage,
      DateTime dateTime,
      List gallery,
      int likeCount,
      int commentCount,
      int shareCount,
      int repostCount,
      String postid,
      String pageimage,
      bool isFollow,
      nDataList1,
      String type,
      String coverimage,
      story) {
         bool isstory =true;
        if(listPage==null){
          isstory=false;

        }
    return Container(
      width: 200,
      color: MColors.containerWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  coverimage!=null? Image.network("https://today-api.moveforwardparty.org/api$coverimage/image",width: double.infinity,):
          // gallery[0].imageUrl!=null? Image.network("https://today-api.moveforwardparty.org/api${gallery[0].imageUrl}/image",):Image.network("https://today-api.moveforwardparty.org/api${gallery[0].signUrl}/image",),
          gallery.length != 0
              ? InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SliderShowFullmages(
                          listImagesModel: gallery, current: 0))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: myAlbumCard(gallery, context),
                  ))
              : Container(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return PostDetailsSC(
                              postid: postid,
                              onfocus: false,
                            );
                          },
                        ),
                      );
                    },
                    child: texttitlepost(posttitle, context)),
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
                                  postby: listPage == null
                                ? nDataList1.user.displayName.toString()
                                : nDataList1.page.name.toString(),
                                  imagepage: pageimage,
                                  likeCount: likeCount,
                                  commentCount: commentCount,
                                  shareCount: shareCount,
                                  repostCount: repostCount,
                                  token: token,
                                  userid: userid,
                                ));
                          },
                          child: textreadstory('อ่านสตอรี่...',context)),
                    )
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: authorpost(
                          listPage == null
                                ? nDataList1.user.displayName.toString()
                                : nDataList1.page.name.toString(),
                          context,
                          listPage==null?"":nDataList1.page.id,
                          isstory),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  texttimetimestamp(dateTime,context),
                ],
              ),
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
                      children: <Widget>[
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
                          containerwidth: 3.1,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return PostDetailsSC(
                                 
                                    gallery: gallery,
                                   
                                    postid: postid,
                                   
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
                            size: 19.0,
                          ),
                          width: 0.15,
                            containerwidth: 3.7,
                          label: ' แชร์',
                          onTap: ()async {
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
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3,
          ),
        ],
      ),
    );
  }
}
