import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/CarouselsLoading.dart';
import 'package:mfp_app/allWidget/PostButton.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/allWidget/fontsize.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/model/commentlistmodel.dart';
import 'package:mfp_app/model/post_details_model.dart';
import 'package:http/http.dart' as Http;
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/utils/timeutils.dart';
import 'package:mfp_app/view/Auth/login-register.dart';
import 'package:mfp_app/view/Today/show_full_image.dart';
import 'package:mfp_app/view/Today/story_page.dart';

class PostDetailsSC extends StatefulWidget {
  final String postid;

  final List gallery;

  final bool onfocus;
  final story;
  final String type;

  PostDetailsSC(
      {Key key, this.postid, this.gallery, this.onfocus, this.type, this.story})
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
  var maxLines = 5;

  var userprofileimage = "";
  Future futuregetpostdetiail;

  bool postloading = true;

  var commentid, textcomment;
  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  var loading = true;
  var dataht;

  List<CommentlistModel> listModel = [];
  List<PostDetailsModel> postdetailslist = [];

  TextEditingController _commentController = TextEditingController();
  TextEditingController _commenteditController = TextEditingController();

  bool islikepost = false;
  bool isedit = false;
  var jsonResponse;
  bool onref = false;
  StreamController _commerntController;
  StreamController _postdetailController;
  var pagename = "";
  var pageid = "";

  Future futuregetpostdetail;

  @override
  void didChangeDependencies() {
    setState(() {
      Api.getcommentlist(widget.postid, userid, token);
      Api.getstory(widget.postid, userid);
    });

    super.didChangeDependencies();
  }

  @override
  void initState() {
    ////(widget.postid);
    Future.delayed(Duration.zero, () async {
      // //('Futuredelayed');
      //--token
      token = await Api.gettoke();
      // //('tokenhome$token');
      //--mode
      mode = await Api.getmodelogin();
      // //('mode$mode');
      //--userid
      userid = await Api.getmyuid();
      // //('userid$userid');
      if (token == null) {
        setState(() {
          loading = false;
        });
      }
      //---getuserprofile
      await Api.getuserprofile(userid).then((responseData) async => ({
            setState(() {
              loading = true;
            }),
            if (responseData.statusCode == 200)
              {
                datagetuserprofile = jsonDecode(responseData.body),
                setState(() {
                  userprofileimage = datagetuserprofile["data"]["imageURL"];
                }),
                setState(() {
                  loading = false;
                }),
              }
            else
              {
                setState(() {
                  loading = false;
                }),
              }
          }));
      //--
      futuregetpostdetail =
          Api.getstory(widget.postid, userid).then((responseData) async => ({
                setState(() {
                  postloading = true;
                }),
                if (responseData.statusCode == 200)
                  {
                    jsonResponse = jsonDecode(responseData.body),
                    // //('jsonResponse$jsonResponse'),
                    for (Map i in jsonResponse["data"])
                      {
                        setState(() {
                          pagename = i['page'][0]['name'];
                          pageid = i['page'][0]['pageId'];
                        }),
                        postdetailslist.add(PostDetailsModel.fromJson(i)),
                        _postdetailController.add(responseData),
                      },
                    // //("Response  :$storytestreplaceAll"),
                    // //('titalpost$titalpost'),
                    setState(() {
                      postloading = false;
                    }),
                  }
                else if (responseData.statusCode == 400)
                  {}
              }));

      //--getcommentlist
      await Api.getcommentlist(widget.postid, userid, token)
          .then((responseData) => ({
                // setState(() {
                //   loading = true;
                // }),
                // //('getHashtagData'),
                if (responseData.statusCode == 200)
                  {
                    dataht = jsonDecode(responseData.body),
                    // //("comlist${dataht["data"]}"),
                    for (Map i in dataht["data"])
                      {
                        setState(() {
                          listModel.add(CommentlistModel.fromJson(i));
                          _commerntController.add(responseData);
                        }),
                        // //('listModel${listModel.length}'),
                      },
                    // loading = false,
                  }
              }));
      //--.
      await Api.postsearch(userid, token, widget.postid, mode)
          .then((responseData) => ({
                if (responseData.statusCode == 200)
                  {
                    datapostsearch = jsonDecode(responseData.body),
                    // //('checkislike$datapostsearch'),
                    for (Map i in dataht["data"])
                      {
                        // //('islike${i["isLike"]}'),
                        if (i["isLike"] == false)
                          {
                            setState(() {
                              // islikepost = false;
                            }),
                          }
                        else if (i["isLike"] == true)
                          {
                            setState(() {
                              // islikepost = true;
                            }),
                          }
                      },
                  }
              }));
    });
    _commerntController = new StreamController();
    _postdetailController = new StreamController();
    super.initState();
  }

