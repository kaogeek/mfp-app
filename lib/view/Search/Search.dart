import 'dart:async';
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
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/view/Auth/login-register.dart';
import 'package:mfp_app/view/Profile/Profile.dart';
import 'package:mfp_app/view/Profile/Profliess.dart';
import 'package:mfp_app/view/Search/post_search.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class Debouncer {
  int milliseconds;
  VoidCallback action;
  Timer timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class _SearchState extends State<Search> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();
  final _debouncer = Debouncer();

  var token;

  var userid;

  TextEditingController controller = new TextEditingController();
  List<SearchHastag> listSearchHastag = [];
  List<PageModel> _listPageModel = [];

  List<SearchHastag> _searchResult = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var loading = false;
  var loadingpage = false;

  var dataht;
  Future getHashtagList;
  ScrollController scrollController;

  var keyword, isType, isvalue;

  var myuid;
  bool isOpen = false;

  var image;

  var datagetuserprofile;

  var msg = "";
  bool isLoading = true;

  bool listisempty = false;

  List list = [];
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      token = await Api.gettoke();
      if (token == null) {
        setState(() {
          isLoading = false;
        });
      }
      userid = await Api.getmyuid();

      await Api.getuserprofile("$userid").then((responseData) async => ({
            setState(() {
              isLoading = true;
            }),
            if (responseData.statusCode == 200)
              {
                datagetuserprofile = jsonDecode(responseData.body),
                setState(() {
                  image = datagetuserprofile["data"]["imageURL"];
                  isLoading = false;
                }),
                //('image$image'),
              }
            else
              {
                isLoading = false,
              }
          }));
    });
  }

  @override
  void dispose() {
    _trackingScrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  getsearch(String quer, String userid) async {
    var pagetype;
    var pageid;
    // setState(() {
    //   loading = true;
    //   listSearchHastag.clear();
    //   _searchResult.clear();
    //   _listPageModel.clear();
    // });

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

    setState(() {
      loading = true;
         listSearchHastag.clear();
      _searchResult.clear();
      _listPageModel.clear();
        pagetype = "";
          pageid ="";
    });

    if (responseData.statusCode == 200) {
      dataht = jsonDecode(responseData.body);
      // print('dataht$dataht');

      for (Map i in dataht["data"]["result"]) {
        setState(() {
          listSearchHastag.add(SearchHastag.fromJson(i));
          pagetype = i["type"];
          pageid = i["value"];
          if (pagetype == "PAGE") {
            getpage(pageid);
          }
        });
      }

      setState(() {
        loading = false;
      });
    }
  }

  getpage(String pageid) async {
    //('getPageisvalue$pageid');
    setState(() {
      loadingpage = true;
      _listPageModel.clear();
    });
    final headers = {"content-type": "application/json"};
    try {
      final responseData = await http
          .get(Uri.parse("${Api.url}api/page/$pageid"), headers: headers);
      if (responseData.statusCode == 200) {
        var dataht1 = jsonDecode(responseData.body);

        setState(() {
          _listPageModel.add(PageModel.fromJson(dataht1["data"]));
        });
        setState(() {
          loadingpage = false;
        });
      } else if (responseData.statusCode == 404) {
        throw Exception('Not Found');
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                          onPressed: () => {
                             showAlertDialog(
                                    context,
                                    "พรรคก้าวไกล",
                                    "ระบบอยู่ในระหว่างการพัฒนา",
                                    "",
                                    1.5,
                                    5.5),
                          },
                        ),
                        token == null || token == ""
                            ? Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor: Colors.white70,
                                  child: IconButton(
                                    splashRadius: AppTheme.splashRadius,
                                    iconSize: 30,
                                    icon: (Icon(
                                      CupertinoIcons.person_crop_circle,
                                      color: MColors.primaryBlue,
                                    )),
                                    onPressed: () {
                                      Navigate.pushPage(
                                          context, Loginregister());
                                    },
                                  ),
                                ),
                              )
                            : InkWell(
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
                              ),
                      ],
                    ),
                    SliverToBoxAdapter(
                        child: Divider(
                      color: Colors.transparent,
                      height: 3,
                      thickness: 6.0,
                    )),
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
                              child: TextField(
                                controller: controller,
                                autofocus: false,
                                maxLines: 1,
                                
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(16),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: MColors.textDark,
                                    // size: 22,
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
                                onChanged: (text) async {
                                  // if (text == "" || controller.text == "") {
                                  //   //print("controllerวางจริง");
                                  //   setState(() {
                                  //     _listPageModel.clear();
                                  //     controller.clear();
                                  //     listSearchHastag.clear();
                                  //     _searchResult.clear();
                                  //   });
                                  // }
                                  _debouncer.run(() async {
                                    _searchResult =
                                        listSearchHastag.where((ht) {
                                      var htlable = ht.label.toLowerCase();
                                      return htlable.contains(
                                          controller.text.toLowerCase());
                                    }).toList();
                                     getsearch(text.toLowerCase(), userid);
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 1.0, right: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 16,
                              width: MediaQuery.of(context).size.width / 6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(21),
                                  color: primaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(1),
                                      blurRadius: 0.5,
                                      spreadRadius: 0.5,
                                    ),
                                  ]),
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 19,
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.zero,
                                onPressed: () async {
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
                                  await getsearch(
                                      controller.text.toLowerCase(), userid);
                                },
                                splashRadius: AppTheme.splashRadius,
                              ),
                            ),
                          ),
                        ],
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
                    controller.text != "" && listSearchHastag.length != 0
                        ? SliverToBoxAdapter(
                            child: new Builder(builder: (BuildContext context) {
                              return ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: listSearchHastag.length,
                                itemBuilder: (context, i) {
                                  var data = listSearchHastag[i];
                                  return  InkWell(
                                        onTap: () {
                                          if (data.type == "HASHTAG") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PostSearch(
                                                        label: data.label,
                                                      )),
                                            );
                                          }
                                          if (data.type == "PAGE") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Profliess(
                                                        id: data.value,
                                                      )),
                                            );
                                          }
                                        },
                                        child: Card(
                                          child: new ListTile(
                                            leading: data.historyId != null
                                                ? Icon(Icons.timer_outlined)
                                                : Icon(Icons.search_outlined),
                                            title: new Text('${data.label}'),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 18,
                                              color: MColors.textDark,
                                            ),
                                          ),
                                          margin: const EdgeInsets.all(2.0),
                                        ),
                                      );
                                     
                                },
                              );
                            }),
                          )
                        : SliverToBoxAdapter(
                            child: Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Center(
                                child: Text(isLoading==true ? '' : 'ไม่พบข้อมูล',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ))),
                          )),

                    loadingpage == true
                        ? SliverToBoxAdapter(
                            child: Center(child: CupertinoActivityIndicator()))
                        : controller.text != ""
                            ? SliverToBoxAdapter(
                                child: ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: _listPageModel.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var data = _listPageModel[index];
                                    return InkWell(
                                      onTap: () {
                                        Navigate.pushPage(
                                            context,
                                            Profliess(
                                              id: data.id,
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
                                          subtitle:
                                              new Text('@${data.pageUsername}'),
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
                              )
                            : SliverToBoxAdapter(child: Container()),
                  ],
                ),
              ),
            ),
          );
  }
}
