import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/model/searchpostlistModel.dart';

class DTEmergenSc extends StatefulWidget {
  const DTEmergenSc({ Key key }) : super(key: key);

  @override
  _DTemergenScState createState() => _DTemergenScState();
}

class _DTemergenScState extends State<DTEmergenSc>  {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

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
              primaryAppBar(context),
              AppBardetail(context,"เหตุการณ์ด่วน #น้ำท่วม",""),

              // ///-----------APPBAR-----------------//
              // SliverToBoxAdapter(
              //   child: PostList(
              //     widget.posttitle,
              //     widget.subtitle,
              //     widget.authorposttext,
              //     widget.dateTime,
              //     widget.gallery,
              //     widget.likeCount,
              //     widget.commentCount,
              //     widget.shareCoun,
              //   ),
              // ),

              ///-----------SliverListปิดไปก่อนได้----------------//
              //  SliverToBoxAdapter(
              //    child: Expanded(
              //     child: Container(
              //       color:Color(0xffF8F8F8),
              //       child: _buildCommentList(size)),
              // ),
              //  ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8.0),
                          scrollDirection: Axis.vertical,
                          itemCount: 15,
                          itemBuilder: (
                            BuildContext context,
                            int index,
                          ) {
                            return ListTile(
                             
                              leading:  new  CircleAvatar(
                          radius: 25.0,
                          backgroundImage:
                              NetworkImage('https://via.placeholder.com/150'),
                          backgroundColor: Colors.transparent,
                        ),
                              title: Text('I like icecream$index'),
                              subtitle: Text('Icream is good for health'),
                              trailing: Icon(Icons.food_bank),
                            );
                          });
                    },
                  );
                }, childCount: 1),
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
      String authorposttext,
      DateTime dateTime,
      List<Gallery> gallery,
      int likeCount,
      int commentCount,
      int shareCount,
      String postid) {
    return InkWell(
      child: Container(
        width: 200,
        color: MColors.containerWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
   gallery[0].signUrl != null
                ? CachedNetworkImage(
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
                  )
                : SizedBox.shrink(),
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                   ListTile(
                             
                              leading:  new  CircleAvatar(
                          radius: 25.0,
                          backgroundImage:
                              NetworkImage('https://via.placeholder.com/150'),
                          backgroundColor: Colors.transparent,
                        ),
                              title: Text('I like icecream'),
                              subtitle: Text('Icream is good for health'),
                              trailing: Icon(Icons.food_bank),
                            )
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
  }