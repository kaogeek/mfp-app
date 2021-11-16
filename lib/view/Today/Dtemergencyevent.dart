import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfp_app/Api/Api.dart';

import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/model/EmergencyEventModel.dart';
import 'package:mfp_app/model/searchpostlistModel.dart';

class DTEmergenSc extends StatefulWidget {
  final String hashtagstitle;
  final String emergencyEventId;
  const DTEmergenSc({
    Key key,
    this.hashtagstitle,
    this.emergencyEventId,
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

  StreamController _postsController;
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
                          // _postsController.add(i),
                          // newicon=i['standardItem']['imageURL'],
                        },

                      setState(() {
                        isLoading = false;
                      }),
                    }
                });
      } finally {
        // TODO
      }
    });

    _postsController = new StreamController();

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
              primaryAppBar(context,""),
              AppBardetail( context, 
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
        ),),
              SliverToBoxAdapter(
                child: FutureBuilder(
                  future: Future.wait([getDataList]),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CupertinoActivityIndicator());
                            }
                    return Builder(
                      builder: (BuildContext context) {
                        return ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            // padding: const EdgeInsets.all(8.0),
                            scrollDirection: Axis.vertical,
                            itemCount: listeEmergency.length,
                            itemBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              final nDataList1 = listeEmergency[index];
                              print(listeEmergency.length);
                              // print(nDataList1.hashTagName);
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
                              child: new Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 15),
                                child: Container(
                                  color: Colors.white,

                                  width: 170,
                                  height: 200,
                                  // alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      e.standardItem.imageUrl != null
                                          ? new CachedNetworkImage(
                                              imageUrl:
                                                  "https://today-api.moveforwardparty.org/api${e.standardItem.imageUrl}/image",
                                              placeholder: (context, url) =>
                                                  new CupertinoActivityIndicator(),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8)),
                                                      ),
                                                      child: new Image.asset(
                                                          'images/placeholder.png')),
                                            )
                                          : new SizedBox.shrink(),
                                      Container(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                            '${e.quantity}/ ${e.fulfillQuantity}'),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween, //Center Row contents horizontally,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                                '${e.name == null ? "" : e.name}'),
                                          ),
                                          Text('${e.unit}'),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
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
                                                      Color>(Colors.green),
                                            ),
                                            child: Text(
                                              'เติมเต็ม',
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  color: MColors.primaryWhite),
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                
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
                      onPressed: () {},
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
    // String followedCount,
    // String subtitle,
    // // List<Gallery> gallery,
    // int likeCount,
    // int commentCount,
    // int shareCount,
    // String postid,
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
                // child: new Image.network(
                //  "https://today-api.moveforwardparty.org/api$coverImage/image",
                //   filterQuality: FilterQuality.low,
                // ),
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
                                    nDataList1.fulfillmentCount.toString(),
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
                      'ติดตาม',
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
                      'ติดตาม',
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
