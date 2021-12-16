import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/CarouselsLoading.dart';
import 'package:mfp_app/allWidget/PostButton.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/allWidget/fontsize.dart';
import 'package:mfp_app/allWidget/sizeconfig.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/model/postlistSSmodel.dart';
import 'package:mfp_app/model/usermodel.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/view/Auth/login-register.dart';
import 'package:http/http.dart' as Http;
import 'package:mfp_app/view/Profile/profile.dart';
import 'package:mfp_app/view/Search/Search.dart';
import 'package:mfp_app/view/Today/story_page.dart';

class Profliess extends StatefulWidget {
  final String id;
  final String image;
  const Profliess({
    Key key,
    this.id,
    this.image,
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();
  int _currentMax = 5;
  bool islike = false;

  bool isLoading = true;
  var story;
  TextEditingController _detailController = TextEditingController();
  bool _isLoadMoreRunning = false;

  int page = 5;
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refresherKey = GlobalKey();

  var followers = 0;

  var coverURL;
  bool isFollow = false;

  String userid = "";

  var datagetuserprofile;

  var image;

  var pagecoverURL;

  var pagefollowers = 0;

  var pageprofileimage = "";
  var pagename = "";
  var pageUsername = "";

  var pageid="";

  @override
  void initState() {
    print('initState');
    _scrollController.addListener(_loadMore);

    Future.delayed(Duration.zero, () async {
      print('delayedgetpost');
      //-----token----
      token = await Api.gettoke();
      print('token$token');
      //----userid-----
      userid = await Api.getmyuid();
      print('userid$userid');
      //--getPage
      await Api.getPage(widget.id).then((responseData) async => ({
            if (responseData.statusCode == 200)
              {
                datagetuserprofile = jsonDecode(responseData.body),
                print('datagetuserprofile$datagetuserprofile'),
                setState(() {
                  pageid=datagetuserprofile["data"]["id"];
                  pageUsername = datagetuserprofile["data"]["pageUsername"];
                  pageprofileimage = datagetuserprofile["data"]["imageURL"];
                  pagename = datagetuserprofile["data"]["name"];
                  pagecoverURL = datagetuserprofile["data"]["coverURL"];
                  pagefollowers = datagetuserprofile["data"]["followers"];
                }),
                print('pageUsername$pageUsername'),
              }
          }));
      //---getuserprofile
      await Api.getuserprofile(userid).then((responseData) async => ({
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
          }));
      //--checkisFollow
      Api.getpagess(userid, token, widget.id).then((responseData) async => ({
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

                  print('isFollow$isFollow');
                }),
              }
          }));
      await _getPostListSS(pageUsername, _currentMax);
    });
    super.initState();
    _postsController = new StreamController();
  }

  @override
  void dispose() {
    _trackingScrollController.dispose();
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

    print('getPostListSS');
    print(responseData.body);
    if (responseData.statusCode == 200) {
      setState(() {
        isLoading = true;
      });
      dataht = jsonDecode(responseData.body);
      for (var i in dataht["data"]["posts"]) {
        // i["story"] = '',

        listpostss.add(PostPageSS.fromJson(i));
        // story = dataht["data"]["story"]["story"],
        // print('story$story'),
        _postsController.add(dataht);
        print(listpostss.length);
      }
      setState(() {
        isLoading = false;
      });

      // loading = false,
    } else if (responseData.statusCode == 400) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _loadMore() async {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      print('AT end');
      await new Future.delayed(const Duration(milliseconds: 100));

      setState(() {
        _currentMax = _currentMax + 5;
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom

        try {
          _getPostListSS(pageUsername, _currentMax);
        } catch (err) {
          print('Something went wrong!');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              primaryAppBar(
                  context,
                  token,
                  userid,
                  image,
                  Search(),
                  ProfileSc(
                    userid: userid,
                    token: token,
                  )),
              SliverToBoxAdapter(
                  child: Divider(
                color: Colors.grey[100],
                height: 3,
                thickness: 3.0,
              )),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: MColors.primaryColor,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: CircleAvatar(
                              radius: 25.0,
                              backgroundImage: NetworkImage(
                                  "https://today-api.moveforwardparty.org/api$pageprofileimage/image"),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  pagename,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontFamily: 'Anakotmai',
                                      fontWeight: FontWeight.bold),
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
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    Stack(
                      overflow: Overflow.visible,
                      alignment: Alignment.center,
                      children: <Widget>[
                        pagecoverURL == null
                            ? Container()
                            : Image.network(
                                "https://today-api.moveforwardparty.org/api$pagecoverURL/image"),
                        // FadeInImage.assetNetwork(
                        //   placeholder: 'images/placeholder.png',
                        //   image:
                        //       ,
                        //   height: 180,
                        //   fit: BoxFit.cover,
                        // ),
                        Positioned(
                          bottom: -80.0,
                          child: CircleAvatar(
                            radius: 70.0,
                            backgroundImage: NetworkImage(
                                "https://today-api.moveforwardparty.org/api$pageprofileimage/image"),
                            backgroundColor: Colors.transparent,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                  child: Container(
                color: Colors.white,
                height: 200,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
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
                    Padding(
                      padding: const EdgeInsets.only(top: 65.0),
                      child: Center(
                        child: Text(
                          '@$pageUsername',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                            fontFamily: 'Anakotmai',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              SliverToBoxAdapter(
                  child: Divider(
                color: Colors.transparent,
                height: 3,
                thickness: 6.0,
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
                              ? Navigate.pushPage(context, Loginregister())
                              : await Api.isfollowpage(
                                      widget.id, userid, token)
                                  .then((value) => ({
                                        jsonResponse = jsonDecode(value.body),
                                        print(
                                            'message${jsonResponse['message']}'),
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
                                            else if (jsonResponse['message'] ==
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
                          print("กดlike");
                        },
                        child: Container(
                          width: 110.0,
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
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 1,
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.4,
                                height:
                                    MediaQuery.of(context).size.height / 5.8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[100],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        blurRadius: 0.5,
                                        spreadRadius: 0.5,
                                      ),
                                    ]),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 11),
                                      child: CircleAvatar(
                                        radius: 40.0,
                                        backgroundImage: NetworkImage(
                                            'https://via.placeholder.com/150'),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        '#น้ำท่วม',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Anakotmai-Bold',
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.4,
                                height:
                                    MediaQuery.of(context).size.height / 5.8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[100],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        blurRadius: 0.5,
                                        spreadRadius: 0.5,
                                      ),
                                    ]),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 11),
                                      child: CircleAvatar(
                                        radius: 40.0,
                                        backgroundImage: NetworkImage(
                                            'https://via.placeholder.com/150'),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    Text(
                                      '# WALKTODAY',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Anakotmai-Bold',
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                height: 15,
                thickness: 6.0,
              )),
              listpostss.length == 0
                  ? SliverToBoxAdapter(child: Center(child: Text("ไม่มีโพส")))
                  : SliverToBoxAdapter(
                      child: StreamBuilder(
                        stream: _postsController.stream,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CupertinoActivityIndicator());
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
                                    itemCount: listpostss.length,
                                    itemBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      // if (listModelPostClass.length == 0) {
                                      //   return Center(
                                      //       child: CupertinoActivityIndicator());
                                      // }
                                      final nDataList1 = listpostss[index];

                                      //   if(fistload==true){
                                      // if (index == listModelPostClass.length - 3) {

                                      // return  BuildRecommendedUserPage();
                                      //  }
                                      // }else{
                                      //   return SizedBox.shrink();
                                      // }

                                      return PostList(
                                          nDataList1.title,
                                          nDataList1.detail,
                                          pagename,
                                          nDataList1.createdDate,
                                          nDataList1.gallery,
                                          nDataList1.likeCount,
                                          nDataList1.commentCount,
                                          nDataList1.shareCount,
                                          nDataList1.coverImage,
                                          nDataList1.id,
                                          nDataList1.story,
                                          nDataList1.type);
                                    }),
                              );
                            },
                          );
                        },
                      ),
                    ),
              listpostss.length == 0
                  ? SliverToBoxAdapter(child: Container())
                  : _isLoadMoreRunning == true
                      ? SliverToBoxAdapter(
                          child: Center(
                              child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    MColors.primaryColor)),
                          )),
                        )
                      : SliverToBoxAdapter(child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  Widget myAlbumCardPagepost(List<GalleryPostPageSS> list) {
    if (list.length >= 4) {
      return Container(
        height: MediaQuery.of(context).size.height / 2.6,
        width: MediaQuery.of(context).size.width / 1.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getItems(list[0].signUrl, list[1].signUrl, 0, context),
              getItems(
                  list[2].signUrl, list[3].signUrl, list.length - 4, context),
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
              getItems(list[0].signUrl, list[1].signUrl, 0, context),
              Expanded(
                child: getItems(list[2].signUrl, list[2].signUrl ?? "",
                    list.length - 3, context),
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
              getItems(list[0].signUrl, list[1].signUrl, 0, context),
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
              // Padding(
              //   padding: EdgeInsets.only(
              //       left: 10.0, top: 2),
              //   child: Text(
              //     name,
              //     style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 14,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
              list[0].signUrl != null
                  ?
                  // Hero(
                  //   tag:"image"+ list[0].signUrl.toString(),
                  //   child:
                  topImage(list[0].signUrl.toString())
                  // CachedNetworkImage(
                  //     imageUrl: 'https://via.placeholder.com/350x150',
                  //     placeholder: (context, url) =>
                  //         new CupertinoActivityIndicator(),
                  //     errorWidget: (context, url, error) => Container(
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.all(Radius.circular(8)),
                  //       ),
                  //       child:Image(image: CachedNetworkImageProvider(list[0].signUrl),)
                  //     ),
                  //   )
                  : Container(),
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
    int likeCount,
    int commentCount,
    int shareCount,
    String coverimage,
    String postid,
    story,
    String type,
  ) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 200,
        color: MColors.containerWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // coverimage!=null? topImage(coverimage.toString()):
            gallery.length != 0 || coverimage != null
                ? myAlbumCardPagepost(gallery)
                : topImage(coverimage.toString()),

            // gallery.length != 0 ? myAlbumCardPagepost(gallery) : Container(),
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
                                      postby: pageUsername,
                                      imagepage: pageprofileimage,
                                      likeCount: likeCount,
                                      commentCount: commentCount,
                                      shareCount: shareCount,
                                      repostCount: 0,
                                      userid: userid,
                                      token: token,
                                    ));
                              },
                              child: textreadstory('อ่านสตอรี่..')),
                        )
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      fixtextauthor(),
                      authorpost(postbyname, context, dateTime, pageid, "", "fasle",
                          false, "false", false, "", true),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            islike == false
                                ? PostButton(
                                    icon: Icon(
                                      Icons.favorite_outline,
                                      color: MColors.primaryBlue,
                                    ),
                                    width: 8.0,
                                    label: '$likeCount ถูกใจ',
                                    onTap: () async {
                                      HapticFeedback.lightImpact();

                                      var jsonResponse;
                                      token == "" || token == null
                                          ? Navigate.pushPage(
                                              context, Loginregister())
                                          : await Api.islike(
                                                  postid, userid, token, "")
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

                                                              likeCount++;
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

                                                              likeCount--;
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
                                    ),
                                    label: '$likeCount ถูกใจ',
                                    width: 8.0,
                                    onTap: () async {
                                      HapticFeedback.lightImpact();

                                      var jsonResponse;
                                      token == null
                                          ? Navigate.pushPage(
                                              context, Loginregister())
                                          : await Api.islike(
                                                  postid, userid, token, "")
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

                                                              likeCount++;
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

                                                              likeCount--;
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
                              ),
                              label: '$commentCount ความคิดเห็น',
                              width: 4.2,
                              onTap: () => print('Comment'),
                            ),
                            PostButton(
                              icon: Icon(
                                Icons.share,
                                color: MColors.primaryBlue,
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
}
