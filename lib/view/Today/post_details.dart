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
import 'package:mfp_app/model/commentlistmodel.dart';
import 'package:mfp_app/model/searchpostlistModel.dart';
import 'package:http/http.dart' as Http;
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/utils/timeutils.dart';
import 'package:mfp_app/view/Auth/login-register.dart';
import 'package:mfp_app/view/Profile/profile.dart';
import 'package:mfp_app/view/Search/search.dart';
import 'package:mfp_app/view/Today/story_page.dart';

class PostDetailsSC extends StatefulWidget {
  final String postid;
  final String authorposttext;
  final String posttitle;
  final String subtitle;
  final DateTime dateTime;
  final List gallery;
  int likeCount;
  final int commentCount;
  final int shareCoun;
  final String userimage;
  final String pageid;
  final String pageimage;
  final String pagename;
  final bool isFollow;
  final String pageUsername;
  final bool isOfficial;
  final bool onfocus;
  final story;
  final String type;

  PostDetailsSC(
      {Key key,
      this.postid,
      this.authorposttext,
      this.posttitle,
      this.subtitle,
      this.dateTime,
      this.gallery,
      this.likeCount,
      this.commentCount,
      this.shareCoun,
      this.userimage,
      this.pageid,
      this.pageimage,
      this.pagename,
      this.isFollow,
      this.pageUsername,
      this.isOfficial,
      this.onfocus,
      this.type,
      this.story})
      : super(key: key);

  @override
  _PostDetailsSCState createState() => _PostDetailsSCState();
}

