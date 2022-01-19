import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/controller/today_post_provider.dart';
import 'package:mfp_app/model/commentlistmodel.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/utils/timeutils.dart';
import 'package:url_launcher/url_launcher.dart';

class StroyPageSc extends StatefulWidget {
  final String postid;
  final String titalpost;
  final List imagUrl;
  final String type;
  final DateTime createdDate;
  final String postby;
  final String imagepage;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final int repostCount;
  final String userid;
  final String token;
  final String mode;
  StroyPageSc({
    Key key,
    this.postid,
    this.titalpost,
    this.imagUrl,
    this.type,
    this.createdDate,
    this.postby,
    this.imagepage,
    this.likeCount,
    this.commentCount,
    this.shareCount,
    this.repostCount,
    this.userid,
    this.token,
    this.mode,
  }) : super(key: key);

  @override
  _StroyPageScState createState() => _StroyPageScState();
}

class _StroyPageScState extends State<StroyPageSc> {
  var dataht;
  var storytest;

  String story1;
  // var storytestreplaceAll;
  List imagelist = [];
  String type = "";
  final TodayPostController todayController = Get.put(TodayPostController());

  var loading = false;
  List<CommentlistModel> listModel = [];
  TextEditingController _commenteditController = TextEditingController();
  bool islike = false;
  bool idedit = false;
  var jsonResponse;
  bool onref = false;
  StreamController _postsController;
  String postid;
  String titalpost;
  DateTime createdDate;
  String postby;
  String imagepage;
  int likeCount;
  int commentCount;
  int shareCount;
  int repostCount;

  @override
  void didChangeDependencies() {
    setState(() {
      Api.getcommentlist(widget.postby, widget.userid, widget.token);
    });

    super.didChangeDependencies();
  }

