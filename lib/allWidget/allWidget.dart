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
import 'package:mfp_app/model/searchpostlist.dart';
import 'package:mfp_app/model/searchpostlistModel.dart';
import 'package:mfp_app/utils/internetConnectivity.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/utils/style.dart';
import 'package:mfp_app/view/Auth/login-register.dart';
import 'package:mfp_app/view/NavigationBar/nav_screen.dart';
import 'package:mfp_app/view/Profile/profile.dart';
import 'package:mfp_app/view/Search/search.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
Widget myAlbumCard(List<GalleryPostSearchModel> list, BuildContext context) {
  if (list.length >= 4) {
    return Container(
      //  color: Colors.yellow,
      height: MediaQuery.of(context).size.height / 2.6,
      width: double.infinity,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            list[0].signUrl != null
                ? getItems(
                    list[0].signUrl == null
                        ? "https://today-api.moveforwardparty.org/api${list[0].imageUrl}/image"
                        : list[0].signUrl,
                    list[1].signUrl == null
                        ? "https://today-api.moveforwardparty.org/api${list[1].imageUrl}/image"
                        : list[1].signUrl,
                    0,
                    context)
                : SizedBox.shrink(),
            list[2].signUrl != null
                ? getItems(
                    list[2].signUrl == null
                        ? "https://today-api.moveforwardparty.org/api${list[2].imageUrl}/image"
                        : list[2].signUrl,
                    list[3].signUrl == null
                        ? "https://today-api.moveforwardparty.org/api${list[3].imageUrl}/image"
                        : list[3].signUrl,
                    list.length - 4,
                    context)
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  } else if (list.length >= 3) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.6,
      width: double.infinity,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            getItems(
                list[0].signUrl != null ? list[0].signUrl : list[0].imageUrl,
                list[1].signUrl != null ? list[1].signUrl : list[1].imageUrl,
                0,
                context),
            Expanded(
              child: getItems(
                  list[2].signUrl != null ? list[2].signUrl : list[2].imageUrl,
                  list[2].signUrl != null
                      ? list[2].signUrl
                      : list[2].imageUrl ?? "",
                  list.length - 3,
                  context),
            ),
          ],
        ),
      ),
    );
  } else if (list.length >= 2) {
    return Container(
      height: 340,
      width: double.infinity,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getItems(
                "https://today-api.moveforwardparty.org/api${list[0].imageUrl}/image",
                "https://today-api.moveforwardparty.org/api${list[0].imageUrl}/image",
                0,
                context),
          ],
        ),
      ),
    );
  } else if (list.length >= 1) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            list[0].signUrl != null
                ? topImage(
                    "https://today-api.moveforwardparty.org/api${list[0].imageUrl}/image",
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  } else if (list.length == null || list.length == 0) {
    return Container(
      color: Colors.orange,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            topImage(
              "https://today-api.moveforwardparty.org/api${list[0].imageUrl}/image",
            )
          ],
        ),
      ),
    );
  }
}

Widget searchAlbumCard(List<GallerySearchPost> list, BuildContext context) {
  if (list.length >= 4) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.6,
      width: double.infinity,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            getItems(
                list[0].signUrl != null ? list[0].signUrl : list[0].imageUrl,
                list[1].signUrl != null ? list[1].signUrl : list[1].imageUrl,
                0,
                context),
            getItems(
                list[2].signUrl != null ? list[2].signUrl : list[2].imageUrl,
                list[3].signUrl != null ? list[3].signUrl : list[3].imageUrl,
                list.length - 4,
                context),
          ],
        ),
      ),
    );
  } else if (list.length >= 3) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.6,
      width: double.infinity,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            getItems(
                list[0].signUrl != null
                    ? list[0].signUrl
                    : "https://today-api.moveforwardparty.org/api${list[0].imageUrl}/image",
                list[1].signUrl != null
                    ? list[1].signUrl
                    : "https://today-api.moveforwardparty.org/api${list[1].imageUrl}/image",
                0,
                context),
            Expanded(
              child: getItems(
                  list[2].signUrl != null
                      ? list[2].signUrl
                      : "https://today-api.moveforwardparty.org/api${list[2].imageUrl}/image",
                  list[2].signUrl != null
                      ? list[2].signUrl
                      : "https://today-api.moveforwardparty.org/api${list[2].imageUrl}/image" ??
                          "",
                  list.length - 3,
                  context),
            ),
          ],
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
            getItems(
                list[0].signUrl != null
                    ? list[0].signUrl
                    : "https://today-api.moveforwardparty.org/api${list[0].imageUrl}/image",
                list[1].signUrl != null
                    ? list[1].signUrl
                    : "https://today-api.moveforwardparty.org/api${list[1].imageUrl}/image",
                0,
                context),
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
            list[0].signUrl != null
                ? topImage(list[0].signUrl != null
                    ? list[0].signUrl
                    : "https://today-api.moveforwardparty.org/api${list[0].imageUrl}/image")
                : Container(),
          ],
        ),
      ),
    );
  }
}

