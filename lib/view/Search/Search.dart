import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/animation/FadeAnimation.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/model/pagemodel.dart';
import 'package:mfp_app/model/searchhastag.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String userid;

  const Search({Key key, this.userid}) : super(key: key);
  // ShopSC({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  var token;

  var userid;

  var userimageUrl;

  TextEditingController controller = new TextEditingController();
  List<SearchHastag> listSearchHastag = [];
  List<PageModel> _listPageModel = [];
  List<PageModel> _listPageModelResult = [];

  List<SearchHastag> _searchResult = [];

  List<SearchHastag> _searchinitiResult = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var loading = false;
  var dataht;
  Future getHashtagList;
  ScrollController scrollController;
  List _allResults = [];
  List _resultsList = [];
  List distinctIds = [];
  var keyword, isType, isvalue;

  var myuid;

  @override
  void initState() {
    print('initState');
    super.initState();
    setState(() {
      Api.gettoke().then((value) => value({
            token = value,
            print('token$token'),
          }));

      Api.getmyuid().then((value) => ({
            setState(() {
              userid = value;
            }),
            print('userid$userid'),
          }));
      Api.getimageURL().then((value) => ({
            setState(() {
              userimageUrl = value;
            }),
            print('userimageUrl$userimageUrl'),
          }));
    });
  }

  @override
  void dispose() {
    _trackingScrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  getdate(String quer, String userid) async {
    Future.delayed(Duration(seconds: 2));
    var url = "https://today-api.moveforwardparty.org/api/main/search";
    final headers = {
      // "mode": "EMAIL",
      "content-type": "application/json",
    };
    Map data = {
      "keyword": quer,
      "user": userid,
    };
    var body = jsonEncode(data);

    final responseData = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print('body$body');
    print('responseData${responseData.body}');
    setState(() {
      loading = true;
    });
    print('getHashtagList');
    if (responseData.statusCode == 200) {
      dataht = jsonDecode(responseData.body);
      print('data${dataht["data"]}');
      for (Map i in dataht["data"]["result"]) {
        // Future.delayed(Duration(seconds: 30));
        print('ispage${dataht["data"]["type"]}');

        print('isUser$isType');

        listSearchHastag.add(SearchHastag.fromJson(i));

        // if (listSearchHastag.indexOf(SearchHastag.fromJson(i)) <= -1) {
        // }
        // if (listSearchHastag.indexOf(SearchHastag.fromJson(i)) <= 0) {
        //   listSearchHastag.remove(listSearchHastag);
        // }

        print('listSearchHastagจำนวน${listSearchHastag.length}');
        print('_searchResult${_searchResult.length}');

        if (controller.text.isEmpty) {
          print("controllerวางจริง");
          listSearchHastag.clear();
        }
      }

      loading = false;
    }
  }

  getpage(String pageid) async {
    print('getPageisvalue$pageid');
    final headers = {
      // "limit": 1,
      // "count": false,
      // "whereConditions": {"isHideStory": false},
      "content-type": "application/json"
    };
    // print('getData');

    final responseData = await http.get(
        "https://today-api.moveforwardparty.org/api/page/$pageid",
        headers: headers);
    if (responseData.statusCode == 200) {
      setState(() {
        loading = true;
      });
      if (responseData.statusCode == 200) {
        var dataht1 = jsonDecode(responseData.body);
        print('listPageModel${dataht1["data"]}');
        if (isType == "PAGE") {
          _listPageModel.add(PageModel.fromJson(dataht1["data"]));
          print('listPageModellength${_listPageModel.length}');
        }

        loading = false;
        print('body$dataht1');
        print('responseDatagetpage${responseData.body}');
      }
    } else if (responseData.statusCode == 404) {
      throw Exception('Not Found');
    }
  }

  @override
  void didChangeDependencies() {
    getdate(controller.text.toLowerCase(), widget.userid);
    getpage(isvalue);

    print('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            controller: _trackingScrollController,
            slivers: [
              primaryAppBar(context, token, userid, userimageUrl),
              SliverToBoxAdapter(
                  child: Divider(
                color: Colors.transparent,
                height: 3,
                thickness: 6.0,
              )),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 60.0,
                              width: double.infinity,
                              padding: EdgeInsets.all(8),
                              color: Colors.white,
                              child: TextField(
                                controller: controller,
                                autofocus: false,
                                decoration: InputDecoration(
                                  // labelText: 'Search Something',
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: MColors.textDark,
                                  ),

                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  enabledBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                onChanged: (text) {
                                  if (controller.text.isEmpty) {
                                    print("controllerวางจริง");
                                    setState(() {
                                      controller.clear();
                                      listSearchHastag.clear();
                                      _listPageModel.clear();

                                      _searchResult.clear();
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  loading = true;
                                });
                                if (listSearchHastag.length != 0 ||
                                    _listPageModel.length != 0) {
                                  listSearchHastag.clear();
                                  _listPageModel.clear();
                                }
                                await getdate(controller.text.toLowerCase(),
                                    widget.userid);
                                await getpage(isvalue);
                              },
                              child: Container(
                                height: 40,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: primaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        blurRadius: 0.5,
                                        spreadRadius: 0.5,
                                      ),
                                    ]),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
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
                  child: Divider(
                color: Colors.transparent,
                height: 3,
                thickness: 6.0,
              )),
              loading == true
                  ? SliverToBoxAdapter(
                      child: Center(child: CupertinoActivityIndicator()))
                  : listSearchHastag.length != 0 || controller.text != ""
                      ? SliverToBoxAdapter(
                          child: new Builder(builder: (BuildContext context) {
                            return ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: listSearchHastag.length,
                              itemBuilder: (context, i) {
                                var data = listSearchHastag[i];
                                var istype = data.type;
                                var islabel = data.label;
                                isType = data.type;
                                if (isType == "PAGE") {
                                  isvalue = data.value;
                                }
                                print('isty$isType');
                                print("isva$isvalue");
                                return  FadeAnimation((1.0 + i) / 4, new InkWell(
                                  onTap: () {
                                    if (istype == "HASHTAG") {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => SearchList(
                                      //             type: istype,
                                      //             label: islabel,
                                      //           )),
                                      // );
                                    }
                                    if (istype == "PAGE") {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => SearchList(
                                      //             type: istype,
                                      //             label: islabel,
                                      //           )),
                                      // );
                                    }
                                  },
                                  child: Card(
                                    // shape: RoundedRectangleBorder(
                                    //     borderRadius: const BorderRadius.all(
                                    //   Radius.circular(15.0),
                                    // )),
                                    child: new ListTile(
                                      // leading: new CircleAvatar(
                                      //   backgroundImage: new NetworkImage(
                                      //     _userDetails[index].profileUrl,
                                      //   ),
                                      // ),
                                      title: new Text('${data.label}'),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        size: 28.0,
                                        color: MColors.textDark,
                                      ),
                                      // subtitle: new Text('>>>${data.type}'),
                                    ),
                                    margin: const EdgeInsets.all(2.0),
                                  ),
                            ));
                              },
                            );
                          }),
                        )
                      : SliverToBoxAdapter(child: Container()),
              loading == true
                  ? SliverToBoxAdapter(
                      child: Center(child: CupertinoActivityIndicator()))
                  : SliverToBoxAdapter(
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: _listPageModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = _listPageModel[index];
                          return  FadeAnimation((1.0 + index) / 4, new InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => ProfilessScreen(
                              //             id: data.id,
                              //             image: data.imageUrl,
                              //             name: data.name,
                              //           )),
                              // );
                            },
                            child: Card(
                              child: new ListTile(
                                leading: new CircleAvatar(
                                  radius: 48,
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    color: Colors.white,
                                    child: Image.network(
                                        "https://today-api.moveforwardparty.org/api${data.imageUrl}/image",
                                        width: 50,
                                        height: 50),
                                  ),
                                ),
                                title: new Text('${data.name}'),
                                subtitle: new Text('@${data.pageUsername}'),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 28.0,
                                  color: MColors.textDark,
                                ),
                              ),
                              margin: const EdgeInsets.all(0.0),
                            ),
                          ));
                        },
                      ),
                    )
              // : SliverToBoxAdapter(child: Container()),
              // SliverToBoxAdapter(
              //   child: Container(
              //     color: Colors.white,
              //     child: Row(
              //       children: <Widget>[
              //         Row(
              //           children: <Widget>[
              //             Padding(
              //               padding: EdgeInsets.all(12.0),
              //               child: CircleAvatar(
              //                 radius: 30.0,
              //                 backgroundImage: NetworkImage(
              //                     'https://via.placeholder.com/150'),
              //                 backgroundColor: Colors.transparent,
              //               ),
              //             ),
              //             SizedBox(
              //               width: 12.0,
              //             ),
              //             Padding(
              //               padding: EdgeInsets.only(
              //                   //top: 6.0,
              //                   ),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: <Widget>[
              //                   Text(
              //                     'ณัฐพงษ์  เรืองปัญญาวุฒิ',
              //                     style: TextStyle(
              //                         color: Colors.grey[700],
              //                         fontSize: 16.0,
              //                         fontFamily: 'Anakotmai',
              //                         fontWeight: FontWeight.bold),
              //                   ),
              //                   SizedBox(
              //                     height: 5,
              //                   ),
              //                   Text(
              //                     'กำลังทำสิ่งๆนี้อยู่',
              //                     style: TextStyle(
              //                         color: primaryColor,
              //                         fontSize: 14.0,
              //                         fontFamily: 'Anakotmai',
              //                         fontWeight: FontWeight.bold),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             Padding(
              //               padding: EdgeInsets.only(top: 14, left: 4.0),
              //               child: Container(
              //                 margin: EdgeInsets.only(left: 90),
              //                 child: Center(
              //                   child: Icon(Icons.arrow_forward_ios),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SliverToBoxAdapter(
              //     child: Divider(
              //   color: Colors.transparent,
              //   height: 3,
              //   thickness: 6.0,
              // )),
            ],
          ),
        ),
      ),
    );
  }
}
