import 'package:flutter/material.dart';
import 'package:mfp_app/allWidget/sizeconfig.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/view/Auth/login.dart';
import 'package:mfp_app/view/Auth/register-email.dart';

class Loginregister extends StatefulWidget {
  Loginregister({Key key}) : super(key: key);

  @override
  _LoginregisterState createState() => _LoginregisterState();
}

class _LoginregisterState extends State<Loginregister>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final screenhight = MediaQuery.of(context).size.height;
    final statusbarheight = MediaQuery.of(context).padding.top;
    SizeConfig().init(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.18,
                child: Row(
                  children: [
                    IconButton(
                      splashRadius: AppTheme.splashRadius,
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: MColors.primaryColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        //('กด');
                      },
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: SizeConfig.screenHeight * 0.4,
                  //  width: SizeConfig.blockSizeHorizontal * 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('images/MFP-Logo-Verticle.png'),
                  )),
                ),
              ),

              //----------------------------------สร้างบัญชีก้าวไกล-------------------------------//
              SizedBox(
                height: SizeConfig.screenHeight * 0.10,
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child:
                        _Buttion('เข้าสู่ระบบ', Login(), MColors.primaryColor),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: Text(
                        'สร้างบัญชีก้าวไกล',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: AppTheme.FontAnakotmaiLight,
                            color: MColors.primaryBlue,),
                      ))
                ],
              ),

              //-------------------------------------------------------------------------------//
            ],
          ),
        ),
      ),
    );
  }

  Widget _Buttion(String text, Widget widget, Color colors) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(top: 15, bottom: 15), backgroundColor: colors,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => widget),
                );
                //print("กด");
                //("กด");
              },
              child: Text(
                text,
                style: TextStyle(
                  // body2 -> body1
                  fontFamily: AppTheme.FontAnakotmaiLight,
                  fontSize: AppTheme.BodyTextSize,
                  color: MColors.primaryWhite,
                ),
              ),
            ),

          )
        ],
      ),
    );
  }
}