Widget topImage(String image) {
  return Container(
    // height: 250.0,
    width: double.infinity,
    child: FullScreenWidget(
      child: Center(
        child: Hero(
          tag: "image" + image,
          child: image == null
              ? Container()
              : Image.network(
                  image,
                  fit: BoxFit.fill,
                ),
        ),
      ),
    ),
  );
}

Widget topImagePagesearch(String image) {
  return Container(
    // height: 250.0,
    width: double.infinity,
    child: FullScreenWidget(
      child: Center(
        child: Hero(
          tag: "image" + image,
          child: image == null
              ? Container()
              : Image.network(
                  "https://today-api.moveforwardparty.org/api$image/image",
                  fit: BoxFit.fill,
                ),
        ),
      ),
    ),
  );
}

Widget getItems(img_path, img_path2, count, BuildContext context) {
  return Container(
    width: double.infinity,
    child: Row(
      children: <Widget>[
        ClipRRect(
          child: Image.network(
            img_path,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace stackTrace) {
              return Container(
                  height: MediaQuery.of(context).size.height / 5.2,
                  width: MediaQuery.of(context).size.width / 2.0,
                  child: Image.asset('images/placeholder.jpg'));
            },
            height: MediaQuery.of(context).size.height / 5.2,
            width: MediaQuery.of(context).size.width / 2.0,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.low,
          ),
        ),
        (count > 0)
            ? Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  ClipRRect(
                    child: img_path2 != null
                        ? Image.network(
                            img_path2,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace stackTrace) {
                              return Container(
                                  height:
                                      MediaQuery.of(context).size.height / 5.2,
                                  width:
                                      MediaQuery.of(context).size.width / 2.0,
                                  child: Image.asset('images/placeholder.jpg'));
                            },
                            height: MediaQuery.of(context).size.height / 5.2,
                            width: MediaQuery.of(context).size.width / 2.0,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.low,
                          )
                        : Container(),
                  ),
                  (count > 0)
                      ? Positioned(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 5.2,
                            width: MediaQuery.of(context).size.width / 2.0,
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
                child: img_path2 != null
                    ? Image.network(
                        img_path2,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace stackTrace) {
                          return Container(
                              height: MediaQuery.of(context).size.height / 5.2,
                              width: MediaQuery.of(context).size.width / 2.0,
                              child: Image.asset('images/placeholder.jpg'));
                        },
                        height: MediaQuery.of(context).size.height / 5.2,
                        width: MediaQuery.of(context).size.width / 2.0,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.low,
                      )
                    : Container(),
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
        onPressed: () =>{},
      ),
      token == null || token == ""
          ? Padding(
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
          : InkWell(
              onTap: () => widgetprofile == null
                  ? null
                  : Navigate.pushPage(context, widgetprofile),
//                   onDoubleTap:(){
//                   showCupertinoModalBottomSheet(
//   context: context,
//   builder: (context) =>  SingleChildScrollView(
//     controller: ModalScrollController.of(context),
//     child: Infoview()),

// );

//                   },
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
    ],
  );
}

Widget AppBardetail(
    context, String lable, String authorposttext, IconButton icon) {
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
            onTap: () => {},
          ),
          PostButton(
            icon: Icon(
              MdiIcons.commentOutline,
              color: MColors.primaryBlue,
              size: 20.0,
            ),
            label: 'ความคิดเห็น',
            onTap: () => {},
          ),
          PostButton(
            icon: Icon(
              Icons.share,
              color: MColors.primaryBlue,
              size: 25.0,
            ),
            label: 'แชร์',
            onTap: () =>{},
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
            'images/error_404.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            fit: BoxFit.cover,
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Network Interruption',
                style: TextStyle(),
              )),
          SizedBox(
            height: 20,
          ),
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
              onPressed: () async {
                await checkInternetConnectivity().then((value) {
                  value == true
                      ? Navigate.pushPageReplacement(context, NavScreen())
                      : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.yellow,
                          content: Row(
                            children: [
                              Icon(
                                Icons.warning,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'ลองอีกครั้ง',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                          duration: Duration(milliseconds: 1000),
                          dismissDirection: DismissDirection.horizontal,
                        ));
                });
              
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
