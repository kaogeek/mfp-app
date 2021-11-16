import 'package:flutter/material.dart';
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
    return Container(
      color: MColors.primaryWhite,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/1200.png'), fit: BoxFit.fill)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
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
                    Padding(padding: EdgeInsets.only(top: 100)),
                    Column(
                      children: [
                        Center(
                          child: Text(
                            "เราอยากให้ทุกคนมี",
                            style: TextStyle(
                                fontFamily: AppTheme.FontAnakotmaiLight,
                                fontSize: 25,
                                // fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Center(
                          child: Text(
                            "เสรีภาพ เสมอภาค ภราดรภาพ",
                            style: TextStyle(
                                fontFamily: AppTheme.FontAnakotmaiLight,
                                fontSize: 25,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                      top: 110,
                    )),
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
                    Padding(
                        padding: EdgeInsets.only(
                      top: 25,
                    )),
                    //-------------------------------เข้าสู่ระบบด้วย Email-------------------------------//
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              //padding: EdgeInsets.only(top: 10, bottom: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Row(
                                children: [
                                  // Padding(
                                  //   padding: EdgeInsets.only(left: 110),
                                  // ),
                                  Container(
                                    height: 60.0,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('images/Email.png'),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                  ),
                                  Text(
                                    'เข้าสู่ระบบด้วย Email',
                                    style: TextStyle(
                                      fontFamily: AppTheme.FontAnakotmaiLight,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              textColor: Colors.black,
                              color: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Loginemail()),
                                );
                                print('กด');
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    //-------------------------------------------------------------------------------//
                    Padding(
                        padding: EdgeInsets.only(
                      top: 5,
                    )),
                    //-----------------------------เข้าสู่ระบบด้วย Facebook------------------------------//
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              //padding: EdgeInsets.only(top: 10, bottom: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Row(
                                children: [
                                  // Padding(
                                  //   padding: EdgeInsets.only(left: 110),
                                  // ),
                                  Container(
                                    height: 60.0,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage('images/facebook.png'),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                  ),
                                  Text(
                                    'เข้าสู่ระบบด้วย Facebook',
                                    style: TextStyle(
                                      fontFamily: AppTheme.FontAnakotmaiLight,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              textColor: Colors.white,
                              color: Colors.blue[700],
                              onPressed: () {
                                print('กด');
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    //-------------------------------------------------------------------------------//
                    Padding(
                        padding: EdgeInsets.only(
                      top: 5,
                    )),
                    //------------------------------เข้าสู่ระบบด้วย Twitter------------------------------//
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              //padding: EdgeInsets.only(top: 10, bottom: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Row(
                                children: [
                                  // Padding(
                                  //   padding: EdgeInsets.only(left: 110),
                                  // ),
                                  Container(
                                    height: 60.0,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage('images/twitter1.png'),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                  ),
                                  Text(
                                    'เข้าสู่ระบบด้วย Twitter',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: AppTheme.FontAnakotmaiLight,
                                    ),
                                  ),
                                ],
                              ),
                              textColor: Colors.white,
                              color: Colors.blue[300],
                              onPressed: () {
                                print('กด');
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    //-------------------------------------------------------------------------------//
                    // Padding(

                    // )),
                  ],
                ),
              ),
              // Padding(
              //     padding: EdgeInsets.only(
              //   bottom: 100.0,
              // )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '© 2021 พรรคก้าวไกล. ALL RIGHTS RESERVED.',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: AppTheme.FontAnakotmaiLight,
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
