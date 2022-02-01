import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/PostButton.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/allWidget/fontsize.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/model/pagemodel.dart';
import 'package:mfp_app/model/postlistSSmodel.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/view/Auth/login-register.dart';
import 'package:http/http.dart' as Http;

import 'package:mfp_app/view/Today/post_details.dart';
import 'package:mfp_app/view/Today/show_full_image.dart';
import 'package:mfp_app/view/Today/story_page.dart';
import 'package:mfp_app/view/Today/webview_emergency.dart';

class Profliess extends StatefulWidget {
  final String id;
  const Profliess({
    Key key,
    this.id,
  }) : super(key: key);

  // ShopSC({Key? key}) : super(key: key);

  @override
  _ProfliessState createState() => _ProfliessState();
}

class _ProfliessState extends State<Profliess> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  var token = "";

  StreamController _postsController;
  var userimageUrl;
  List<PostPageSS> listpostss = [];
  Future getPostss;
  var dataht;
  ScrollController _scrollController = ScrollController();
  ScrollController _scrolltotopController;
  final ScrollController _scrollHolController = ScrollController();

  int _currentMax = 0;
  bool islike = false;

  bool isLoading = true;
  var story;
  bool _isLoadMoreRunning = false;
  int page = 5;
  var followers = 0;
  var coverURL = "";
  bool isFollow = false;
  String userid = "";

  var datagetuserprofile;
  var image = "";
  var pagecoverURL;
  var pagefollowers = 0;
  var pageprofileimage = "";
  var pagename = "";
  var pageUsername = "";
  var pageid = "";

  bool _showBackToTopButton = false;
  StreamController _pageobjController;

  bool _hasNextPage = true;
  List<PageObjective> pageobjslist = [];
  var mode = "";

  var msgres = "กำลังโหลด";
  @override
  void initState() {
    //print('initState');
    _scrollController.addListener(_loadMore);

    Future.delayed(Duration.zero, () async {
      token = await Api.gettoke();

      userid = await Api.getmyuid();

      mode = await Api.getmodelogin();

      await Api.getPage(widget.id).then((responseData) async => ({
            if (responseData.statusCode == 200)
              {
                datagetuserprofile = jsonDecode(responseData.body),
                //('datagetuserprofile$datagetuserprofile'),
                setState(() {
                  pageid = datagetuserprofile["data"]["id"];
                  pageUsername = datagetuserprofile["data"]["pageUsername"];
                  pageprofileimage = datagetuserprofile["data"]["imageURL"];
                  pagename = datagetuserprofile["data"]["name"];
                  pagecoverURL = datagetuserprofile["data"]["coverURL"];
                  pagefollowers = datagetuserprofile["data"]["followers"];
                }),
                for (Map i in datagetuserprofile["data"]["pageObjectives"])
                  {
                    pageobjslist.add(PageObjective.fromJson(i)),
                  },
              }
            else
              {
                setState(() {
                  isLoading = false;
                }),
              }
          }));
      //---getuserprofile
      await Api.getuserprofile(userid).then((responseData) async => ({
            if (responseData.statusCode == 200)
              {
                datagetuserprofile = jsonDecode(responseData.body),
                setState(() {
                  image = datagetuserprofile["data"]["imageURL"];
                }),
              }
            else
              {
                setState(() {
                  isLoading = false;
                }),
              }
          }));
      //--checkisFollow
      await Api.getpagess(userid, token, widget.id)
          .then((responseData) async => ({
                if (responseData.statusCode == 200)
                  {
                    dataht = jsonDecode(responseData.body),
                    setState(() {
                      followers = dataht["data"]["followers"];

                      if (dataht["data"]["isFollow"] == true) {
                        setState(() {
                          isFollow = true;
                        });
                      }
                      if (dataht["data"]["isFollow"] == false) {
                        setState(() {
                          isFollow = false;
                        });
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }),
                  }
              }));
      await _getPostListSS(widget.id, _currentMax);
    });

    super.initState();

    _postsController = new StreamController();
  }

  @override
  void dispose() {
    _trackingScrollController.dispose();
    _scrollController.removeListener(_loadMore);

    super.dispose();
  }

  Future _getPostListSS(String name, int offset) async {
    final headers = {
      // "mode": "EMAIL",
      "authority": "today-api.moveforwardparty.org",
      "content-type": "application/json",
    };
    Map data = {"type": "", "offset": offset, "limit": 5};
    var body = jsonEncode(data);

    final responseData = await Http.post(
      Uri.parse("${Api.url}api/page/$name/post/search?isHideStory=true"),
      headers: headers,
      body: body,
    );

    //('getPostListSS');
    // print(responseData.body);
    dataht = jsonDecode(responseData.body);
    msgres = dataht['message'];
    if (responseData.statusCode == 200) {
      for (var i in dataht["data"]["posts"]) {
        setState(() {
          listpostss.add(PostPageSS.fromJson(i));
          _postsController.add(dataht);
        });
      }
      if (msgres == "Successfully Search Page Post") {
        setState(() {
          _hasNextPage = false;
        });
      } else if (msgres == "Page Post Not Found") {
        setState(() {
          _hasNextPage = false;
        });
      }

      setState(() {
        isLoading = false;
        _isLoadMoreRunning = false;
      });
    } else if (responseData.statusCode == 400) {}
  }

  void _loadMore() async {
    if (
        // _hasNextPage == true &&
        _isLoadMoreRunning == false &&
            _scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
      await new Future.delayed(const Duration(milliseconds: 200));

      setState(() {
        _currentMax = _currentMax + 5;
        _isLoadMoreRunning = true;
      });
      try {
        _getPostListSS(widget.id, _currentMax);
      } catch (err) {}
    } else {
      _isLoadMoreRunning = false;
    }
  }

  void _goToElement(int index) {
    _scrollController.animateTo(
        (100.0 *
            index), // 100 is the height of container and index of 6th element is 5
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    print('id${widget.id}');
    return isLoading == true
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
                floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.arrow_drop_up_outlined),
                  backgroundColor: MColors.primaryColor,
                  onPressed: () => _goToElement(0),
                ),
                body: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    // primaryAppBar(
                    //     context,
                    //     token,
                    //     userid,
                    //     image,
                    //     Search(),
                    //     ProfileSc(
                    //       userid: userid,
                    //       token: token,
                    //     )),

                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                  splashRadius: AppTheme.splashRadius,
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: MColors.primaryColor,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: CircleAvatar(
                                    radius: 25.0,
                                    backgroundImage: (pageprofileimage == null)
                                        ? NetworkImage(
                                            'https://via.placeholder.com/150')
                                        : CachedNetworkImageProvider(
                                            "https://today-api.moveforwardparty.org/api$pageprofileimage/image"),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      pagename,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontFamily:
                                            AppTheme.FontAnakotmaiMedium,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: <Widget>[
                          Stack(
                            overflow: Overflow.visible,
                            alignment: Alignment.center,
                            children: <Widget>[
                              pagecoverURL == null
                                  ? Container()
                                  : CachedNetworkImage(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      imageUrl:
                                          "https://today-api.moveforwardparty.org/api$pagecoverURL/image",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: MColors.primaryColor,
                                        ),
                                      ),
                                      // errorWidget: (context, url, error) => errorWidget,
                                    ),
                              // Image.network(
                              //     "https://today-api.moveforwardparty.org/api$pagecoverURL/image"),
                              // FadeInImage.assetNetwork(
                              //   placeholder: 'images/placeholder.png',
                              //   image:
                              //       ,
                              //   height: 180,
                              //   fit: BoxFit.cover,
                              // ),
                              Positioned(
                                bottom: -55.0,
                                child: new Container(
                                  width: 130.0,
                                  height: 130.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: new CachedNetworkImageProvider(
                                        'https://today-api.moveforwardparty.org/api$pageprofileimage/image',
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: const SizedBox(
                      height: 12,
                    )),
                    SliverToBoxAdapter(
                        child: Container(
                      color: MColors.primaryWhite,
                      height: MediaQuery.of(context).size.height / 5.5,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Center(
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Text(
                                  pagename,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 22,
                                    fontFamily: 'Anakotmai-Bold',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 70.0),
                            child: Center(
                              child: Text(
                                '@$pageUsername',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0,
                                  fontFamily: AppTheme.FontAnakotmaiLight,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Spacer(),
                            InkWell(
                              onTap: () async {
                                HapticFeedback.lightImpact();
                                var jsonResponse;
                                token == null || token == ""
                                    ? Navigate.pushPage(
                                        context, Loginregister())
                                    : await Api.isfollowpage(
                                            widget.id, userid, token, mode)
                                        .then((value) => ({
                                              jsonResponse =
                                                  jsonDecode(value.body),
                                              ////('message${jsonResponse['message']}'),
                                              if (value.statusCode == 200)
                                                {
                                                  if (jsonResponse['message'] ==
                                                      "Followed Page Success")
                                                    {
                                                      setState(() {
                                                        // isFollow = true;
                                                        isFollow =
                                                            jsonResponse['data']
                                                                ['isFollow'];
                                                        isFollow = true;
                                                      }),
                                                    }
                                                  else if (jsonResponse[
                                                          'message'] ==
                                                      "Unfollow Page Success")
                                                    {
                                                      setState(() {
                                                        isFollow =
                                                            jsonResponse['data']
                                                                ['isFollow'];
                                                        isFollow = false;
                                                      }),
                                                    }
                                                }
                                            }));
                                //("กดlike");
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 4.1,
                                height: 40.0,
                                child: Center(
                                  child: Text(
                                    '${isFollow == true ? "กำลังติดตาม" : "ติดตาม"}',
                                    style: TextStyle(
                                      color: isFollow == true
                                          ? MColors.primaryWhite
                                          : MColors.primaryColor,
                                      fontSize: 14.0,
                                      fontFamily: AppTheme.FontAnakotmaiBold,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: isFollow == true
                                        ? MColors.primaryColor
                                        : MColors.primaryWhite,
                                    border: Border.all(color: primaryColor),
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(20))),
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.person,
                              color: MColors.primaryColor,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              '$pagefollowers พัน',
                              style: TextStyle(
                                  color: MColors.primaryColor,
                                  fontSize: 16.0,
                                  fontFamily: AppTheme.FontAnakotmaiBold,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              'เกี่ยวกับ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontFamily: AppTheme.FontAnakotmaiMedium,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    pageobjslist.length == 0
                        ? SliverToBoxAdapter(child: Container())
                        : SliverToBoxAdapter(
                            child: Divider(
                            color: Colors.grey[200],
                            height: 20,
                            thickness: 8.0,
                          )),
                    pageobjslist.length == 0
                        ? SliverToBoxAdapter(child: Container())
                        : SliverToBoxAdapter(
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                  'สิ่งที่กำลังทำใน 1 เดือนที่ผ่านมา',
                                  maxLines: 2,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: MColors.primaryBlue,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Anakotmai',
                                      fontSize: 17),
                                ),
                              ),
                            ),
                          ),
                    pageobjslist.length == 0
                        ? SliverToBoxAdapter(child: Container())
                        : SliverToBoxAdapter(
                            child: const SizedBox(
                            height: 5,
                          )),
                    pageobjslist.length == 0
                        ? SliverToBoxAdapter(child: Container())
                        : SliverToBoxAdapter(
                            child: Builder(builder: (BuildContext context) {
                              return SizedBox(
                                height: MediaQuery.of(context).size.height / 4,
                                child: Scrollbar(
                                  isAlwaysShown: true,
                                  controller: _scrollHolController,
                                  child: new ListView.builder(
                                      controller: _scrollHolController,
                                      physics: ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: pageobjslist.length,
                                      itemBuilder: (
                                        BuildContext context,
                                        int index,
                                      ) {
                                        final pageobj = pageobjslist[index];
                                        return InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                CupertinoPageRoute(builder:
                                                    (BuildContext context) {
                                              return Webview_EmergencySC(
                                                url:
                                                    "https://today.moveforwardparty.org/objective/${pageobj.id}?hidebar=true",
                                                texttitle: pageobj.title,
                                                iconimage: pageobj.iconUrl,
                                                checkurl:
                                                    "https://today.moveforwardparty.org/objective/",
                                              );
                                            }));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 10, top: 10, bottom: 10),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2.0,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(1),
                                                    blurRadius: 0.5,
                                                    spreadRadius: 0.5,
                                                  ),
                                                ]),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 11),
                                                  child: Container(
                                                      //-------------------รูปโปรไฟล์----------------//
                                                      //color: Colors.grey,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              6.5,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.85,
                                                      child: CircleAvatar(
                                                        radius: 20.0,
                                                        backgroundImage:
                                                            new CachedNetworkImageProvider(
                                                          'https://today-api.moveforwardparty.org/api${pageobj.iconUrl}/image',
                                                        ),
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10, left: 5),
                                                  child: Text(
                                                    pageobj.title,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Anakotmai-Bold',
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              );
                            }),
                          ),
                    SliverToBoxAdapter(
                        child: const SizedBox(
                      height: 5,
                    )),
                    SliverToBoxAdapter(
                        child: Divider(
                      color: Colors.grey[200],
                      height: 30,
                      thickness: 8.0,
                    )),
                    listpostss.length == 0
                        ? SliverToBoxAdapter(
                            child: Center(child: Text("ไม่มีโพส")))
                        : SliverToBoxAdapter(
                            child: StreamBuilder(
                              stream: _postsController.stream,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                // if (snapshot.connectionState ==
                                //     ConnectionState.waiting) {
                                //   return Center(
                                //       child: CupertinoActivityIndicator());
                                // }
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Scrollbar(
                                      isAlwaysShown: true,
                                      child: ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          // padding: const EdgeInsets.all(8.0),
                                          scrollDirection: Axis.vertical,
                                          itemCount: listpostss.length,
                                          itemBuilder: (
                                            BuildContext context,
                                            int index,
                                          ) {
                                            final nDataList1 =
                                                listpostss[index];

                                            return PostList(
                                                nDataList1.title,
                                                nDataList1.detail,
                                                pagename,
                                                nDataList1.createdDate,
                                                nDataList1.gallery,
                                                nDataList1.coverImage,
                                                nDataList1.id,
                                                nDataList1.story,
                                                nDataList1);
                                          }),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                    // listpostss.length == 0
                    //     ? SliverToBoxAdapter(child: Container())
                    //     : _isLoadMoreRunning == true
                    //         ? SliverToBoxAdapter(
                    //             child: Center(
                    //                 child: Container(
                    //               margin: EdgeInsets.only(),
                    //               child: CircularProgressIndicator(
                    //                   valueColor: AlwaysStoppedAnimation<Color>(
                    //                       MColors.primaryColor)),
                    //             )),
                    //           )
                    //         : SliverToBoxAdapter(
                    //             child: Container(),
                    //           ),
                    if (_hasNextPage == false)
                      SliverToBoxAdapter(
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.only(bottom: 20),
                          color: MColors.primaryWhite,
                          child: Center(
                            child: Text(
                                '${msgres == "Page Post Not Found" ? "ไม่มีโพสแล้ว" : 'กำลังโหลด'}',
                                style: TextStyle(fontSize: 14)),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
  }

  // Widget myAlbumCardPagepost(List<GalleryPostPageSS> list) {
  //   if (list.length >= 4) {
  //     return Container(
  //       height: MediaQuery.of(context).size.height / 2.6,
  //       width: MediaQuery.of(context).size.width / 1.0,
  //       child: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             getItems(list[0].signUrl, list[1].signUrl, 0, context),
  //             getItems(
  //                 list[2].signUrl, list[3].signUrl, list.length - 4, context),
  //           ],
  //         ),
  //       ),
  //     );
  //   } else if (list.length >= 3) {
  //     return Container(
  //       height: MediaQuery.of(context).size.height / 2.6,
  //       width: double.infinity,
  //       child: Center(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             getItems(list[0].signUrl, list[1].signUrl, 0, context),
  //             Expanded(
  //               child: getItems(list[2].signUrl, list[2].signUrl ?? "",
  //                   list.length - 3, context),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   } else if (list.length >= 2) {
  //     return Container(
  //       height: MediaQuery.of(context).size.height / 2.6,
  //       width: MediaQuery.of(context).size.width / 1.0,
  //       color: Colors.white,
  //       child: Center(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             getItems(list[0].signUrl, list[1].signUrl, 0, context),
  //           ],
  //         ),
  //       ),
  //     );
  //   } else if (list.length >= 1) {
  //     return Container(
  //       child: Center(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             list[0].signUrl != null

  //                 ? topImage(list[0].signUrl.toString())
  //                 : Container(),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  // }

  Widget mymultialbumcardpagepost(List<GalleryPostPageSS> list) {
    if (list.length >= 4) {
      return Container(
        height: MediaQuery.of(context).size.height / 2.6,
        width: MediaQuery.of(context).size.width / 1.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getItems(
                  "https://today-api.moveforwardparty.org/api${list[0].imageUrl}/image",
                  "https://today-api.moveforwardparty.org/api${list[1].imageUrl}/image",
                  0,
                  context),
              getItems(
                  "https://today-api.moveforwardparty.org/api${list[2].imageUrl}/image",
                  "https://today-api.moveforwardparty.org/api${list[3].imageUrl}/image",
                  list.length - 4,
                  context),
            ],
          ),
        ),
      );
    } else if (list.length >= 3) {
      return Container(
        height: MediaQuery.of(context).size.height / 2.6,
        width: double.infinity,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getItems(
                  "https://today-api.moveforwardparty.org/api${list[0].imageUrl}/image",
                  "https://today-api.moveforwardparty.org/api${list[1].imageUrl}/image",
                  0,
                  context),
              Expanded(
                child: getItems(
                    "https://today-api.moveforwardparty.org/api${list[2].imageUrl}/image",
                    "https://today-api.moveforwardparty.org/api${list[2].imageUrl}/image" ??
                        "",
                    list.length - 3,
                    context),
              ),
            ],
          ),
        ),
      );
    } else if (list.length >= 2) {
      return Container(
        height: MediaQuery.of(context).size.height / 2.6,
        width: MediaQuery.of(context).size.width / 1.0,
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getItems(
                  "https://today-api.moveforwardparty.org/api${list[0].imageUrl}/image",
                  "https://today-api.moveforwardparty.org/api${list[1].imageUrl}/image",
                  0,
                  context),
            ],
          ),
        ),
      );
    } else if (list.length >= 1) {
      return Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              list[0].imageUrl != null || list[0].imageUrl != ""
                  ? Image.network(
                      "https://today-api.moveforwardparty.org/api${list[0].imageUrl}/image")
                  : SizedBox.shrink(),
            ],
          ),
        ),
      );
    }
  }

  Widget PostList(
      String posttitle,
      String subtitle,
      String postbyname,
      DateTime dateTime,
      List<GalleryPostPageSS> gallery,
      String coverimage,
      String postid,
      story,
      nDataList1) {
    return Container(
      width: 200,
      color: MColors.containerWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // coverimage!=null? topImage(coverimage.toString()):
          //  gallery.length != 0 && gallery[0].signUrl != null && gallery[0].imageUrl!=null
          //      ? myAlbumCardPagepost(gallery)
          //      :
          gallery.length == 0
              ? Container()
              : InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SliderShowFullmages(
                          listImagesModel: gallery, current: 0))),
                  child: mymultialbumcardpagepost(gallery)),
          // gallery.length != 0 ? myAlbumCardPagepost(gallery) : Container(),
          // Image.network(gallery[0].signUrl),
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
                                  type: nDataList1.type,
                                  createdDate: dateTime,
                                  postby: pagename,
                                  imagepage: pageprofileimage,
                                  likeCount: nDataList1.likeCount,
                                  commentCount: nDataList1.commentCount,
                                  shareCount: nDataList1.shareCount,
                                  repostCount: 0,
                                  token: token,
                                  userid: userid,
                                ));
                          },
                          child: textreadstory('อ่านสตอรี่...')),
                    )
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: [
                  Flexible(
                    // width: MediaQuery.of(context).size.width/1.5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: authorpost(postbyname, context, dateTime, pageid,
                          "", "fasle", "false", "", false),
                    ),
                  ),
                  // SizedBox(
                  //   width: 2,
                  // ),
                  texttimetimestamp(dateTime),
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
                      children: [
                        PostButton(
                          icon: Icon(
                            Icons.favorite_outline,
                            color: MColors.primaryBlue,
                          ),
                          width: 0.14,
                          containerwidth: 3.4,
                          label: '${nDataList1.likeCount} ถูกใจ',
                          onTap: () {
                            HapticFeedback.lightImpact();
                            var jsonResponse;
                            print(nDataList1.post.islike);
                            token == null || token == ""
                                ? Navigate.pushPage(context, Loginregister())
                                : mode != "FB"
                                    ? setState(() {
                                        if (nDataList1.islike == false ||
                                            nDataList1.islike == null ||
                                            nDataList1.likeCount < 0) {
                                          nDataList1.islike = true;
                                          nDataList1.likeCount++;
                                          Api.islike(postid, userid, token, "");
                                        } else if (nDataList1.islike == true) {
                                          nDataList1.islike = false;
                                          nDataList1.likeCount--;
                                          Api.islike(postid, userid, token, "");
                                        }
                                      })
                                    : setState(() {
                                        if (nDataList1.islike == false ||
                                            nDataList1.islike == null ||
                                            nDataList1.likeCount < 0) {
                                          nDataList1.islike = true;
                                          nDataList1.likeCount++;
                                          Api.islike(
                                              postid, userid, token, "FB");
                                        } else if (nDataList1.islike == true) {
                                          nDataList1.islike = false;
                                          nDataList1.likeCount--;
                                          Api.islike(
                                              postid, userid, token, "FB");
                                        }
                                      });
                          },
                        ),
                        PostButton(
                          icon: Icon(
                            MdiIcons.commentOutline,
                            color: MColors.primaryBlue,
                          ),
                          label: '${nDataList1.commentCount} ความคิดเห็น',
                          width: 0.24,
                          containerwidth: 3.1,
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return PostDetailsSC(
                                    gallery: gallery,
                                    postid: postid,
                                    onfocus: true,
                                    story: story,
                                  );
                                },
                              ),
                            ),
                          },
                        ),
                        PostButton(
                          icon: Icon(
                            Icons.share,
                            color: MColors.primaryBlue,
                          ),
                          width: 0.12,
                          containerwidth: 3.5,
                          label: ' แชร์',
                          onTap: () {
                            Clipboard.setData(new ClipboardData(
                                    text:
                                        "https://today.moveforwardparty.org/post/$postid"))
                                .then((_) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: MColors.primaryColor,
                                content: Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: MColors.primaryWhite,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  Text('คัดลอกลิงค์',style: TextStyle(fontFamily: AppTheme.FontAnakotmaiMedium),)
                                  ],
                                ),
                                duration: const Duration(milliseconds: 1000),
                              ));
                            });
                          },
                        ),
                      ],
                    ),
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
    );
  }
}
