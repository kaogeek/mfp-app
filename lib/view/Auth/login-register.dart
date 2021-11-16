import 'package:flutter/material.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/view/Auth/login.dart';

class Loginregister extends StatefulWidget {
  Loginregister({Key key}) : super(key: key);

  @override
  _LoginregisterState createState() => _LoginregisterState();
}

class _LoginregisterState extends State<Loginregister> with TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MColors.primaryWhite,
      child: SafeArea(
        child: Scaffold(
              body: SingleChildScrollView(
                controller: _scrollController,
                      physics: BouncingScrollPhysics(),
                child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Container(
                    height: 280,
                    width: 280,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('images/MFP-Logo-Verticle.png'),
                    )),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 50)),
              //----------------------------------สร้างบัญชีก้าวไกล-------------------------------//
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          'สร้างบัญชีก้าวไกล',
                          style: TextStyle(
      // body2 -> body1
        fontFamily: AppTheme.FontAnakotmaiLight,
          fontSize: AppTheme.BodyTextSize,
          color: MColors.primaryWhite,
  ),
                        ),
                        textColor: Colors.white,
                        color: MColors.primaryBlue,
                        onPressed: () {
                          print("กด");
                        },
                      ),
                    )
                  ],
                ),
              ),
              //-------------------------------------------------------------------------------//
              Padding(padding: EdgeInsets.only(top: 20)),
              //------------------------------------เข้าสู่ระบบ-----------------------------------//
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          'เข้าสู่ระบบ',
                          style: TextStyle(
      // body2 -> body1
        fontFamily: AppTheme.FontAnakotmaiLight,
          fontSize: AppTheme.BodyTextSize,
          color: MColors.primaryWhite,
  ),
                        ),
                        textColor: MColors.primaryWhite,
                        color: MColors.primaryColor,
                        onPressed: () {
                          Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Login()),
                              );
                          print("กด");
                        },
                      ),
                    )
                  ],
                ),
              ),
              //-------------------------------------------------------------------------------//
              Padding(padding: EdgeInsets.only(top: 20)),
              Center(
                child: TextButton(
                  child: Text("Skip for new",style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    print("กด");
                  },
                )
              )
            ],
          ),
              ),
              
          ),
      ),
    );
  }
}
