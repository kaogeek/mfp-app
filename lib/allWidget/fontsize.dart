import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/utils/timeutils.dart';
import 'package:mfp_app/view/Profile/Profliess.dart';

Widget titleK1(String string) => Text(
      string,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: MColors.textDark,
      ),
    );
Widget titletimeline(String string) => Text(
      string,
      style: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: MColors.textDark,
      ),
    );
Widget texttitlepost(String string, context) => Text(
      string,
      style: Theme.of(context).textTheme.headline1,
    );
Widget texttitle(String string, context) => Text(
      string,
      style: Theme.of(context).textTheme.headline4,
    );
Widget subtexttitlepost(String string, context) => Text(
      '$string',
      style: Theme.of(context).textTheme.bodyText1,
    );
Widget texttitleVideorecommend(String string, context) => Text(
      string,
      style: Theme.of(context).textTheme.headline4,
    );
Widget textsubVideorecommend(String string, context) => Text(
      string,
      style: Theme.of(context).textTheme.headline5,
    );
Widget fixtextauthor() => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        'ผู้เขียน:',
        style: TextStyle(
          fontFamily: 'Anakotmai-Light',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: MColors.textDark,
        ),
      ),
    );
Widget texttimetimestamp(DateTime dateTime) => Text(
      TimeUtils.readTimestamp(dateTime.millisecondsSinceEpoch),
      maxLines: 1,
      style: TextStyle(
        fontFamily: AppTheme.FontAnakotmaiLight,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: MColors.textGrey,
      ),
    );
Widget authorpost(
  String string,
  context,
  DateTime dateTime,
  String id,
  String imageUrl,
  String name,
  String pageUsername,
  String userid,
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
          fontFamily: AppTheme.FontAnakotmaiLight,
          fontSize: 15,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      // Text(
      //   '$string',
      //   style: Theme.of(context).textTheme.bodyText2,
      //   maxLines: 2,
      //   overflow: TextOverflow.ellipsis,
      // ),
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
Widget textreadstory(String string) => Text(
      string,
      style: TextStyle(
        fontFamily: AppTheme.FontAnakotmaiLight,
        fontSize: 18,
        // fontWeight: FontWeight.bold,
        color: MColors.primaryColor,
      ),
    );
