import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mfp_app/Api/Api.dart';

import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/model/EmergencyEventModel.dart';
import 'package:mfp_app/model/searchpostlistModel.dart';
import 'package:mfp_app/view/Profile/profile.dart';
import 'package:mfp_app/view/Search/search.dart';

class DTEmergenSc extends StatefulWidget {
  final String hashtagstitle;
  final String emergencyEventId;
  final String userimage;
  final String token;
  final String userid;
  const DTEmergenSc({
    Key key,
    this.hashtagstitle,
    this.emergencyEventId,
    this.userimage,
    this.token,
    this.userid,
  }) : super(key: key);

  @override
  _DTemergenScState createState() => _DTemergenScState();
}

class _DTemergenScState extends State<DTEmergenSc> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  List<NeedItem> listeNeedModel = [];
  List<EmergencyEvent> listeEmergency = [];
  List<EmergencyEventModel> listeEmergencyEventModel = [];

  var dataht,
      datapostlist,
      myuid,
      dataht1,
      name = "",
      detail = "",
      followedCount = "",
      fulfillmentCount = "",
      fulfillmentUserCount = "",
      coverPageUrl,
      newicon;
  Future getDataList;
  bool isLoading = false;

  var image;

  var datagetuserprofile;

  var userid;

  @override
  void initState() {
    setState(() {
      try {
        getDataList =
            Api.getemergencycontent(widget.emergencyEventId).then((value) => {
                  if (value.statusCode == 200)
                    {
                      // setState(() {
                      //   isLoading = true;
                      // }),
                      print(value.body),
                      setState(() {
                        datapostlist = jsonDecode(value.body);
                        // print(datapostlist["data"]["followedCount"]);
                        // name =
                        //     datapostlist["data"]["emergencyEvent"]["hashTagName"];
                        // coverPageUrl = datapostlist["data"]["emergencyEvent"]
                        //     ["coverPageURL"];
                        //     detail = datapostlist["data"]["emergencyEvent"]
                        //     ["detail"];
                        // followedCount =datapostlist["data"]["followedCount"];
                        //  fulfillmentCount =datapostlist["data"]
                        // ["fulfillmentCount"];
                        //  fulfillmentUserCount =datapostlist["data"]
                        // ["fulfillmentUserCount"];
                      }),
                      listeEmergency.add(EmergencyEvent.fromJson(
                          datapostlist["data"]["emergencyEvent"])),
                      listeEmergencyEventModel.add(
                          EmergencyEventModel.fromJson(datapostlist["data"])),

                      for (Map i in datapostlist["data"]["needItems"])
                        {
                          listeNeedModel.add(NeedItem.fromJson(i)),
                        },

                      setState(() {
                        isLoading = false;
                      }),
                    }
                });

        Api.getmyuid().then((value) => ({
              setState(() {
                userid = value;
              }),
              Api.getuserprofile("$userid").then((responseData) async => ({
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
                  })),
              print('userid$userid'),
            }));
      } finally {
        // TODO
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            controller: _trackingScrollController,
            slivers: [
              primaryAppBar(
                  context,
                  widget.token,
                  "",
                  image,
                  Search(),
                  ProfileSc(
                    userid: widget.userid,
                    token: widget.token,
                  )),
              AppBardetail(
                context,
                "เหตุการณ์ด่วน ${widget.hashtagstitle}",
                "",
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: MColors.primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: FutureBuilder(
                  future: Future.wait([getDataList]),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CupertinoActivityIndicator());
                    }
                    return Builder(
                      builder: (BuildContext context) {
                        return ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: listeEmergency.length,
                            itemBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              final nDataList1 = listeEmergency[index];
                              print(listeEmergency.length);
                              return PostList(
                                nDataList1.hashTagName,
                                nDataList1.coverPageUrl,
                                nDataList1.title,
                              );
                            });
                      },
                    );
                  },
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  childAspectRatio: 2.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return FutureBuilder(
                      future: Future.wait([getDataList]),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: listeNeedModel.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            var e = listeNeedModel[index];

                            return Container(
                              color: Color(0xffF8F8F8),
                              child: Container(
                                color: Colors.white,
                                width: 170,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: new SvgPicture.network(
                                        'https://today.moveforwardparty.org/assets/img/customize_item.svg',
                                        width: 70,
                                        height: 70,
                                        semanticsLabel: 'A shark?!',
                                        placeholderBuilder:
                                            (BuildContext context) => Container(
                                                padding:
                                                    const EdgeInsets.all(30.0),
                                                child:
                                                    const CupertinoActivityIndicator()),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        '${e.quantity}/ ${e.fulfillQuantity}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween, //Center Row contents horizontally,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 25),
                                          child: Text(
                                            '${e.name == null ? "" : e.name}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        Text(
                                          '${e.unit}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                    e.active == true
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Container(
                                              width: 150,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  24.0,
                                              // color: Colors.green,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                              ),
                                              child: TextButton(
                                                style: ButtonStyle(
                                                  padding: MaterialStateProperty
                                                      .all<EdgeInsets>(
                                                          EdgeInsets.only(
                                                              bottom: 0)),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.green),
                                                ),
                                                child: Icon(
                                                  Icons.check,
                                                  color: MColors.primaryWhite,
                                                ),
                                                onPressed: null,
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Container(
                                              width: 150,
                                              height: 27,
                                              // color: Colors.green,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                              ),
                                              child: TextButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Colors.green
                                                              .withOpacity(
                                                                  0.2)),
                                                ),
                                                child: Text(
                                                  'เติมเต็ม',
                                                  style: TextStyle(
                                                      fontSize: 11.0,
                                                      color:
                                                          MColors.primaryWhite),
                                                ),
                                                onPressed: () {},
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
                  child: SizedBox(
                height: 15,
              )),
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFFFFE7D6),
                        ),
                      ),
                      child: Text(
                        'จุดเริ่มต้น',
                        style: TextStyle(
                            fontSize: 22.0, color: MColors.primaryColor),
                      ),
                      onPressed: null,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: SizedBox(
                height: 100,
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget PostList(
    String hashTagName,
    String coverImage,
    String title,
  ) {
    return InkWell(
      child: Container(
        width: 200,
        color: MColors.containerWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl:
                  "https://today-api.moveforwardparty.org/api$coverImage/image",
              filterQuality: FilterQuality.low,
              placeholder: (context, url) => new CupertinoActivityIndicator(),
              errorWidget: (context, url, error) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: new CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          'https://today-api.moveforwardparty.org/api$coverImage/image'),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text(
                      hashTagName,
                      style:
                          TextStyle(color: MColors.primaryColor, fontSize: 18),
                    ),
                    subtitle: Text(
                      title,
                      style:
                          TextStyle(color: MColors.primaryBlue, fontSize: 14),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Divider(),
            FutureBuilder(
              future: Future.wait([getDataList]),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Builder(
                  builder: (BuildContext context) {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        // padding: const EdgeInsets.all(8.0),
                        scrollDirection: Axis.vertical,
                        itemCount: listeEmergencyEventModel.length,
                        itemBuilder: (
                          BuildContext context,
                          int index,
                        ) {
                          final nDataList1 = listeEmergencyEventModel[index];
                          print(listeEmergencyEventModel.length);
                          // print(nDataList1.hashTagName);
                          return Padding(
                            padding: const EdgeInsets.only(left: 45, right: 45),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, //Center Row contents horizontally,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    nDataList1.followedCount.toString(),
                                    style: TextStyle(
                                        fontSize: 33,
                                        color: MColors.primaryBlue),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    nDataList1.fulfillmentCount.toString(),
                                    style: TextStyle(
                                        fontSize: 33,
                                        color: MColors.primaryBlue),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    nDataList1.fulfillmentUserCount.toString(),
                                    style: TextStyle(
                                        fontSize: 33,
                                        color: MColors.primaryBlue),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '0',
                                    style: TextStyle(
                                        fontSize: 33,
                                        color: MColors.primaryBlue),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45, right: 45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, //Center Row contents horizontally,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'ติดตาม',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'พูดถึง',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'บอกต่อ',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'แชร์',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
