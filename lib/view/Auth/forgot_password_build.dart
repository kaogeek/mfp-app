import 'package:flutter/material.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/utils/internetConnectivity.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/view/NavigationBar/nav_screen.dart';

class ForgotPasswordBuild extends StatefulWidget {
  final String displayName;
  final String image;
  ForgotPasswordBuild({Key key, this.displayName, this.image})
      : super(key: key);

  @override
  State<ForgotPasswordBuild> createState() => _ForgotPasswordBuildState();
}

class _ForgotPasswordBuildState extends State<ForgotPasswordBuild> {
  var msg;

  var msgres;
  bool isloading = false;

  @override
  void initState() {
    // checkInternetConnectivity().then((value) {
    //   value == true
    //       ? () {}()
    //       : Navigate.pushPageDialog(context, nonet(context));
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/shutterstock_553511089.png'),
              colorFilter:
                  ColorFilter.mode(Colors.grey[500], BlendMode.modulate),
              fit: BoxFit.cover,
            )),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.19,
                    child: Row(
                      children: [
                        Spacer(),
                        Container(
                          height: 100,
                          width: 170,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('images/MFP-Logo-Horizontal.png'),
                          )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //color: Colors.black,
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.86,
                  ),
                  Container(
                    alignment: Alignment.center,
                    // color: Colors.black,
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.86,
                    child: Text('เปลี่ยนรหัสผ่านสำเร็จ',
                        style: TextStyle(
                            fontFamily: AppTheme.FontAnakotmaiMedium,
                            fontSize: 25,
                            color: MColors.primaryWhite,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    // color: Colors.black,
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: MediaQuery.of(context).size.width * 0.86,
                    child: Text(
                        'คุณสามารถเข้าบัญชีของคุณผ่านรหัสผ่านใหม่ได้แล้ว',
                        style: TextStyle(
                            fontFamily: AppTheme.FontAnakotmaiMedium,
                            fontSize: 18,
                            color: MColors.primaryWhite,
                            fontWeight: FontWeight.bold)),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        //-------------------รูปโปรไฟล์----------------//
                        //color: Colors.grey,
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: CircleAvatar(
                          radius: (80),
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 108.0,
                            backgroundImage: NetworkImage(
                                "https://today-api.moveforwardparty.org/api${widget.image}/image"),
                          ),
                        )),
                  ),
                  Container(
                    //color: Colors.black,
                    height: MediaQuery.of(context).size.height * 0.02,
                    width: MediaQuery.of(context).size.width * 0.86,
                  ),
                  Container(
                    //color: Colors.black,
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width * 0.86,
                    child: Center(
                        child: Text(
                      '${widget.displayName}',
                      style: TextStyle(
                          fontSize: AppTheme.BodyTextSize20,
                          fontFamily: AppTheme.FontAnakotmaiLight,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white),
                    )),
                  ),
                  Container(
                    //color: Colors.black,
                    height: MediaQuery.of(context).size.height * 0.01,
                    width: MediaQuery.of(context).size.width * 0.86,
                  ),
                  SizedBox(
                    //color: Colors.white,
                    height: MediaQuery.of(context).size.height / 25,
                  ),
                  isloading == true
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: ElevatedButton(
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 15),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(color: Colors.red)),
                                    primary: MColors.primaryColor,
                                  ),
                                  onPressed: null,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: MColors.primaryColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  padding: EdgeInsets.only(top: 15, bottom: 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(color: Colors.red)),
                                  child: Text(
                                    'เสร็จ',
                                    style: TextStyle(
                                      fontSize: AppTheme.BodyTextSize20,
                                      fontFamily: AppTheme.FontAnakotmaiLight,
                                    ),
                                  ),
                                  textColor: Colors.white,
                                  color: MColors.primaryColor,
                                  onPressed: () async {
                                    Navigate.pushPageReplacement(
                                        context, NavScreen());
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