class _PostDetailsSCState extends State<PostDetailsSC> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  var datagetuserprofile;

  var datapostsearch;

  var userid = "";

  var token = "";

  var mode = "";

  var postimage = "";

  var userprofileimage = "";

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  var loading = false;
  var dataht;

  List<CommentlistModel> listModel = [];
  TextEditingController _commentController = TextEditingController();
  TextEditingController _commenteditController = TextEditingController();
  bool islike = false;
  bool idedit = false;
  var jsonResponse;
  bool onref = false;
  StreamController _postsController;

  @override
  void didChangeDependencies() {
    setState(() {
      Api.getcommentlist(widget.postid, userid, token);
    });

    super.didChangeDependencies();
  }

  @override
  void initState() {
    print(widget.postid);
    Future.delayed(Duration.zero, () async {
      print('Futuredelayed');
      //--token
      token = await Api.gettoke();
      print('tokenhome$token');
      //--mode
      mode = await Api.getmodelogin();
      print('mode$mode');
      //--userid
      userid = await Api.getmyuid();
      print('userid$userid');
      //---getuserprofile
      await Api.getuserprofile(userid).then((responseData) async => ({
            if (responseData.statusCode == 200)
              {
                datagetuserprofile = jsonDecode(responseData.body),
                setState(() {
                  userprofileimage = datagetuserprofile["data"]["imageURL"];
                }),
              }
          }));
      //--getcommentlist
      await Api.getcommentlist(widget.postid, userid, token)
          .then((responseData) => ({
                setState(() {
                  loading = true;
                }),
                print('getHashtagData'),
                if (responseData.statusCode == 200)
                  {
                    dataht = jsonDecode(responseData.body),
                    print("comlist${dataht["data"]}"),
                    for (Map i in dataht["data"])
                      {
                        setState(() {
                          listModel.add(CommentlistModel.fromJson(i));
                          _postsController.add(responseData);
                        }),
                        print('listModel${listModel.length}'),
                      },
                    loading = false,
                  }
              }));
      //--.
      await Api.postsearch(userid, token, widget.postid, mode)
          .then((responseData) => ({
                setState(() {
                  loading = true;
                }),
                print('postsearch'),
                if (responseData.statusCode == 200)
                  {
                    datapostsearch = jsonDecode(responseData.body),
                    for (Map i in dataht["data"])
                      {
                        print('islike${i["isLike"]}'),
                        if (i["isLike"] == true)
                          {
                            setState(() {
                              islike = true;
                            }),
                            print('islike$islike'),
                          }
                        else if (i["isLike"] == false)
                          {
                            setState(() {
                              islike = false;
                            }),
                            print('islike$islike'),
                          }
                      },
                  }
              }));
    });
    _postsController = new StreamController();
    super.initState();
  }

  Future sendcomment(String postid, String mytoken, String mag, String myuid,
      String mode) async {
    print('sendcomment');

    var url = Uri.parse("${Api.url}api/post/$postid/comment");
    final headers = {
      "userid": myuid,
      "mode": mode,
      "content-type": "application/json",
      "accept": "application/json",
      "authorization": "Bearer $mytoken",
    };
    Map data = {
      "commentAsPage": myuid,
      "comment": mag,
    };
    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    print('body$body');
    print('responseDatacommentlist${responseData.body}');
    final jsonResponse = jsonDecode(responseData.body);
    if (responseData.statusCode == 200) {
      print(jsonResponse['status']);
      if (jsonResponse['status'] == 1) {
        setState(() {
          onref = true;
        });
      }
    }
  }

  Future<Null> _handleRefresh() async {
    setState(() {
      listModel.clear();
    });
    Api.getcommentlist(widget.postid, userid, token).then((responseData) => ({
          setState(() {
            loading = true;
          }),
          print('getHashtagData'),
          if (responseData.statusCode == 200)
            {
              dataht = jsonDecode(responseData.body),
              print("comlist${dataht["data"]}"),
              for (Map i in dataht["data"])
                {
                  setState(() {
                    listModel.add(CommentlistModel.fromJson(i));
                    _postsController.add(responseData);
                  }),
                  print('listModel${listModel.length}'),
                },
              setState(() {
                loading = false;
                onref = false;
              }),
            }
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (onref == true) {
      _handleRefresh();
    }
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: () => () async {
              print('RefreshIndicator');
              HapticFeedback.mediumImpact();

              _handleRefresh();
            }(),
            child: CustomScrollView(
              controller: _trackingScrollController,
              slivers: [
                primaryAppBar(
                    context,
                    token,
                    userid,
                    userprofileimage,
                    Search(),
                    ProfileSc(
                      userid: userid,
                      token: token,
                    )),
                AppBardetail(
                  context,
                  "โพสของ",
                  widget.authorposttext,
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

                ///-----------APPBAR-----------------//
                SliverToBoxAdapter(
                  child: PostList(
                      widget.posttitle,
                      widget.subtitle,
                      widget.authorposttext,
                      widget.dateTime,
                      widget.gallery,
                      widget.likeCount,
                      widget.commentCount,
                      widget.shareCoun,
                      widget.pageid,
                      widget.pageimage,
                      widget.pagename,
                      widget.isFollow,
                      widget.pageUsername,
                      widget.isOfficial,
                      widget.story),
                ),
                SliverToBoxAdapter(
                  child: buildcommentlist1(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget PostList(
      String posttitle,
      String subtitle,
      String authorposttext,
      DateTime dateTime,
      List gallery,
      int likeCount,
      int commentCount,
      int shareCount,
      String pageid,
      String pageimage,
      String pagename,
      bool isFollow,
      String pageUsername,
      bool isOfficial,
      story) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 200,
        color: MColors.containerWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            gallery[0].signUrl != null
                ? Hero(
                    tag: "image" + gallery[0].signUrl,
                    child: CachedNetworkImage(
                      imageUrl: gallery[0].signUrl,
                      placeholder: (context, url) =>
                          new CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: new Image.network(
                          gallery[0].signUrl,
                          filterQuality: FilterQuality.low,
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            // gallery.length != 0 ? _myAlbumCard(gallery) : SizedBox.shrink(),
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
                  widget.story != null
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                              onTap: () async {
                                Navigate.pushPage(
                                    context,
                                    StroyPageSc(
                                      postid: widget.postid,
                                      titalpost: posttitle,
                                      imagUrl: gallery,
                                      type: widget.type,
                                      createdDate: dateTime,
                                      postby: pagename,
                                      imagepage: pageimage,
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
                      authorpost(
                          authorposttext,
                          context,
                          dateTime,
                          widget.pageid,
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
                      // texttimetimestamp(dateTime),
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
                                      islike != true
                                          ? Icons.favorite_outline
                                          : Icons.favorite,
                                      color: MColors.primaryBlue,
                                    ),
                                    label: '${widget.likeCount} ถูกใจ',
                                    width: 8.0,
                                    onTap: () async {
                                      HapticFeedback.lightImpact();
                                      var jsonResponse;
                                      token == "" || token == null
                                          ? Navigate.pushPage(
                                              context, Loginregister())
                                          : await Api.islike(widget.postid,
                                                  userid, token, mode)
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

                                                              widget
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
                                                                      [
                                                                      'isLike'];

                                                              --widget
                                                                  .likeCount;
                                                            }),
                                                          }
                                                      }
                                                  }));
                                      print("กดlike");
                                    },
                                  )
                                : PostButton(
                                    icon: Icon(
                                      islike != true
                                          ? Icons.favorite_outline
                                          : Icons.favorite,
                                      color: MColors.primaryBlue,
                                    ),
                                    width: 8.0,
                                    label: '$likeCount ถูกใจ',
                                    onTap: () async {
                                      HapticFeedback.lightImpact();

                                      var jsonResponse;
                                      token == null
                                          ? Navigate.pushPage(
                                              context, Loginregister())
                                          : await Api.islike(widget.postid,
                                                  userid, token, mode)
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
                              width: 4.1,
                              label: '$commentCount ความคิดเห็น',
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
                  token == "" || token == null
                      ? Container()
                      : Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                radius: 25.0,
                                backgroundImage: userprofileimage != null
                                    ? NetworkImage(
                                        'https://today-api.moveforwardparty.org/api$userprofileimage/image')
                                    : NetworkImage(
                                        'https://via.placeholder.com/150'),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                height:
                                    MediaQuery.of(context).size.height / 14.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffDEDEDE),
                                  ),
                                  color: MColors.primaryWhite,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(9.0),
                                  ),
                                ),
                                child: TextFormField(
                                  controller: _commentController,
                                  onSaved: (String value) {},
                                  autofocus: widget.onfocus,
                                  onChanged: (String value) {
                                    _commenteditController.text = value;
                                    print(value);
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(20.0),
                                    hintText: "เขียนความคิดเห็น",
                                    suffixIcon: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween, // added line
                                      mainAxisSize:
                                          MainAxisSize.min, // added line
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(
                                            Icons.send,
                                            color: Colors.black,
                                          ),
                                          onPressed: () async {
                                            await sendcomment(
                                                widget.postid,
                                                token,
                                                _commentController.text,
                                                userid,
                                                mode);
                                            setState(() {
                                              _commentController.clear();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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

  Widget buildcommentlist1() {
    bool isLiked = false;
    return StreamBuilder(
      stream: _postsController.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: listModel.length,
          itemBuilder: (BuildContext context, int index) {
            var data = listModel[index];
            var commentid = data.id;
            _commenteditController.text = data.comment;
            return InkWell(
              onTap: () async {
                data.user.id == userid
                    ? showCupertinoModalPopup<void>(
                        context: context,
                        builder: (BuildContext context) => CupertinoActionSheet(
                              actions: <CupertinoActionSheetAction>[
                                CupertinoActionSheetAction(
                                  child: const Text('Edit'),
                                  onPressed: () {
                                    setState(() {
                                      idedit = true;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                CupertinoActionSheetAction(
                                  child: const Text('Delete',
                                      style: TextStyle(
                                        color: Colors.red,
                                      )),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            new CupertinoAlertDialog(
                                              title: new Text(
                                                "Delete Comment",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              actions: [
                                                CupertinoDialogAction(
                                                  isDefaultAction: true,
                                                  child: new Text("Cancel"),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                                CupertinoDialogAction(
                                                    child: new Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                    onPressed: () async {
                                                      Api.deletecomment(
                                                              widget.postid,
                                                              token,
                                                              commentid,
                                                              userid,
                                                              mode)
                                                          .then((value) => ({
                                                                if (value[
                                                                        'status'] ==
                                                                    1)
                                                                  {
                                                                    setState(
                                                                        () {
                                                                      onref =
                                                                          true;
                                                                    }),
                                                                  }
                                                              }));
                                                      Navigator.pop(context);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        backgroundColor:
                                                            Colors.green,
                                                        content: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.check,
                                                              color: MColors
                                                                  .primaryWhite,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text('Success')
                                                          ],
                                                        ),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    2500),
                                                      ));
                                                    }),
                                              ],
                                            ));
                                  },
                                )
                              ],
                              cancelButton: CupertinoActionSheetAction(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ))
                    : Container();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: new Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                            radius: 25,
                            foregroundImage: NetworkImage(data.user.imageUrl !=
                                    null
                                ? "https://today-api.moveforwardparty.org/api${data.user.imageUrl}/image"
                                : ""),
                            child: Icon(Icons.account_circle)),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.user.displayName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                  TimeUtils.readTimestamp(
                                      data.createdDate.millisecondsSinceEpoch),
                                  style: TextStyle(fontSize: 12)),
                              SizedBox(height: 8),
                              Text(data.comment,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 16))
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                child: IconButton(
                              icon: Icon(
                                  data.isLike != true
                                      ? Icons.favorite_border
                                      : Icons.favorite,
                                  color: MColors.primaryColor),
                              onPressed: () {
                                Api.islikecomment(widget.postid, userid, token,
                                        commentid, mode)
                                    .then((value) => ({
                                          jsonResponse = jsonDecode(value.body),
                                          print(
                                              'message${jsonResponse['message']}'),
                                          if (value.statusCode == 200)
                                            {
                                              if (jsonResponse['message'] ==
                                                  "Like Post Comment Success")
                                                {
                                                  setState(() {
                                                    data.likeCount++;
                                                    data.isLike = true;
                                                  }),
                                                }
                                              else if (jsonResponse[
                                                      'message'] ==
                                                  "UnLike Post Comment Success")
                                                {
                                                  setState(() {
                                                    data.likeCount--;
                                                    data.isLike = false;
                                                  }),
                                                }
                                            }
                                        }));
                              },
                            )),
                            IconButton(
                              icon: Icon(Icons.more_vert_outlined),
                              onPressed: () async {
                                data.user.id == userid
                                    ? showCupertinoModalPopup<void>(
                                        context: context,
                                        builder:
                                            (BuildContext context) =>
                                                CupertinoActionSheet(
                                                  actions: <
                                                      CupertinoActionSheetAction>[
                                                    CupertinoActionSheetAction(
                                                      child: const Text('Edit'),
                                                      onPressed: () {
                                                        setState(() {
                                                          idedit = true;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    CupertinoActionSheetAction(
                                                      child: const Text(
                                                          'Delete',
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                          )),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                new CupertinoAlertDialog(
                                                                  title:
                                                                      new Text(
                                                                    "Delete Comment",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  actions: [
                                                                    CupertinoDialogAction(
                                                                      isDefaultAction:
                                                                          true,
                                                                      child: new Text(
                                                                          "Cancel"),
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(context),
                                                                    ),
                                                                    CupertinoDialogAction(
                                                                        child:
                                                                            new Text(
                                                                          "Delete",
                                                                          style:
                                                                              TextStyle(color: Colors.red),
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          Api.deletecomment(widget.postid, token, commentid, userid, mode).then((value) =>
                                                                              ({
                                                                                if (value['status'] == 1)
                                                                                  {
                                                                                    setState(() {
                                                                                      onref = true;
                                                                                    }),
                                                                                  }
                                                                              }));
                                                                          Navigator.pop(
                                                                              context);
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(SnackBar(
                                                                            backgroundColor:
                                                                                Colors.green,
                                                                            content:
                                                                                Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.check,
                                                                                  color: MColors.primaryWhite,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Text('Success')
                                                                              ],
                                                                            ),
                                                                            duration:
                                                                                const Duration(milliseconds: 2500),
                                                                          ));
                                                                        }),
                                                                  ],
                                                                ));
                                                      },
                                                    )
                                                  ],
                                                  cancelButton:
                                                      CupertinoActionSheetAction(
                                                    child: const Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ))
                                    : Container();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey[100],
                      height: 5,
                      thickness: 6.0,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
