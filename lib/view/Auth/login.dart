import 'package:flutter/material.dart';
import 'package:mfp_app/allWidget/sizeconfig.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/view/Auth/loginemail.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final screenhight = MediaQuery.of(context).size.height;
    final screentop = MediaQuery.of(context).padding;

    return Container(
      color: MColors.primaryWhite,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/shutterstock_553511089.png'),
            fit: BoxFit.cover,
          )),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.18,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_sharp,
                            size: 40,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            print('กด');
                          },
                        ),
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
                  SizedBox(
                    height: SizeConfig.screenHeight / 9.0,
                  ),
                  Column(
                    children: [
                      Center(
                        child: Text(
                          "เราอยากให้ทุกคนมี",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontFamily: AppTheme.FontAnakotmaiLight,
                              fontSize: 25,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Text(
                        "เสรีภาพ เสมอภาค ภราดรภาพ",
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: AppTheme.FontAnakotmaiLight,
                            fontSize: 25,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenhight / 6.0,
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: Text(
                              'เข้าสู่ระบบด้วย',
                              style: TextStyle(
                                  fontFamily: AppTheme.FontAnakotmaiLight,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // SizedBox(
                  //   height: SizeConfig.screenHeight * 0.11,
                  // ),

                  //-------------------------------เข้าสู่ระบบด้วย Email-------------------------------//

                  //------------------------------เข้าสู่ระบบด้วย Twitter------------------------------//
                  _bution('เข้าสู่ระบบด้วยEmail', 'images/Email.png',
                      Loginemail(), Color(0xFFE5E5E5), MColors.primaryBlue),
                  _bution('เข้าสู่ระบบด้วยFacebook', 'images/facebook.png',
                      null, Color(0xFF1877F2), Colors.white),
                  _bution('เข้าสู่ระบบด้วยTwitter', 'images/twitter.png', null,
                      Color(0xFF1DA1F3), Colors.white),

                  Container(
                    //color: Colors.black,
                    child: Text(
                      '© 2021 พรรคก้าวไกล. ALL RIGHTS RESERVED.',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppTheme.FontAnakotmaiLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bution(String text, String textassetimage, Widget widget, Color color,
      Color textColor) {
    return Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Row(
              children: [
                Container(
                  height: SizeConfig.screenHeight / 13.0,
                  width: SizeConfig.screenWidth / 7,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(textassetimage),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(left: 2),
                // ),
                Text(
                  text,
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: AppTheme.FontAnakotmaiLight,
                  ),
                ),
              ],
            ),
            textColor: textColor,
            color: color,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => widget),
              );
            },
          ),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.09,
        ),
      ],
    );
  }
}
