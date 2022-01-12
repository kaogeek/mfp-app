import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.18,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_sharp,
                        size: 40,
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
                  _Buttion(
                      'สร้างบัญชีก้าวไกล', Register(), MColors.primaryBlue),
                  SizedBox(
                    height: 5,
                  ),
                  _Buttion('เข้าสู่ระบบ', Login(), MColors.primaryColor),
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
            child: RaisedButton(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                text,
                style: TextStyle(
                  // body2 -> body1
                  fontFamily: AppTheme.FontAnakotmaiLight,
                  fontSize: AppTheme.BodyTextSize,
                  color: MColors.primaryWhite,
                ),
              ),
              textColor: Colors.white,
              color: colors,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => widget),
                );
                //print("กด");
                //("กด");
              },
            ),
          )
        ],
      ),
    );
  }
}