  @override
  void initState() {
    // getStory(widget.postid);
    imagelist = widget.imagUrl;

    _postsController = new StreamController();
    Future.delayed(Duration.zero, () async {
      await todayController.getstory(widget.postid);
      await Api.getcommentlist(widget.postid, widget.userid, widget.token)
          .then((responseData) => ({
                setState(() {
                  loading = true;
                }),
                // print('getcommentlist'),
                if (responseData.statusCode == 200)
                  {
                    dataht = jsonDecode(responseData.body),
                    // print("comlist${dataht["data"]}"),
                    for (Map i in dataht["data"])
                      {
                        setState(() {
                          listModel.add(CommentlistModel.fromJson(i));
                          _postsController.add(responseData);
                        }),
                        // print('listModel${listModel.length}'),
                      },
                    loading = false,
                  }
              }));
    });

    super.initState();
  }

  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (widget.type == "GENERAL") {
      type = "ทั่วไป";
    }
    // print('imagelist.length${imagelist.length}');

    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: MColors.primaryWhite,
            elevation: 0,
            titleSpacing: 0.0,
            centerTitle: true,
            title: todayController.idloadingstory.value
                ? Container()
                : Text(
                    todayController.titalpost.value.toString(),
                    style: TextStyle(
                        color: MColors.textDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
            automaticallyImplyLeading: false,
            leading: IconButton(
              splashRadius: AppTheme.splashRadius,
              icon: Icon(
                Icons.arrow_back_ios,
                color: MColors.primaryColor,
              ),
              onPressed: () {
                Get.reset();
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Scrollbar(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          "https://today-api.moveforwardparty.org/api${imagelist[0].imageUrl}/image",
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace stackTrace) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height / 3.0,
                                child: Image.asset('images/placeholder.jpg'));
                          },
                          color: Color.fromRGBO(255, 255, 255, 0.7),
                          colorBlendMode: BlendMode.dstATop,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 3.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 3.0,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          todayController.idloadingstory.value
                                              ? Container()
                                              : Text(
                                                  todayController
                                                      .titalpost.value
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontFamily: AppTheme
                                                          .FontAnakotmaiBold,
                                                      color: MColors.textDark,
                                                      fontSize: AppTheme
                                                          .TitleTextSize),
                                                ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30, right: 30),
                                            child: Divider(
                                                color: MColors.primaryWhite,
                                                height: 10,
                                                thickness: 2.0),
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
                    Container(
                      alignment: Alignment.bottomCenter,
                      color: Colors.grey[800],
                      height: MediaQuery.of(context).size.height / 20.0,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Spacer(),
                          Text(
                            widget.commentCount.toString(),
                            //'${nDataList.post.commentCount}',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          IconButton(
                            splashRadius: AppTheme.splashRadius,
                            icon: Icon(
                              Icons.comment,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              //print('กด');
                            },
                          ),
                          Spacer(),
                          Text(
                            widget.repostCount.toString(),
                            //'${nDataList.post.repostCount}',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          IconButton(
                            splashRadius: AppTheme.splashRadius,
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              //print('กด');
                            },
                          ),
                          Spacer(),
                          Text(
                            widget.likeCount.toString(),
                            //'${nDataList.post.likeCount}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          IconButton(
                            splashRadius: AppTheme.splashRadius,
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              //print('กด');
                            },
                          ),
                          Spacer(),
                          Text(
                            widget.shareCount.toString(),
                            //'${nDataList.post.shareCount}',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          IconButton(
                            splashRadius: AppTheme.splashRadius,
                            icon: Icon(
                              Icons.share_outlined,
                              color: Colors.white,
                            ),
                            onPressed: null,
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Center(
                      child: Text(
                        'มีการเติมเต็ม 0 รายการ',
                        style: TextStyle(
                            fontFamily: AppTheme.FontAnakotmaiLight,
                            color: MColors.textDark,
                            fontSize: AppTheme.BodyTextSize),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[200],
                      height: 3,
                      thickness: 6.0,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 8.0,
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 1.0, right: 10.0, top: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: NetworkImage(
                                      "https://today-api.moveforwardparty.org/api${widget.imagepage}/image")),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 45.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "$type ${TimeUtils.readTimestamp(widget.createdDate.millisecondsSinceEpoch)}",
                                    style: TextStyle(
                                        fontFamily: AppTheme.FontAnakotmaiBold,
                                        color: MColors.textDark,
                                        fontSize: AppTheme.BodyTextSize),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.0,
                                    child: Text(
                                      'เผยแพร่โดย:${widget.postby}',
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: AppTheme.FontAnakotmaiBold,
                                        color: MColors.textGrey,
                                        fontSize: AppTheme.BodyTextSize12,
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

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Obx(() {
                        if (todayController.idloadingstory.value)
                          return CircularProgressIndicator(
                            color: MColors.primaryColor,
                          );
                        else
                          return todayController.storytestreplaceAll == null
                              ? Text('ไม่มีสตอรี่')
                              : Html(
                                  data:
                                      """ ${todayController.storytestreplaceAll} """,
                                  defaultTextStyle: TextStyle(
                                      fontFamily: AppTheme.FontAnakotmaiLight,
                                      color: MColors.textDark),
                                  // padding: EdgeInsets.all(8.0),
                                  onLinkTap: (url) async {
                                    _launchURL(url);
                                    //print("Opening $url...");
                                  },
                                );
                      }),
                    ),
                    _buildCommentList()
                    // Text('data'),
                  ],
                ),
              ),
              //  Text("$storytest"),
            ),
          ),
        ));
  }

  Widget _buildCommentList() {
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
            _commenteditController.text = data.comment;
            var commentid = data.id;

            return new InkWell(
              // onTap: () async {
              //   data.user.id == widget.userid
              //       ? showCupertinoModalPopup<void>(
              //           context: context,
              //           builder: (BuildContext context) => CupertinoActionSheet(
              //                 actions: <CupertinoActionSheetAction>[
              //                   CupertinoActionSheetAction(
              //                     child: const Text('Edit'),
              //                     onPressed: () {
              //                       setState(() {
              //                         idedit = true;
              //                       });
              //                       Navigator.pop(context);
              //                     },
              //                   ),
              //                   CupertinoActionSheetAction(
              //                     child: const Text('Delete',
              //                         style: TextStyle(
              //                           color: Colors.red,
              //                         )),
              //                     onPressed: () {
              //                       Navigator.pop(context);
              //                       showDialog(
              //                           context: context,
              //                           builder: (BuildContext context) =>
              //                               new CupertinoAlertDialog(
              //                                 title: new Text(
              //                                   "Delete Comment",
              //                                   style: TextStyle(
              //                                       fontWeight:
              //                                           FontWeight.bold),
              //                                 ),
              //                                 actions: [
              //                                   CupertinoDialogAction(
              //                                     isDefaultAction: true,
              //                                     child: new Text("Cancel"),
              //                                     onPressed: () =>
              //                                         Navigator.pop(context),
              //                                   ),
              //                                   CupertinoDialogAction(
              //                                       child: new Text(
              //                                         "Delete",
              //                                         style: TextStyle(
              //                                             color: Colors.red),
              //                                       ),
              //                                       onPressed: () async {
              //                                         Api.deletecomment(
              //                                                 widget.postid,
              //                                                 widget.token,
              //                                                 commentid,
              //                                                 widget.userid,
              //                                                widget.mode)
              //                                             .then((value) => ({
              //                                                   if (value[
              //                                                           'status'] ==
              //                                                       1)
              //                                                     {
              //                                                       setState(
              //                                                           () {
              //                                                         onref =
              //                                                             true;
              //                                                       }),
              //                                                     }
              //                                                 }));
              //                                         Navigator.pop(context);
              //                                         ScaffoldMessenger.of(
              //                                                 context)
              //                                             .showSnackBar(
              //                                                 SnackBar(
              //                                           backgroundColor:
              //                                               Colors.green,
              //                                           content: Row(
              //                                             children: [
              //                                               Icon(
              //                                                 Icons.check,
              //                                                 color: MColors
              //                                                     .primaryWhite,
              //                                               ),
              //                                               SizedBox(
              //                                                 width: 5,
              //                                               ),
              //                                               Text('Success')
              //                                             ],
              //                                           ),
              //                                           duration:
              //                                               const Duration(
              //                                                   milliseconds:
              //                                                       2500),
              //                                         ));
              //                                       }),
              //                                 ],
              //                               ));
              //                     },
              //                   )
              //                 ],
              //                 cancelButton: CupertinoActionSheetAction(
              //                   child: const Text('Cancel'),
              //                   onPressed: () {
              //                     Navigator.pop(context);
              //                   },
              //                 ),
              //               ))
              //       : Container();
              // },
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
                              width: MediaQuery.of(context).size.width - 90,
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
                                width: MediaQuery.of(context).size.width * 0.38,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    GestureDetector(
                                      //   onTap: ()async{
                                      //          Api.islikecomment(widget.postid, widget.userid, widget.token,
                                      //     commentid, widget.mode)
                                      // .then((value) => ({
                                      //       jsonResponse = jsonDecode(value.body),
                                      //       print(
                                      //           'message${jsonResponse['message']}'),
                                      //       if (value.statusCode == 200)
                                      //         {
                                      //           if (jsonResponse['message'] ==
                                      //               "Like Post Comment Success")
                                      //             {
                                      //               setState(() {
                                      //                 data.likeCount++;
                                      //                 data.isLike = true;
                                      //               }),
                                      //             }
                                      //           else if (jsonResponse[
                                      //                   'message'] ==
                                      //               "UnLike Post Comment Success")
                                      //             {
                                      //               setState(() {
                                      //                 data.likeCount--;
                                      //                 data.isLike = false;
                                      //               }),
                                      //             }
                                      //         }
                                      //     }));
                                      //   },
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
