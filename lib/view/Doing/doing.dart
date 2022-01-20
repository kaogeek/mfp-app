import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/CarouselsLoading.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/model/pagemodel.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/view/Profile/profile.dart';
import 'package:mfp_app/view/Search/search.dart';
import 'package:mfp_app/view/Today/webview_emergency.dart';

class DoingSC extends StatefulWidget {
  // DoingSC({Key? key}) : super(key: key);

  @override
  _DoingSCState createState() => _DoingSCState();
}

class _DoingSCState extends State<DoingSC> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  var token;

  var userid;

  var userimageUrl;

  var datagetuserprofile;

  var image;

  bool pageObjloading;

  var jsonResponse;
  List<PageObjective> pageobjslist = [];
  List<PageObjective> pagedoingobjslist = [];

  StreamController _pageobjController;
  StreamController _pagedoingobjController;

  Future getpageObj;
  DateTime backward;
  int _currentMax = 0;
  var msg = "";

  @override
  void initState() {
    DateTime currentDate = DateTime.now();

    Api.gettoke().then((value) => value({
          setState(() {
            token = value;
          }),
        }));
    //--
    Api.getmyuid().then((value) => ({
          setState(() {
            userid = value;
          }),
        }));
    _trackingScrollController.addListener(_loadMore);

    Future.delayed(Duration.zero, () async {
      //--
      await Api.getuserprofile("$userid").then((responseData) async => ({
            if (responseData.statusCode == 200)
              {
                datagetuserprofile = jsonDecode(responseData.body),
                setState(() {
                  image = datagetuserprofile["data"]["imageURL"];
                }),
              }
          }));
      //--\
      await Api.getimageURL().then((value) => ({
            setState(() {
              userimageUrl = value;
            }),
          }));
      //--
    });
    getpageObj = Api.getdoing(Jiffy(currentDate).subtract(months: 1))
        .then((responseData) async => ({
              setState(() {
                pageObjloading = true;
              }),
              if (responseData.statusCode == 200)
                {
                  jsonResponse = jsonDecode(responseData.body),
                  for (Map i in jsonResponse["data"])
                    {
                      setState(() {}),
                      pageobjslist.add(PageObjective.fromJson(i)),
                      _pageobjController.add(responseData),
                    },
                  setState(() {
                    pageObjloading = false;
                  }),
                }
              else if (responseData.statusCode == 400)
                {}
            }));
    Api.getobjectivdoinge(0).then((responseData) async => ({
          setState(() {
            pageObjloading = true;
          }),
          if (responseData.statusCode == 200)
            {
              jsonResponse = jsonDecode(responseData.body),
              // print('jsonResponse$jsonResponse'),
              for (Map i in jsonResponse["data"])
                {
                  setState(() {}),
                  pagedoingobjslist.add(PageObjective.fromJson(i)),
                  _pagedoingobjController.add(responseData),
                },

              setState(() {
                pageObjloading = false;
              }),
            }
          else if (responseData.statusCode == 400)
            {}
        }));
    _pagedoingobjController = new StreamController();
    _pageobjController = new StreamController();
    super.initState();
  }

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  void _loadMore() async {
    if (_trackingScrollController.offset >=
            _trackingScrollController.position.maxScrollExtent &&
        !_trackingScrollController.position.outOfRange) {
      setState(() {
        _currentMax = _currentMax + 5;
      });

      try {
        await Api.getobjectivdoinge(_currentMax).then((responseData) async => ({
              setState(() {
                pageObjloading = true;
              }),
              if (responseData.statusCode == 200)
                {
                  jsonResponse = jsonDecode(responseData.body),
                  // print('jsonResponse$jsonResponse'),

                  for (Map i in jsonResponse["data"])
                    {
                      setState(() {}),
                      pagedoingobjslist.add(PageObjective.fromJson(i)),
                      _pagedoingobjController.add(responseData),
                    },
                  if (jsonResponse["message"] == "Cannot Search PageObjective")
                    {
                      setState(() {
                        msg = "ไม่มีข้อมูล";
                      }),
                    },
                  setState(() {
                    pageObjloading = false;
                  }),
                }
              else if (responseData.statusCode == 400)
                {}
            }));
      } catch (err) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            controller: _trackingScrollController,
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            slivers: <Widget>[
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
                child: Container(
                  color: primaryColor,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'สิ่งที่ "พรรคก้าวไกล" กำลังทำอยู่',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppTheme.FontAnakotmaiLight,
                          fontSize: 19),
                    ),
                  ),
                ),
              ),
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
                          fontFamily: AppTheme.FontAnakotmaiLight,
                          fontSize: 17),
                    ),
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return FutureBuilder(
                      future: Future.wait([getpageObj]),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return CarouselLoading();
                        }
                        return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.all(8),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            var e = pageobjslist[index];
                            return InkWell(
                              onTap: () async {
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (BuildContext context) {
                                  return Webview_EmergencySC(
                                    url:
                                        "https://today.moveforwardparty.org/objective/${e.id}?hidebar=true",
                                    texttitle: e.title,
                                    iconimage: e.iconUrl,
                                    checkurl:
                                        "https://today.moveforwardparty.org/post/",
                                  );
                                }));
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                height: MediaQuery.of(context).size.height / 15,
                                width: MediaQuery.of(context).size.width / 15,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 55.0,
                                      backgroundImage: CachedNetworkImageProvider(
                                          'https://today-api.moveforwardparty.org/api${e.iconUrl}/image'),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Center(
                                        child: Text(
                                          "#${e.hashTag}",
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily:
                                                  AppTheme.FontAnakotmaiBold,
                                              fontSize: 15,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  childCount: 1,
                ),
              ),
              SliverToBoxAdapter(
                  child: Divider(
                color: Colors.grey[200],
                height: 10,
                thickness: 9,
              )),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, bottom: 10),
                    child: Text(
                      'สิ่งที่ทำที่เคยทำมา',
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: MColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppTheme.FontAnakotmaiLight,
                          fontSize: 17,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: StreamBuilder(
                  stream: _pagedoingobjController.stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Builder(builder: (BuildContext context) {
                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        // padding: const EdgeInsets.all(8.0),
                        scrollDirection: Axis.vertical,
                        itemCount: pagedoingobjslist.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = pagedoingobjslist[index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (BuildContext context) {
                                return Webview_EmergencySC(
                                  url:
                                      "https://today.moveforwardparty.org/objective/${data.id}?hidebar=true",
                                  texttitle: data.title,
                                  iconimage: data.iconUrl,
                                  checkurl:
                                      "https://today.moveforwardparty.org/post/",
                                );
                              }));
                            },
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        bottom: 2,
                                        top: 10),
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height /
                                        7.3,
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
                                    child: Stack(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(12),
                                          child: CircleAvatar(
                                              radius: 36.0,
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                      'https://today-api.moveforwardparty.org/api${data.iconUrl}/image')),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 95),
                                              child: Text(
                                                "#${data.hashTag}",
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: AppTheme
                                                      .FontAnakotmaiLight,
                                                  fontSize: 18,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 95),
                                                child: Text(
                                                  data.title,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15,
                                                      fontFamily: AppTheme
                                                          .FontAnakotmaiLight,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    });
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Text(msg),
              ),
              SliverToBoxAdapter(
                  child: Divider(
                color: Colors.transparent,
                height: 10,
                thickness: 6.0,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
