import 'package:flutter/material.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app.style.config.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/utils/timeutils.dart';
import 'package:mfp_app/view/Profile/Profliess.dart';


Widget titletimeline(String string,BuildContext context) => Text(
      string,
      style: TextStyle(
        fontSize: AppStyle(context).getWidth(percent: 5.5),
        fontWeight: FontWeight.bold,
        color: MColors.textDark,
      ),
    );
Widget texttitlepost(String string, context) => Text(
      string,
      style: TextStyle(
    // h4 -> display1 // post titel
    fontFamily:AppTheme. FontAnakotmaiBold,
    fontSize:AppStyle(context).getWidth(percent: 6),
    color: MColors.primaryBlue,
  ),
    );
Widget texttitle(String string, context) => Text(
      string,
      style: TextStyle(
    // h4 -> display1
    fontFamily:AppTheme.FontAnakotmaiLight,
    fontSize: AppStyle(context).getWidth(percent: 5.5),

    color: MColors.primaryBlue,
  ),
    );
Widget subtexttitlepost(String string, context) => Text(
      '$string',
      style: TextStyle(
    // h4 -> display1
    fontFamily:AppTheme.FontSarabunLight,
    fontSize: AppStyle(context).getWidth(percent: 4.5),

    color: MColors.primaryBlue),
    );
Widget texttitleVideorecommend(String string, context) => Text(
      string,
      style: TextStyle(   
        //  fontFamily: AppTheme.FontAnakotmaiLight,
    fontSize:AppStyle(context).getWidth(percent: 4.5),
    // fontWeight: FontWeight.w400,
    color: MColors.textDark,),
    );
Widget textsubVideorecommend(String string, context) => Text(
      string,
      style: Theme.of(context).textTheme.headline5,
    );
Widget fixtextauthor(BuildContext context) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        'ผู้เขียน:',
        style: TextStyle(
          fontFamily: AppTheme.FontAnakotmaiBold,
          fontSize: AppStyle(context).getWidth(percent: 4.0),
          // fontWeight: FontWeight.w500,
          color: MColors.textDark,
        ),
      ),
    );
Widget texttimetimestamp(DateTime dateTime,BuildContext context )=> Text(
      TimeUtils.readTimestamp(dateTime.millisecondsSinceEpoch),
      maxLines: 1,
              overflow: TextOverflow.ellipsis,

      style: TextStyle(
        fontFamily: AppTheme.FontAnakotmaiLight,
        fontSize: AppStyle(context).getWidth(percent: 4.0),
        fontWeight: FontWeight.w300,
        color: MColors.textGrey,
        overflow: TextOverflow.ellipsis
      ),
    );
Widget authorpost(
  String string,
  context,
  String id,
  bool isenable,
) =>
    InkWell(
      onTap: isenable == false
          ? null
          : () => Navigate.pushPage(
              context,
              Profliess(
                id: id,
              )),
      child: Text(
        'ผู้เขียน: $string ',
        maxLines: 1,
        style: TextStyle(
          color: MColors.primaryColor,
          fontWeight: FontWeight.w300,
          fontFamily: AppTheme.FontAnakotmaiBold,
          fontSize: AppStyle(context).getWidth(percent: 4.0),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
Widget texthashtags(String string) => Text(
      string,
      style: TextStyle(
        fontFamily: AppTheme.FontAnakotmaiLight,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: MColors.primaryWhite,
      ),
    );
Widget textreadstory(String string,BuildContext context) => Text(
      string,
      style: TextStyle(
        fontFamily: AppTheme.FontAnakotmaiLight,
        fontWeight: FontWeight.bold,
        fontSize: AppStyle(context).getWidth(percent: 4.5),
        color: MColors.primaryColor,
      ),
    );
