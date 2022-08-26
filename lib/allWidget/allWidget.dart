import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/model/gallery.dart';
import 'package:mfp_app/allWidget/circle_button.dart';
import 'package:mfp_app/utils/app.style.config.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/utils/internetConnectivity.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/view/Auth/login-register.dart';
import 'package:mfp_app/view/NavigationBar/nav_screen.dart';

//APPBARS-------------------------------------

Widget myAlbumCard(List<Gallery> list, BuildContext context) {
  if (list.length >= 4) {
    return Container(
      //  color: Colors.yellow,
      height: MediaQuery.of(context).size.height / 2.6,
      // width: double.infinity,
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
            Image.network(
                "https://today-api.moveforwardparty.org/api${list[0].imageUrl}/image"),
            // list[0].signUrl != null
            //     ? topImage(
            //         "https://today-api.moveforwardparty.org/api${list[0].imageUrl}/image",
            //       )
            //     : SizedBox.shrink(),
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
            Image.network(
                "https://today-api.moveforwardparty.org/api${list[0].imageUrl}/image"),
            // topImage(
            //   ,
            // )
          ],
        ),
      ),
    );
  }
}

Widget searchAlbumCard(List<Gallery> list, BuildContext context) {
  if (list.length >= 4) {
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
            getItems(
                list[2].signUrl != null
                    ? list[2].signUrl
                    : "https://today-api.moveforwardparty.org/api${list[2].imageUrl}/image",
                list[3].signUrl != null
                    ? list[3].signUrl
                    : "https://today-api.moveforwardparty.org/api${list[3].imageUrl}/image",
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
            Image.network(
              "https://today-api.moveforwardparty.org/api${list[0].imageUrl}/image",
              fit: BoxFit.cover,
              filterQuality: FilterQuality.low,
            ),
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
        Image.network(
          img_path,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace stackTrace) {
            return Container(
                height: MediaQuery.of(context).size.height / 5.2,
                width: MediaQuery.of(context).size.width / 2.1,
                child: Image.asset('images/placeholder.jpg'));
          },
          height: MediaQuery.of(context).size.height / 5.2,
          width: AppStyle(context).getWidth(percent: 49),
          fit: BoxFit.cover,
          filterQuality: FilterQuality.low,
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
                                                             width: AppStyle(context).getWidth(percent: 47.5),

                                  child: Image.asset('images/placeholder.jpg'));
                            },
                            height: MediaQuery.of(context).size.height / 5.2,
                            width: AppStyle(context).getWidth(percent: 47.5),
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.low,
                          )
                        : Container(),
                  ),
                  (count > 0)
                      ? Positioned(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 5.2,
                            width: AppStyle(context).getWidth(percent: 47.5),
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
                            width: AppStyle(context).getWidth(percent: 47.5),
                              child: Image.asset('images/placeholder.jpg'));
                        },
                        height: MediaQuery.of(context).size.height / 5.2,
                            width: AppStyle(context).getWidth(percent: 47.5),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.low,
                      )
                    : Container(),
              ),
      ],
    ),
  );
}

showAlertDialog(BuildContext context, String text, String text1, String text2,
    double width, double height) {
  // set up the buttons

  Dialog dialog = Dialog(
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Container(
      width: MediaQuery.of(context).size.width / width,
      height: MediaQuery.of(context).size.height / height,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [primaryColor, secondaryColor]),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
                offset: const Offset(12, 26),
                blurRadius: 50,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.1)),
          ]),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CircleAvatar(
                backgroundColor: MColors.primaryBlue.withOpacity(.05),
                radius: 25,
                child: Image.asset(
                  "images/Group 11925.png",
                  fit: BoxFit.fill,
                  width: 25,
                  height: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: AutoSizeText(text1,
                  maxLines: 5,
                  minFontSize: 16,
                  maxFontSize: 18,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MColors.primaryWhite,
                    fontSize: 16,
                    fontFamily: AppTheme.FontAnakotmaiMedium,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: AutoSizeText(text2,
                  maxLines: 8,
                  minFontSize: 16,
                  maxFontSize: 18,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MColors.primaryWhite,
                    fontSize: 14,
                    fontFamily: AppTheme.FontAnakotmaiMedium,
                  )),
            ),
          ],
        ),
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
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
        onPressed: () => {
          showAlertDialog(context, "พรรคก้าวไกล", "ระบบอยู่ในระหว่างการพัฒนา",
              "", 1.5, 5.5),
        },
      ),
      token == null || token == ""
          ? Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.white70,
                child: IconButton(
                  iconSize: 27,
                  splashRadius: AppTheme.splashRadius,
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
      titleSpacing: 0.0,
      title: Text('$lable $authorposttext',
          style: TextStyle(
              fontSize: 16,
              color: MColors.textDark,
              fontFamily: AppTheme.FontAnakotmaiLight)),
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

Widget primaryAppBarProfile(context, var pageprofileimage, var title) {
  return SliverAppBar(
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    titleSpacing: 0.0,
    title: Row(
      children: [
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
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: CircleAvatar(
            radius: 25.0,
            backgroundImage: (pageprofileimage == null)
                ? NetworkImage('https://via.placeholder.com/150')
                : CachedNetworkImageProvider(
                    "https://today-api.moveforwardparty.org/api$pageprofileimage/image"),
            backgroundColor: Colors.transparent,
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: AppTheme.FontAnakotmaiMedium,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    ),
    automaticallyImplyLeading: false,
    centerTitle: false,
    floating: true,
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
