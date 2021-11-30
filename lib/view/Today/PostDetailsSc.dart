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
import 'package:mfp_app/view/Profile/Profile.dart';
import 'package:mfp_app/view/Search/Search.dart';

class PostDetailsSC extends StatefulWidget {
  final String id;
  final String image;
  final String authorposttext;
  final String posttitle;
  final String subtitle;
  final DateTime dateTime;
  final List<Gallery> gallery;
 int likeCount;
  final int commentCount;
  final int shareCoun;
  final String userid;
  final String token;
  final String userimage;
final String pageid;
 final    String pageimage;
 final   String pagename;
  final   bool isFollow;
 final   String pageUsername;
  final  bool isOfficial;

   PostDetailsSC(
      {Key key,
      this.id,
      this.image,
      this.authorposttext,
      this.posttitle,
      this.subtitle,
      this.dateTime,
      this.gallery,
      this.likeCount,
      this.commentCount,
      this.shareCoun,
      this.userid,
      this.token,
      this.userimage, this.pageid, this.pageimage, this.pagename, this.isFollow, this.pageUsername, this.isOfficial})
      : super(key: key);

  @override
  _PostDetailsSCState createState() => _PostDetailsSCState();
}

class _PostDetailsSCState extends State<PostDetailsSC> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

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
      Api.getcommentlist(widget.id, widget.userid, widget.token);
    });

    super.didChangeDependencies();
  }

  @override
  void initState() {
    setState(() {
      // Api.gettoke().then((value) => ({
      //       setState(() {
      //         mytoken = value;
      //       }),
      //       print('myuidhome$mytoken'),
      //     }));
      print(widget.id);
      print(widget.userid);
      print(widget.token);

      Api.getcommentlist(widget.id, widget.userid, widget.token)
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
      _postsController = new StreamController();
    });

    super.initState();
  }

  Future sendcomment(
      String postid, String mytoken, String mag, String myuid) async {
    print('sendcomment');

    var url = "${Api.url}api/post/$postid/comment";
    final headers = {
      "userid": myuid,
      "content-type": "application/json",
      "accept": "application/json",
      "authorization": "Bearer $mytoken",
    };
    Map data = {
      "commentAsPage": myuid,
      "comment": mag,
      //      "mediaURL": "",
      // "post": postid,
      // "user": "60c9cc216923656607919f06",
      // "likeCount": 0,
      // "deleted": false,
      // "id": "60f583d3ef898e1a0a05ed3d"
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
    new Future.delayed(const Duration(seconds: 2));
    setState(() {
      listModel.clear();
    });
    Api.getcommentlist(widget.id, widget.userid, widget.token)
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
                  setState(() {
                    loading = false;
                    onref = false;
                  }),
                }
            }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (onref == true) {
      _handleRefresh();
    }
    print('token${widget.token}');

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
                primaryAppBar(context, widget.token, "", widget.userimage, Search(
              userid: widget.userid,
            ),true,
                    ProfileSc(
                      userid:  widget.userid,
                      token:   widget.token,
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
                   widget.id,
                     widget     .pageimage,
                    widget      .pagename,
                     widget     .isFollow,
                     widget     .pageUsername,
                     widget     .isOfficial,
                     
                  ),
                ),

                ///-----------SliverListปิดไปก่อนได้----------------//
                SliverToBoxAdapter(
                  child: _buildCommentList(size),
                ),
                // SliverList(
                //   delegate: SliverChildBuilderDelegate((context, index) {
                //     return Builder(
                //       builder: (BuildContext context) {
                //         return ListView.builder(
                //             physics: ClampingScrollPhysics(),
                //             shrinkWrap: true,
                //             padding: const EdgeInsets.all(8.0),
                //             scrollDirection: Axis.vertical,
                //             itemCount: 5,
                //             itemBuilder: (
                //               BuildContext context,
                //               int index,
                //             ) {
                //               return ListTile(

                //                 leading:  new  CircleAvatar(
                //             radius: 25.0,
                //             backgroundImage:
                //                 NetworkImage('https://via.placeholder.com/150'),
                //             backgroundColor: Colors.transparent,
                //           ),
                //                 title: Text('I like icecream$index'),
                //                 subtitle: Text('Icream is good for health'),
                //                 trailing: Icon(Icons.food_bank),
                //               );
                //             });
                //       },
                //     );
                //   }, childCount: 1),
                // ),
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
      List<Gallery> gallery,
      int likeCount,
      int commentCount,
      int shareCount,
       String pageid,
    String pageimage,
    String pagename,
    bool isFollow,
    String pageUsername,
    bool isOfficial) {
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
                    tag: "image"+ gallery[0].signUrl,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      fixtextauthor(),
                    authorpost(
                          authorposttext,
                          context,
                          dateTime,
                          pageid,
                          pageimage,
                          pagename,
                          isFollow,
                          pageUsername,
                          isOfficial,widget.userid),
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
                                      Icons.favorite_outline,
                                      color: MColors.primaryBlue,
                                      size: 20.0,
                                    ),
                                    label: '${ widget.likeCount} ถูกใจ',
                                    onTap: () async {
                                      HapticFeedback.lightImpact();

                                      var jsonResponse;
                                      widget.token == "" || widget.token == null
                                          ? Navigate.pushPage(
                                              context, Loginregister())
                                          : await Api.islike(widget.id,
                                                  widget.userid, widget.token)
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

                                                               widget.likeCount++;
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

                                                              --widget.likeCount;
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
                                      size: 20.0,
                                    ),
                                    label: '$likeCount ถูกใจ',
                                    onTap: () async {
                                      HapticFeedback.lightImpact();

                                      var jsonResponse;
                                      widget.token == null
                                          ? Navigate.pushPage(
                                              context, Loginregister())
                                          : await Api.islike(widget.id,
                                                  widget.userid, widget.token)
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
                                size: 20.0,
                              ),
                              label: '$commentCount ความคิดเห็น',
                              onTap: () => print('Comment'),
                            ),
                            PostButton(
                              icon: Icon(
                                Icons.share,
                                color: MColors.primaryBlue,
                                size: 25.0,
                              ),
                              label: '$shareCount แชร์',
                              onTap: () => print('Share'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  widget.token == "" || widget.token == null
                      ? Container()
                      : Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                radius: 25.0,
                                backgroundImage: widget.userimage != null
                                    ? NetworkImage(
                                        'https://today-api.moveforwardparty.org/api${widget.userimage}/image')
                                    : NetworkImage(
                                        'https://via.placeholder.com/150'),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Container(
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffDEDEDE),
                                  ),
                                  color: MColors.primaryWhite,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                ),
                                child: TextFormField(
                                  controller: _commentController,
                                  onSaved: (String value) {},
                                  onChanged: (String value) {
                                    _commenteditController.text = value;
                                    print(value);
                                  },
                                  // initialValue:
                                  //     _commenteditController.text,
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
                                            // print("sendcomment");
                                            print("${widget.id}");

                                            // setState(() {
                                            //   onref = true;
                                            // });
                                            await sendcomment(
                                                widget.id,
                                                widget.token,
                                                _commentController.text,
                                                widget.userid);

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

  Widget _buildCommentList(Size size) {
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
            return new InkWell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                // widget.data['toCommentID'] == null ? EdgeInsets.all(8.0) : EdgeInsets.fromLTRB(34.0,8.0,8.0,8.0),
                child: Stack(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(6.0, 2.0, 10.0, 2.0),
                          child: Container(
                            width: 48,
                            // widget.data['toCommentID'] == null ? 48 : 40,
                            height: 48,
                            // widget.data['toCommentID'] == null ? 48 : 40,
                            child: CircleAvatar(
                              radius: 25.0,
                              backgroundImage: data.user.imageUrl != null
                                  ? NetworkImage(
                                      "https://today-api.moveforwardparty.org/api${data.user.imageUrl}/image")
                                  : NetworkImage(
                                      'https://via.placeholder.com/150'),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        data.user.displayName,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: MColors.primaryBlue),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        data.comment,
                                        maxLines: null,
                                        style: TextStyle(
                                            color: MColors.primaryBlue),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              width: size.width - 90,
                              // widget.size.width- (widget.data['toCommentID'] == null ? 90 : 110),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffDEDEDE),
                                ),
                                color: MColors.primaryWhite,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 2.0),
                              child: Container(
                                width: size.width * 0.38,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Text(
                                        'ถูกใจ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: MColors.primaryBlue),
                                        // style:TextStyle(fontWeight: FontWeight.bold,color:_currentMyData.myLikeCommnetList != null && _currentMyData.myLikeCommnetList.contains(widget.data['commentID']) ? Colors.blue[900] : Colors.grey[700])
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        'ตอบกลับ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: MColors.primaryBlue),
                                        // style:TextStyle(fontWeight: FontWeight.bold,color:_currentMyData.myLikeCommnetList != null && _currentMyData.myLikeCommnetList.contains(widget.data['commentID']) ? Colors.blue[900] : Colors.grey[700])
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      TimeUtils.readTimestamp(data
                                          .createdDate.millisecondsSinceEpoch),
                                      style:
                                          TextStyle(color: MColors.primaryBlue),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
