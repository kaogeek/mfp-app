import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/PostButton.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/model/postModel.dart';
import 'package:mfp_app/allWidget/circle_button.dart';
import 'package:mfp_app/model/searchpostlistModel.dart';
import 'package:mfp_app/utils/internetConnectivity.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/utils/style.dart';
import 'package:mfp_app/view/Auth/login-register.dart';
import 'package:mfp_app/view/NavigationBar/nav_screen.dart';
import 'package:mfp_app/view/Profile/Profile.dart';
import 'package:mfp_app/view/Search/Search.dart';

//APPBARS-------------------------------------

// Widget primaryAppBar(
//   Widget leading,
//   Widget title,
//   Color backgroundColor,
//   PreferredSizeWidget bottom,
//   bool centerTile,
//   List<Widget> actions,
// ) {
//   return AppBar(
//     brightness: Brightness.light,
//     elevation: 0.0,
//     backgroundColor: backgroundColor,
//     leading: leading,
//     title: title,
//     bottom: bottom,
//     centerTitle: centerTile,
//     actions: actions,
//   );
// }
Widget topImage(String image) {
  return Container(
    // height: 250.0,
    width: double.infinity,
    child: FullScreenWidget(
      child: Center(
        child: Hero(
          tag: "image" + image,
          child: Image.network(
            image,
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
  );
}

Widget myAlbumCard(List<GalleryPostSearchModel> list,BuildContext context) {
  if (list.length >= 4) {
    return Container(
      height: 280,
      width: double.infinity,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            getItems(list[0].signUrl, list[1].signUrl, 0,context),
            getItems(list[2].signUrl, list[3].signUrl, list.length - 4,context),
          ],
        ),
      ),
    );
  } else if (list.length >= 3) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 340,
        width: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey, width: 0.2)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                getItems(list[0].signUrl, list[1].signUrl, 0,context),
                Expanded(
                  child: getItems(
                      list[2].signUrl, list[3].signUrl ?? "", list.length - 3,context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  } else if (list.length >= 2) {
    return Container(
      height: 340,
      width: double.infinity,
      color: Colors.black,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getItems(list[0].signUrl, list[1].signUrl, 0,context),
          ],
        ),
      ),
    );
  } else if (list.length >= 1) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Padding(
            //   padding: EdgeInsets.only(
            //       left: 10.0, top: 2),
            //   child: Text(
            //     name,
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 14,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),

            list[0].signUrl != null
                ?
                // Hero(
                //   tag:"image"+ list[0].signUrl.toString(),
                //   child:
                topImage(list[0].signUrl.toString())
                // CachedNetworkImage(
                //     imageUrl: 'https://via.placeholder.com/350x150',
                //     placeholder: (context, url) =>
                //         new CupertinoActivityIndicator(),
                //     errorWidget: (context, url, error) => Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.all(Radius.circular(8)),
                //       ),
                //       child:Image(image: CachedNetworkImageProvider(list[0].signUrl),)
                //     ),
                //   )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

Widget getItems(img_path, img_path2, count,BuildContext context) {
  return Container(
    width: double.infinity,
    child: Row(
      // crossAxisAlignment :CrossAxisAlignment.center,
      // mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        // SizedBox(width: 5,),

        ClipRRect(
          child: Image.network(
            img_path,
            height: MediaQuery.of(context).size.height/5.2,
            width:   MediaQuery.of(context).size.width/2.0,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.low,
          ),
        ),

        // SizedBox(
        //   width: 11,
        // ),
        (count > 0)
            ? Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  ClipRRect(
                    // borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),),
                    child: Image.network(
                      img_path2,
            height: MediaQuery.of(context).size.height/5.2,
            width:   MediaQuery.of(context).size.width/2.0,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.low,
                    ),
                  ),
                  (count > 0)
                      ? Positioned(
                          child: Container(
            height: MediaQuery.of(context).size.height/5.2,
            width:   MediaQuery.of(context).size.width/2.0,
                            decoration: BoxDecoration(color: Colors.black38),
                            child: Center(
                              child: Text(
                                "$count +",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Center()
                ],
              )
            : ClipRRect(
                child: Image.network(
                  img_path2,
            height: MediaQuery.of(context).size.height/5.2,
            width:   MediaQuery.of(context).size.width/2.0,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                ),
              ),
      ],
    ),
  );
}

Widget primaryAppBar(
  context,
  var token,
  var userid,
  var imageurl,
  Widget widgetsearch,
  Widget widgetprofile,
) {
  return SliverAppBar(
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
        color: MColors.primaryBlue,
        iconSize: 27.0,
        onPressed: () => widgetsearch == null
            ? null
            : Navigate.pushPage(context, widgetsearch),
      ),
      CircleButton(
        icon: MdiIcons.bellOutline,
        iconSize: 27.0,
        color: MColors.primaryBlue,
        onPressed: () => print('Messenger'),
      ),
      token != "" && token != null
          ? InkWell(
              onTap: () => widgetprofile == null
                  ? null
                  : Navigate.pushPage(context, widgetprofile),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                      'https://today-api.moveforwardparty.org/api$imageurl/image'),
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
  );
}