  Future sendcomment(String postid, String mytoken, String mag, String myuid,
      String mode) async {
    // //('sendcomment');

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
    // //('body$body');
    // //('responseDatacommentlist${responseData.body}');
    final jsonResponse = jsonDecode(responseData.body);
    if (responseData.statusCode == 200) {
      // //(jsonResponse['status']);
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
          // setState(() {
          //   loading = true;
          // }),
          // //('getHashtagData'),
          if (responseData.statusCode == 200)
            {
              dataht = jsonDecode(responseData.body),
              // //("comlist${dataht["data"]}"),
              for (Map i in dataht["data"])
                {
                  setState(() {
                    listModel.add(CommentlistModel.fromJson(i));
                    _commerntController.add(responseData);
                  }),
                  // //('listModel${listModel.length}'),
                },
              setState(() {
                // loading = false;
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

    return loading == true
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
                    AppBardetail(
                      context,
                      "โพสต์ของ",
                      pagename == "" ? "" : pagename,
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
                    ),

                    ///-----------APPBAR-----------------//
                    postloading == true
                        ? SliverToBoxAdapter(child: CarouselLoading())
                        : SliverToBoxAdapter(
                            child: StreamBuilder(
                              stream: _postdetailController.stream,
                              // future: Future.wait([
                              //   futuregetpostdetail
                              // ]),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                // if (snapshot.connectionState ==
                                //     ConnectionState.waiting) {
                                //   return CarouselLoading();
                                // }
                                // if (snapshot.connectionState ==
                                //     ConnectionState.done) {
                                //   return Text('ไม่พบเพจ');
                                // }
                                return Builder(builder: (BuildContext context) {
                                  return ListView.builder(
                                    physics: ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: postdetailslist.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final datapostdetail =
                                          postdetailslist[index];
                                      var likenumber = datapostdetail.likeCount;
                                      return PostList(
                                          datapostdetail.title,
                                          datapostdetail.detail,
                                          datapostdetail.page,
                                          datapostdetail.createdDate,
                                          datapostdetail.gallery,
                                          likenumber,
                                          datapostdetail.commentCount,
                                          datapostdetail.shareCount,
                                          datapostdetail.story,
                                          datapostdetail.id,
                                          datapostdetail);
                                    },
                                  );
                                });
                              },
                            ),
                          ),
                    SliverToBoxAdapter(
                      child: Container(
                          color: Colors.grey[200], child: _buildCommentList()),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget PostList(
      String posttitle,
      String subtitle,
      List page,
      DateTime dateTime,
      List gallery,
      int likeCount,
      int commentCount,
      int shareCount,
      story,
      String postid,
      datapostdetail) {
    print(datapostdetail.isLike);
    return InkWell(
      onTap: () {},
      child: Container(
        width: 200,
        color: MColors.containerWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // gallery[0].signUrl != null
            //     ? gallery[0].imageUrl != null
            //         ? Hero(
            //             tag: "image" + gallery[0].signUrl,
            //             child: CachedNetworkImage(
            //               imageUrl: gallery[0].signUrl,
            //               placeholder: (context, url) =>
            //                   new CupertinoActivityIndicator(),
            //               errorWidget: (context, url, error) => Container(
            //                 decoration: BoxDecoration(
            //                   borderRadius:
            //                       BorderRadius.all(Radius.circular(8)),
            //                 ),
            //                 child: new Image.network(
            //                   gallery[0].signUrl,
            //                   filterQuality: FilterQuality.low,
            //                 ),
            //               ),
            //             ),
            //           )
            //         : SizedBox.shrink()
            //     : SizedBox.shrink(),
            // gallery[0].imageUrl != null
            //     ? Hero(
            //         tag: "image" + gallery[0].imageUrl,
            //         child: CachedNetworkImage(
            //           imageUrl:
            //               'https://today-api.moveforwardparty.org/api${gallery[0].imageUrl}/image',
            //           placeholder: (context, url) =>
            //               new CupertinoActivityIndicator(),
            //           errorWidget: (context, url, error) => Container(
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.all(Radius.circular(8)),
            //             ),
            //             child: new Image.network(
            //               'https://today-api.moveforwardparty.org/api${gallery[0].imageUrl}/image',
            //               filterQuality: FilterQuality.low,
            //             ),
            //           ),
            //         ),
            //       )
            //     : SizedBox.shrink(),
            gallery.length != 0
                ? InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SliderShowFullmages(
                            listImagesModel: gallery, current: 0))),
                    child: searchAlbumCard(gallery, context))
                : SizedBox.shrink(),
            // Image.network(gallery[0].signUrl),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: texttitlepost(posttitle, context),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: subtexttitlepost(subtitle, context),
                ),
                story != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: InkWell(
                            onTap: () async {
                              Navigate.pushPage(
                                  context,
                                  StroyPageSc(
                                    postid: postid,
                                    titalpost: posttitle,
                                    imagUrl: gallery,
                                    type: widget.type,
                                    createdDate: dateTime,
                                    postby: page[0].name,
                                    imagepage: page[0].imageUrl,
                                    likeCount: likeCount,
                                    commentCount: commentCount,
                                    shareCount: shareCount,
                                    repostCount: 0,
                                    token: token,
                                    userid: userid,
                                    mode: mode,
                                  ));
                            },
                            child: textreadstory('อ่านสตอรี่...')),
                      )
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: authorpost(
                            page[0].name,
                            context,
                            dateTime,
                            page[0].id,
                            page[0].imageUrl,
                            page[0].name,
                            "pageUsername",
                            userid,
                            true),
                      ),
                    ),
                    //     SizedBox(
                    //   width: 2,
                    // ),
                    Container(child: texttimetimestamp(dateTime)),
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
                              datapostdetail.isLike != true
                                  ? Icons.favorite_outline
                                  : Icons.favorite,
                              size: 19.0,
                              color: MColors.primaryBlue,
                            ),
                            label: '${datapostdetail.likeCount} ถูกใจ',
                            width: 0.14,
                            containerwidth: 3.4,
                            onTap: () {
                              HapticFeedback.lightImpact();
                              var jsonResponse;
                              print(datapostdetail.isLike);
                              token == null || token == ""
                                  ? Navigate.pushPage(context, Loginregister())
                                  : mode != "FB"
                                      ? setState(() {
                                          if (datapostdetail.isLike == false ||
                                              datapostdetail.isLike == null ||
                                              datapostdetail.likeCount < 0) {
                                            datapostdetail.isLike = true;
                                            datapostdetail.likeCount++;
                                            Api.islike(
                                                postid, userid, token, "");
                                          } else if (datapostdetail.isLike ==
                                              true) {
                                            datapostdetail.isLike = false;
                                            datapostdetail.likeCount--;
                                            Api.islike(
                                                postid, userid, token, "");
                                          }
                                        })
                                      : setState(() {
                                          if (datapostdetail.isLike == false ||
                                              datapostdetail.isLike == null ||
                                              datapostdetail.likeCount < 0) {
                                            datapostdetail.isLike = true;
                                            datapostdetail.likeCount++;
                                            Api.islike(
                                                postid, userid, token, "FB");
                                          } else if (datapostdetail.isLike ==
                                              true) {
                                            datapostdetail.isLike = false;
                                            datapostdetail.likeCount--;
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
                              size: 19.0,
                            ),
                            width: 0.24,
                            containerwidth: 3.1,
                            label: '$commentCount ความคิดเห็น',
                            onTap: () => {},
                          ),
                          PostButton(
                            icon: Icon(
                              Icons.share,
                              color: MColors.primaryBlue,
                              size: 19.0,
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
                                      Text('คัดลอกลิงค์')
                                    ],
                                  ),
                                  duration: const Duration(milliseconds: 1000),
                                ));
                              });
                            },
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1.0,
                      ),
                    ],
                  ),
                ),
                token == "" || token == null
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 6.0, right: 3.0, bottom: 10),
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
                          isedit != true
                              ? Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        6.0, 2.0, 25.0, 2.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color(0xffDEDEDE),
                                            ),
                                            color: MColors.primaryWhite,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15.0),
                                            ),
                                          ),
                                          child: TextField(
                                            controller: _commentController,
                                            autofocus: widget.onfocus,
                                            onChanged: (String value) {
                                              _commenteditController.text =
                                                  value;
                                            },
                                            maxLines: null,
                                            minLines: null,
                                            decoration: InputDecoration(
                                              // contentPadding: const EdgeInsets.all(13.0),
                                              hintText: "เขียนความคิดเห็น",
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.all(13),
                                              suffixIcon: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween, // added line
                                                mainAxisSize: MainAxisSize
                                                    .min, // added line
                                                children: <Widget>[
                                                  IconButton(
                                                    splashRadius:
                                                        AppTheme.splashRadius,
                                                    icon: Icon(
                                                      Icons.send,
                                                      color: Colors.black,
                                                    ),
                                                    onPressed: () async {
                                                      await sendcomment(
                                                          widget.postid,
                                                          token,
                                                          _commentController
                                                              .text,
                                                          userid,
                                                          mode);
                                                      setState(() {
                                                        _commentController
                                                            .clear();
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        6.0, 2.0, 25.0, 2.0),
                                    child: Column(
                                      children: [
                                        Container(
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
                                            initialValue:
                                                _commenteditController.text,
                                            autofocus: widget.onfocus,
                                            onChanged: (String value) {
                                              textcomment = value;
                                              _commenteditController.text =
                                                  value;

                                              print(textcomment);
                                            },
                                            maxLength: null,
                                            maxLines: null,
                                            decoration: InputDecoration(
                                              // contentPadding: const EdgeInsets.all(13.0),
                                              hintText: "เขียนความคิดเห็น",
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.all(13),

                                              suffixIcon: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween, // added line
                                                mainAxisSize: MainAxisSize
                                                    .min, // added line
                                                children: <Widget>[
                                                  IconButton(
                                                      icon: Icon(
                                                        Icons.close,
                                                        color: Colors.black,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          isedit = false;
                                                        });
                                                      }),
                                                  IconButton(
                                                    splashRadius:
                                                        AppTheme.splashRadius,
                                                    icon: Icon(
                                                      Icons.send,
                                                      color: Colors.black,
                                                    ),
                                                    onPressed: () async {
                                                      await Api.iseditcomment(
                                                          postid,
                                                          userid,
                                                          token,
                                                          this.commentid,
                                                          _commenteditController
                                                              .text,
                                                          mode);
                                                      setState(() {
                                                        // _commenteditController
                                                        //     .clear();
                                                        isedit = false;
                                                        _handleRefresh();
                                                      });
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
                                                            Text('แก้ไขสำเร็จ')
                                                          ],
                                                        ),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    2500),
                                                      ));
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentList() {
    return StreamBuilder(
      stream: _commerntController.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: listModel.length,
          itemBuilder: (BuildContext context, int index) {
            var data = listModel[index];

            return GestureDetector(
              onTap: () {
                print('${data.comment}');
                // print('${_commenteditController.text}');
              },
              child: Padding(
                padding: EdgeInsets.only(top: 8.0),
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
                                      padding: const EdgeInsets.only(
                                          left: 4.0, bottom: 5, top: 3),
                                      child: Text(
                                        data.user.displayName,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 16,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            color: MColors.primaryBlue),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4.0, bottom: 5),
                                      child: Text(
                                        data.comment,
                                        maxLines: 1,
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: MColors.primaryBlue),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              width: MediaQuery.of(context).size.width - 90,
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
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Row(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () async {
                                        Api.islikecomment(widget.postid, userid,
                                                token, data.id, mode)
                                            .then((value) => ({
                                                  jsonResponse =
                                                      jsonDecode(value.body),
                                                  //print('message${jsonResponse['message']}'),
                                                  if (value.statusCode == 200)
                                                    {
                                                      if (jsonResponse[
                                                              'message'] ==
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
                                      child: Text(
                                        '${data.likeCount} ถูกใจ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: data.isLike == false
                                                ? MColors.primaryBlue
                                                : MColors.primaryColor),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    data.user.id == userid
                                        ? GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      new CupertinoAlertDialog(
                                                        title: new Text(
                                                          "ลบ คอมเม้นต์",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        actions: [
                                                          CupertinoDialogAction(
                                                            isDefaultAction:
                                                                true,
                                                            child: new Text(
                                                                "ยกเลิก"),
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                          ),
                                                          CupertinoDialogAction(
                                                              child: new Text(
                                                                "ลบ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                Api.deletecomment(
                                                                        widget
                                                                            .postid,
                                                                        token,
                                                                        data.id,
                                                                        userid,
                                                                        mode)
                                                                    .then(
                                                                        (value) =>
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
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                  content: Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: MColors
                                                                            .primaryWhite,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                          'สำเร็จ')
                                                                    ],
                                                                  ),
                                                                  duration: const Duration(
                                                                      milliseconds:
                                                                          2500),
                                                                ));
                                                              }),
                                                        ],
                                                      ));
                                            },
                                            child: Text(
                                              'ลบ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: MColors.primaryBlue),
                                              // style:TextStyle(fontWeight: FontWeight.bold,color:_currentMyData.myLikeCommnetList != null && _currentMyData.myLikeCommnetList.contains(widget.data['commentID']) ? Colors.blue[900] : Colors.grey[700])
                                            ),
                                          )
                                        : Container(),
                                    data.user.id == userid
                                        ? SizedBox(
                                            width: 8,
                                          )
                                        : SizedBox(
                                            width: 4,
                                          ),
                                    data.user.id == userid
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isedit = true;
                                                textcomment = data.comment;
                                                _commenteditController =
                                                    TextEditingController(
                                                        text: data.comment);
                                              });
                                            },
                                            child: Text(
                                              'แก้ไข',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: MColors.primaryBlue),
                                            ),
                                          )
                                        : Container(),
                                    data.user.id == userid
                                        ? SizedBox(
                                            width: 8,
                                          )
                                        : Container(),
                                    Text(
                                      TimeUtils.readTimestamp(data
                                          .createdDate.millisecondsSinceEpoch),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MColors.primaryBlue,
                                          fontFamily:
                                              AppTheme.FontAnakotmaiLight,
                                          fontSize: 13,
                                          overflow: TextOverflow.ellipsis),
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
