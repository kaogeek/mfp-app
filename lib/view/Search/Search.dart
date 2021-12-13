import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/allWidget/circle_button.dart';
import 'package:mfp_app/animation/FadeAnimation.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/model/pagemodel.dart';
import 'package:mfp_app/model/searchhastag.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/view/Auth/login-register.dart';
import 'package:mfp_app/view/Profile/Profile.dart';
import 'package:mfp_app/view/Profile/Profliess.dart';

class Search extends StatefulWidget {
  final String userid;
  bool isOpen;

  Search({
    Key key,
    this.userid,
    this.isOpen,
  }) : super(key: key);
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
  bool isOpen = false;

  var image;

  var datagetuserprofile;

  var userid1;
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
                        userid1 = datagetuserprofile["data"]["id"];
                        // email =
                        //     datagetuserprofile["data"]["email"];
                        image = datagetuserprofile["data"]["imageURL"];
                      }),
                      print('image$image'),
                    }
                })),
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
    var url = Uri.parse("${Api.url}api/main/search");
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
        setState(() {
          listSearchHastag.add(SearchHastag.fromJson(i));
        });
        print('listSearchHastagจำนวน${listSearchHastag.length}');
        print('_searchResult${_searchResult.length}');
      }

      loading = false;
    }
  }

  getpage(String pageid) async {
    Future.delayed(Duration(seconds: 10));
    print('getPageisvalue$pageid');
    final headers = {
      // "limit": 1,
      // "count": false,
      // "whereConditions": {"isHideStory": false},
      "content-type": "application/json"
    };
    // print('getData');

    try {
      final responseData = await http
          .get(Uri.parse("${Api.url}api/page/$pageid"), headers: headers);
      if (responseData.statusCode == 200) {
        setState(() {
          loading = true;
        });
        if (responseData.statusCode == 200) {
          var dataht1 = jsonDecode(responseData.body);
          print('listPageModel${dataht1["data"]}');
          if (isType == "PAGE") {
            setState(() {
              _listPageModel.add(PageModel.fromJson(dataht1["data"]));
            });
            print('listPageModellength${_listPageModel.length}');
          }

          loading = false;
          print('body$dataht1');
          print('responseDatagetpage${responseData.body}');
        }
      } else if (responseData.statusCode == 404) {
        throw Exception('Not Found');
      }
    } on Exception catch (e) {
      // TODO
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
              SliverAppBar(
                brightness: Brightness.light,
                backgroundColor: Colors.white,
                title: InkWell(
                  onTap: null,
                  //  () => Navigator.pop(context),
                  child: Image.asset(
                    'images/Group 10673.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                automaticallyImplyLeading: false,
                centerTitle: false,
                floating: true,
                actions: [
                  CircleButton(
                    icon: Icons.search,
                    color: MColors.primaryColor,
                    iconSize: 27.0,
                    onPressed: () => null,
                  ),
                  CircleButton(
                    icon: MdiIcons.bellOutline,
                    color: MColors.primaryBlue,
                    iconSize: 27.0,
                    onPressed: () => print('Messenger'),
                  ),
                  token != "" && token != null
                      ? InkWell(
                          onTap: () {
                            Navigate.pushPage(
                                context,
                                ProfileSc(
                                  userid: userid,
                                  token: token,
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              radius: 25.0,
                              backgroundImage: NetworkImage(
                                  'https://today-api.moveforwardparty.org/api$image/image'),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.white70,
                            child: IconButton(
                              iconSize: 30,
                              icon: (Icon(
                                CupertinoIcons.person_crop_circle,
                                color: MColors.primaryBlue,
                              )),
                              onPressed: () {
                                Navigate.pushPage(context, Loginregister());
                              },
                            ),
                          ),
                        )
                ],
              ),
              SliverToBoxAdapter(
                  child: Divider(
                color: Colors.transparent,
                height: 3,
                thickness: 6.0,
              )),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
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
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  onChanged: (text) async {
                                    if (text == "") {
                                      print("controllerวางจริง");
                                      setState(() {
                                        _listPageModel.clear();

                                        isvalue = "";

                                        controller.clear();
                                        listSearchHastag.clear();
                                        _searchResult.clear();
                                      });
                                    }

                                    if (text.isEmpty) {
                                      print("onChangedวางจริง");
                                      setState(() {
                                        _listPageModel.clear();

                                        isvalue = "";

                                        controller.clear();
                                        listSearchHastag.clear();
                                        _searchResult.clear();
                                      });
                                    }
                                    setState(() {
                                      _searchResult.clear();
                                      _listPageModel.clear();
                                    });
                                    Future.delayed(
                                        const Duration(milliseconds: 1000), () {
                                      setState(() {
                                        text = text.toLowerCase();
                                      });
                                    });

                                    if (controller.text != "") {
                                      setState(() {
                                        _searchResult =
                                            listSearchHastag.where((ht) {
                                          // distinctIds = _searchResult.toSet().toList();
                                          // print('distinctIds${distinctIds.length}');
                                          var htlable = ht.label.toLowerCase();
                                          return htlable.contains(
                                              controller.text.toLowerCase());
                                        }).toList();
                                      });
                                      setState(() {
                                        listSearchHastag.clear();
                                        _listPageModel.clear();
                                        // isvalue = "";
                                        //  _listPageModel.clear();
                                      });
                                      Future.delayed(
                                          const Duration(milliseconds: 2000),
                                          () async {
                                        await getdate(
                                            text.toLowerCase(), widget.userid);
                                        await getpage(isvalue);
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
                                  listSearchHastag.clear();
                                  _listPageModel.clear();
                                  setState(() {
                                    loading = true;
                                  });
                                  if (controller.text.isEmpty) {
                                    listSearchHastag.clear();
                                    _listPageModel.clear();
                                    isvalue = "";
                                  }

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
                                  height: 38,
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
                                    Icons.arrow_forward_ios_rounded,
                                    size: 18,
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
              ),
              SliverToBoxAdapter(
                  child: Divider(
                color: Colors.transparent,
                height: 3,
                thickness: 6.0,
              )),
              // loading == true
              //     ? SliverToBoxAdapter(
              //         child: Center(child: CupertinoActivityIndicator()))
              //     :
              listSearchHastag.length != 0 || controller.text != ""
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
                            return InkWell(
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
                                    Icons.arrow_forward_ios_rounded,
                                    size: 18,
                                    color: MColors.textDark,
                                  ),
                                  // subtitle: new Text('>>>${data.type}'),
                                ),
                                margin: const EdgeInsets.all(2.0),
                              ),
                            );
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
                          return InkWell(
                            onTap: () {
                              Navigate.pushPage(
                                  context,
                                  Profliess(
                                    id: data.id,
                                    image: data.imageUrl,
                                    name: data.name,
                                    isOfficial: data.isOfficial,
                                    pageUsername: data.pageUsername,
                                    userid: userid1,
                                  ));
                            },
                            child: Card(
                              child: new ListTile(
                                leading: new CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                      "https://today-api.moveforwardparty.org/api${data.imageUrl}/image"),
                                  backgroundColor: Colors.transparent,
                                ),
                                title: new Text('${data.name}'),
                                subtitle: new Text('@${data.pageUsername}'),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                  color: MColors.textDark,
                                ),
                              ),
                              margin: const EdgeInsets.all(0.0),
                            ),
                          );
                        },
                      ),
                    ),

            ],
          ),
        ),
      ),
    );
  }
}