Widget AppBardetail(
    context, String authorposttext, String lable, IconButton icon) {
  return SliverAppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      title: Text('$lable $authorposttext',
          style: TextStyle(
              fontSize: 16,
              color: MColors.textDark,
              fontFamily: 'Anakotmai-Medium')),
      // Text(
      //   'facebook',
      //   style: const TextStyle(
      //     color: Colors.blue,
      //     fontSize: 28.0,
      //     fontWeight: FontWeight.bold,
      //     letterSpacing: -1.2,
      //   ),
      // ),
      centerTitle: false,
      floating: true,
      leading: icon);
}

Widget UIlikecommentshear(context, int like, int comment, int share) {
  return Column(
    children: [
      Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: MColors.primaryBlue,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite_outline,
              size: 10.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 4.0),
          Expanded(
            child: Text(
              '$like ถูกใจ',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
          Text(
            '$comment ความคิดเห็น',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            '$share  แชร์',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          )
        ],
      ),
      const Divider(),
      Row(
        children: [
          PostButton(
            icon: Icon(
              Icons.favorite_outline,
              color: MColors.primaryBlue,
              size: 20.0,
            ),
            label: 'ถูกใจ',
            onTap: () => print('Like'),
          ),
          PostButton(
            icon: Icon(
              MdiIcons.commentOutline,
              color: MColors.primaryBlue,
              size: 20.0,
            ),
            label: 'ความคิดเห็น',
            onTap: () => print('Comment'),
          ),
          PostButton(
            icon: Icon(
              Icons.share,
              color: MColors.primaryBlue,
              size: 25.0,
            ),
            label: 'แชร์',
            onTap: () => print('Share'),
          )
        ],
      ),
      SizedBox(
        height: 5,
      ),
    ],
  );
  // Row(
  //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   children: <Widget>[
  //     IconButton(
  //       padding: EdgeInsets.all(2.0),
  //         icon: Icon(
  //           Icons.favorite_outline,
  //           color: MColors.primaryBlue,
  //         ),
  //         onPressed: () {}),
  //     Text(
  //       '${like.toString()} ถูกใจ',
  //       style: Theme.of(context).textTheme.subtitle1,
  //     ),
  //     Spacer(),
  //     IconButton(icon: Icon(Icons.comment_outlined), onPressed: () {}),
  //     Text(
  //       '${comment.toString()} ความคิดเห็น',
  //       style: Theme.of(context).textTheme.subtitle1,
  //     ),
  //     Spacer(),
  //     IconButton(icon: Icon(Icons.share), onPressed: () {}),
  //     Text(
  //       '${share.toString()} แชร์',
  //       style: Theme.of(context).textTheme.subtitle1,
  //     ),
  //   ],
  // );
}

void showNoInternetSnack(
  GlobalKey<ScaffoldState> _scaffoldKey,
) {
  _scaffoldKey.currentState.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: 10000),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              "No internet connection! Please connect to the internet to continue.",
              style: TextStyle(color: MColors.primaryColor, fontSize: 14),
            ),
          ),
          InkWell(
            onTap: () => checkInternetConnectivity(),
            child: Icon(
              Icons.error_outline,
              color: Colors.amber,
            ),
          )
        ],
      ),
    ),
  );
}

Widget nonet(BuildContext context) {
  return Scaffold(
    body: Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4.0,
          ),

          Image.asset(
            'images/error_404.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            fit: BoxFit.cover,
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Text(
                'NetWork interruption',
                style: TextStyle(),
              )),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: RaisedButton(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.red)),
              child: Text(
                'ลองอีกครั้ง',
                style: TextStyle(fontSize: 18),
              ),
              textColor: Colors.white,
              color: MColors.primaryColor,
              onPressed: ()async {
              await  checkInternetConnectivity().then((value) {
                value == true
                      ? Navigate.pushPageReplacement(context, NavScreen())
                      : 
                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                          content: Text('ลองอีกครั้ง',textAlign: TextAlign .center,),
                          
                          behavior: SnackBarBehavior.floating,
                              width: 150,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          backgroundColor:MColors.primaryColor,
                          duration :Duration(milliseconds: 200) 
                          // margin: EdgeInsets.fromLTRB(0, 10, 0, 50),
                          // padding: EdgeInsets.all(20),
                        ));
                });
                print('กด');
              },
            ),
          ),
          // Align(
          //   alignment: FractionalOffset.bottomCenter,
          //   child: Container(
          //     child: Text(
          //       'Nonet',
          //       style: TextStyle(
          //         fontSize: 10,
          //         fontFamily: "Anakotmai-Light",
          //         fontWeight: FontWeight.w300,
          //         color: MColors.primaryWhite,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    ),
  );
}
