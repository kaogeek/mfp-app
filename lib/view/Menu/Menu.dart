import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/view/Menu/webview.dart';
import 'package:mfp_app/view/Profile/profile.dart';
import 'package:mfp_app/view/Search/search.dart';

class MenuView extends StatefulWidget {
 bool taptoload1;

   MenuView({Key key, this.taptoload1}) : super(key: key);
  //  MenuSC({Key, bool taptoload1 ke, bool taptoload1y, this.taptoload1});



  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  var token;

  var userid;

  var userimageUrl;

  var datagetuserprofile;

  var image;

  String msg = "ยังไม่เปิดให้บริการ";

  @override
  void initState() {
    super.initState();
    setState(() {
      Api.gettoke().then((value) => value({
            token = value,
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
                        image = datagetuserprofile["data"]["imageURL"];
                      }),
                      ////('image$image'),
                    }
                })),
          }));
      Api.getimageURL().then((value) => ({
            setState(() {
              userimageUrl = value;
            }),
          }));
    });
  }
   void _goToElement(int index) {
    _trackingScrollController.animateTo(
        (100.0 *
            index), // 100 is the height of container and index of 6th element is 5
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
    setState(() {
      widget.taptoload1 = false;
    });
  }


  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    if (widget.taptoload1 == true) {
      _goToElement(0);
    }
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            controller: _trackingScrollController,
            slivers: [
              primaryAppBar(
                  context,
                  token,
                  userid,
                  image,
                  Search(),
                  ProfileSc(
                    userid: userid,
                    token: token,
                  )),
              SliverToBoxAdapter(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      ' ข้อมูลเกี่ยวกับพรรค',
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppTheme.FontAnakotmaiLight,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: InkWell(
                  onTap: () async {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (BuildContext context) {
                      return WebviewSc(
                        url: "https://donation.moveforwardparty.org/donation/",
                        texttitle: 'บริจาค',
                      );
                    }));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: 100,
                    height: MediaQuery.of(context).size.height / 5.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ]),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 10,
                          right: 0,
                          child: Image.asset("images/Group 11904.png"),
                          width: 99,
                          height: 99,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'บริจาค',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Anakotmai-Bold',
                                    fontSize: 24),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: AutoSizeText(
                                  'ซื้อสินค้าพรรคก้าวไกล สนับสนุนการ\nทำงานเพื่อประชาธิปไตย',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: AppTheme.SmallTextSize,
                                    fontFamily: AppTheme.FontAnakotmaiLight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: const SizedBox(
                height: 10,
              )),
              SliverToBoxAdapter(
                child: InkWell(
                  onTap: () async {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (BuildContext context) {
                      return WebviewSc(
                        url: "https://www.moveforwardparty.org/about/",
                        texttitle: 'เกี่ยวกับพรรค',
                      );
                    }));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: 100,
                    height: MediaQuery.of(context).size.height / 5.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: MColors.primaryBlue,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ]),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 10,
                          right: 0,
                          child: Image.asset("images/Group 11925.png"),
                          width: 99,
                          height: 99,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'เกี่ยวกับพรรค',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppTheme.FontAnakotmaiBold,
                                  fontSize: AppTheme.TitleTextSize,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: Text(
                                  'ซื้อสินค้าพรรคก้าวไกล สนับสนุนการ\nทำงานเพื่อประชาธิปไตย',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: AppTheme.SmallTextSize,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: AppTheme.FontAnakotmaiLight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      ' ข้อมูลเกี่ยวกับพรรค',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppTheme.FontAnakotmaiLight,
                        fontSize: AppTheme.BodyTextSize16,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => showAlertDialog(
                                    context,
                                    "พรรคก้าวไกล",
                                    "สำนักงานใหญ่\nเลขที่ 167 อาคารอนาคตใหม่ ชั้น 6\nรามคำแหง 42 แขวงหัวหมาก เขตบางกะปิ\nกรุงเทพมหานคร 10240\n",
                                    "ติดต่อเรา\n☎️02-821-5874 (จันทร์-ศุกร์ 10:00-18:00 น.)\n📧office@moveforwardparty.org\nMoveForwardPartyThailand\n@MFPThailand\nพรรคก้าวไกล - Move Forward Party",
                                    1.2,
                                    1.8),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.grey[200],
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(1),
                                          blurRadius: 0.5,
                                          spreadRadius: 0.5,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "images/Group_11912.png",
                                          width: 65,
                                          height: 55,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'ช่องทางการติดต่อ',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MColors.primaryBlue,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    AppTheme.FontAnakotmaiBold,
                                                fontSize:
                                                    AppTheme.BodyTextSize16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () => showAlertDialog(
                                    context,
                                    "พรรคก้าวไกล",
                                    "ยังไม่เปิดให้บริการ",
                                    "",
                                    1.5,
                                    5.5),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.grey[200],
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(1),
                                          blurRadius: 0.5,
                                          spreadRadius: 0.5,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "images/Group 11924.png",
                                          width: 65,
                                          height: 55,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'ร้องเรียน',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MColors.primaryBlue,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    AppTheme.FontAnakotmaiBold,
                                                fontSize:
                                                    AppTheme.BodyTextSize16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => Navigator.of(context).push(
                                    CupertinoPageRoute(
                                        builder: (BuildContext context) {
                                  return WebviewSc(
                                    url:
                                        "https://form.jotform.com/212451200314436",
                                    texttitle: 'อาสาสมัคร',
                                  );
                                })),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.grey[200],
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(1),
                                          blurRadius: 0.5,
                                          spreadRadius: 0.5,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "images/Group 11961.png",
                                          width: 65,
                                          height: 55,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'อาสาสมัคร',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MColors.primaryBlue,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    AppTheme.FontAnakotmaiBold,
                                                fontSize:
                                                    AppTheme.BodyTextSize16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () async {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (BuildContext context) {
                                    return WebviewSc(
                                      url:
                                          "https://www.moveforwardparty.org/person/parliament/",
                                      texttitle: 'บุคลากร',
                                    );
                                  }));
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.grey[200],
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(1),
                                          blurRadius: 0.5,
                                          spreadRadius: 0.5,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "images/Group 11962.png",
                                          width: 65,
                                          height: 55,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'บุคลากร',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MColors.primaryBlue,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    AppTheme.FontAnakotmaiBold,
                                                fontSize:
                                                    AppTheme.BodyTextSize16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
