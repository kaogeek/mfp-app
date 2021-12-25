import 'package:flutter/material.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/style.dart';

class AppTheme {
  AppTheme._();

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'WorkSans';

  static const String FontAnakotmaiLight = "Anakotmai-Light";
  static const String FontAnakotmaiBold = "Anakotmai-Bold";
  static const String FontAnakotmaiMedium = "Anakotmai-Medium";

  static const LargeTextSize = 20.0;
  static const MediumTextSize = 20.0;
  static const BodyTextSize = 18.0;
  static const BodyTextSize16 = 16.0;
  static const BodyTextSize24 = 24.0;
  static const BodyTextSize20 = 20.0;
  static const BodyTextSize12 = 12.0;

  static const SmallTextSize = 14.0;

  static const TitleTextSize = 23.0;

  static const TextTheme textTheme = TextTheme(
    headline1: display2,
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    subtitle1: subtitle1,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );
  static const TextStyle display2 = TextStyle(
    // h4 -> display1 // post titel
    fontFamily: FontAnakotmaiBold,
    fontSize: TitleTextSize,
    fontWeight: FontWeight.bold,
    color: MColors.primaryBlue,
  );

  static const TextStyle display1 = TextStyle(
    // h4 -> display1
    fontFamily: FontAnakotmaiMedium,
    fontSize: BodyTextSize,
    fontWeight: FontWeight.bold,

    color: MColors.primaryBlue,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: FontAnakotmaiLight,
    fontSize: SmallTextSize,
    color: MColors.textGrey,
  );

  static const TextStyle title = TextStyle(
    // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );
  static const TextStyle subtitle1 = TextStyle(
    // subtitle1 -> subtitle1
    fontFamily: FontAnakotmaiMedium,
    fontSize: SmallTextSize,
    fontWeight: FontWeight.bold,
    color: MColors.primaryBlue,
  );

  static const TextStyle body2 = TextStyle(
    // body1 -> body2
    fontFamily: FontAnakotmaiLight,
    fontSize: SmallTextSize,
    fontWeight: FontWeight.w500,
    color: MColors.primaryColor,
  );

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: FontAnakotmaiLight,
    fontSize: BodyTextSize,
    fontWeight: FontWeight.w400,
    color: MColors.textDark,
  );

  static const TextStyle caption = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}
