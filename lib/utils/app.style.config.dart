//@ dart=2.9
import 'package:flutter/material.dart';
import 'package:mfp_app/utils/app.size.config.dart';

class AppStyle {
  BuildContext _context;
  AppSizeConfig _appSizeConfig;

  AppStyle(BuildContext context) {
    _context = context;
    _appSizeConfig = AppSizeConfig(_context);
    _buildCustomTextStyle();
    _buildCustomButtonStyle();
    _buildCustomCardStyle();
  }

  double getWidth({double percent}) {
    if (percent != null) {
      return _appSizeConfig.getBlockSizeHorizontal(percent: percent);
    } else {
      return _appSizeConfig.getBlockSizeHorizontal(percent: 1);
    }
  }

  double getWidth100() {
    return _appSizeConfig.screenWidth;
  }

  double getHeight({double percent}) {
    if (percent != null) {
      return _appSizeConfig.getBlockSizeVertical(percent: percent);
    } else {
      return _appSizeConfig.getBlockSizeVertical(percent: 1);
    }
  }

  double getHeight100() {
    return _appSizeConfig.screenHeight;
  }

  EdgeInsets getEdgeInsets(
      {double all, double left, double top, double right, double bottom}) {
    if (all != null) {
      return EdgeInsets.all(all);
    } else {
      // ignore: prefer_if_null_operators
      left = left != null ? left : 0;
      // ignore: prefer_if_null_operators
      top = top != null ? top : 0;
      // ignore: prefer_if_null_operators
      right = right != null ? right : 0;
      // ignore: prefer_if_null_operators
      bottom = bottom != null ? bottom : 0;
      return EdgeInsets.only(
          left: left, top: top, right: right, bottom: bottom);
    }
  }

  EdgeInsets getEdgeInsetsFromRatio(
      {double all, double left, double top, double right, double bottom}) {
    if (all != null) {
      return EdgeInsets.symmetric(
          vertical: getHeight(percent: all),
          horizontal: getWidth(percent: all));
    } else {
      // ignore: prefer_if_null_operators
      left = left != null ? left : 0;
      // ignore: prefer_if_null_operators
      top = top != null ? top : 0;
      // ignore: prefer_if_null_operators
      right = right != null ? right : 0;
      // ignore: prefer_if_null_operators
      bottom = bottom != null ? bottom : 0;

      return EdgeInsets.only(
          left: getWidth(percent: left),
          top: getHeight(percent: top),
          right: getWidth(percent: right),
          bottom: getHeight(percent: bottom));
    }
  }

  Map<String, dynamic> _textStyle;
  Map<String, dynamic> _cardStyle;

  TextStyle getTextStyle(String styleName) {
    if (_textStyle.containsKey(styleName)) {
      return _textStyle[styleName];
    } else {
      return Theme.of(_context).textTheme.bodyText2;
    }
  }

  BoxDecoration getCardStype(String styleName) {
    if (_cardStyle.containsKey(styleName)) {
      return _cardStyle[styleName];
    } else {}
  }

  _buildCustomTextStyle() {
    // _textStyle['smallWhite2'] = TextStyle(
    //     fontSize: getWidth(percent: 4.5),
    //     fontWeight: Theme.of(_context).textTheme.bodyText2.fontWeight,
    //     fontFamily: Theme.of(_context).textTheme.bodyText2.fontFamily,
    //     color: AppTheme.colorFontWhite);

    // _textStyle['appBar'] = TextStyle(
    //     fontSize: getWidth(percent: 6.5),
    //     fontWeight: Theme.of(_context).textTheme.bodyText2.fontWeight,
    //     fontFamily: Theme.of(_context).textTheme.bodyText2.fontFamily,
    //     color: AppTheme.colorBlack);

    // _textStyle['appBarWhite'] = TextStyle(
    //     fontSize: getWidth(percent: 5.5),
    //     fontWeight: Theme.of(_context).textTheme.bodyText2.fontWeight,
    //     fontFamily: Theme.of(_context).textTheme.bodyText2.fontFamily,
    //     color: AppTheme.colorBackgroundWhite);

    // _textStyle['titleText'] = TextStyle(
    //     fontSize: Theme.of(_context).textTheme.headline6.fontSize,
    //     fontWeight: Theme.of(_context).textTheme.bodyText2.fontWeight,
    //     fontFamily: Theme.of(_context).textTheme.bodyText2.fontFamily,
    //     color: AppTheme.colorFontWhite);

    // _textStyle['titleTextBlack'] = TextStyle(
    //     fontSize: getWidth(percent: 6),
    //     fontWeight: FontWeight.w400,
    //     fontFamily: Theme.of(_context).textTheme.bodyText2.fontFamily,
    //     color: AppTheme.colorFontBlack);

    // _textStyle['titleTextBlackBold'] = TextStyle(
    //     fontSize: Theme.of(_context).textTheme.headline6.fontSize,
    //     fontWeight: FontWeight.bold,
    //     fontFamily: Theme.of(_context).textTheme.bodyText2.fontFamily,
    //     color: AppTheme.colorFontBlack);

    // _textStyle['normalText'] = TextStyle(
    //     fontSize: getWidth(percent: 4.5),
    //     fontWeight: Theme.of(_context).textTheme.bodyText2?.fontWeight,
    //     fontFamily: Theme.of(_context).textTheme.bodyText2.fontFamily,
    //     color: AppTheme.colorFontWhite);

    // _textStyle['normalBlack'] = TextStyle(
    //     fontSize: getWidth(percent: 4),
    //     fontWeight: Theme.of(_context).textTheme.bodyText2.fontWeight,
    //     fontFamily: Theme.of(_context).textTheme.bodyText2.fontFamily,
    //     color: AppTheme.colorFontBlack);

    // _textStyle['normalTextBold'] = TextStyle(
    //     fontSize: getWidth(percent: 10),
    //     fontWeight: FontWeight.w400,
    //     fontFamily: Theme.of(_context).textTheme.bodyText2.fontFamily,
    //     color: AppTheme.colorFontWhite);

    // _textStyle['normalBlackBold'] = TextStyle(
    //     fontSize: getWidth(percent: 4),
    //     fontWeight: FontWeight.bold,
    //     fontFamily: Theme.of(_context).textTheme.bodyText2.fontFamily,
    //     color: AppTheme.colorFontBlack);

    // _textStyle['normalPrimary'] = TextStyle(
    //     fontSize: getWidth(percent: 4.5),
    //     fontWeight: Theme.of(_context).textTheme.bodyText2.fontWeight,
    //     fontFamily: Theme.of(_context).textTheme.bodyText2.fontFamily,
    //     color: AppTheme.colorTextPrimary);

    // _textStyle['normalPrimaryBold'] = TextStyle(
    //     fontSize: getWidth(percent: 4.5),
    //     fontWeight: FontWeight.bold,
    //     fontFamily: Theme.of(_context).textTheme.bodyText2.fontFamily,
    //     color: AppTheme.colorTextPrimary);

    // _textStyle['normalBadge'] = TextStyle(
    //     fontSize: getWidth(percent: 4.5),
    //     fontWeight: FontWeight.normal,
    //     fontFamily: Theme.of(_context).textTheme.caption.fontFamily,
    //     color: AppTheme.colorTextPrimary);

    // _textStyle['normalBadgeGray'] = TextStyle(
    //     fontSize: getWidth(percent: 4.5),
    //     fontWeight: FontWeight.normal,
    //     fontFamily: Theme.of(_context).textTheme.caption.fontFamily,
    //     color: AppTheme.colorBlack);

    // _textStyle['normalWhiteBadge'] = TextStyle(
    //     fontSize: getWidth(percent: 4.5),
    //     fontWeight: FontWeight.normal,
    //     fontFamily: Theme.of(_context).textTheme.caption.fontFamily,
    //     color: AppTheme.colorFontWhite);

    // _textStyle['normalTitle'] = TextStyle(
    //     fontSize: getWidth(percent: 4.5),
    //     fontWeight: FontWeight.w400,
    //     fontFamily: Theme.of(_context).textTheme.caption.fontFamily,
    //     color: AppTheme.colorGrey);

    // _textStyle['newNormalText'] = TextStyle(
    //     fontSize: getWidth(percent: 3.3),
    //     fontWeight: Theme.of(_context).textTheme.bodyText1.fontWeight,
    //     fontFamily: 'NotoSansThai-Thin',
    //     color: AppTheme.colorBlack);
  }

  _buildCustomButtonStyle() {}

  _buildCustomCardStyle() {
    //   _cardStyle['normalShadow'] = BoxDecoration(
    //     color: AppTheme.colorBackgroundWhite,
    //     borderRadius: const BorderRadius.all(Radius.circular(3.0)),
    //     boxShadow: [
    //       BoxShadow(
    //         color: AppTheme.colorGrey.withOpacity(1.0),
    //         spreadRadius: 1,
    //         blurRadius: 5,
    //         offset: const Offset(0, 0), // changes position of shadow
    //       ),
    //     ],
    //   );

    //   _cardStyle['noShadow'] = BoxDecoration(
    //     color: AppTheme.colorBackgroundWhite,
    //     borderRadius: const BorderRadius.all(Radius.circular(3.0)),
    //     boxShadow: [
    //       BoxShadow(
    //         color: AppTheme.colorGrey.withOpacity(0.3),
    //         spreadRadius: 1,
    //         blurRadius: 1,
    //         offset: const Offset(0, 2), // changes position of shadow
    //       ),
    //     ],
    //   );

    //   _cardStyle['textShadow'] = BoxDecoration(
    //     color: AppTheme.colorBackgroundWhite,
    //     borderRadius: const BorderRadius.all(Radius.circular(8.0)),
    //     boxShadow: [
    //       BoxShadow(
    //         color: AppTheme.colorGrey.withOpacity(1),
    //         spreadRadius: 1,
    //         blurRadius: 5,
    //         offset: const Offset(0, 0), // changes position of shadow
    //       ),
    //     ],
    //   );

    //   _cardStyle['titleShadow'] = BoxDecoration(
    //       boxShadow: [
    //         BoxShadow(
    //           color: AppTheme.colorGrey.withOpacity(0.9),
    //           spreadRadius: 1,
    //           blurRadius: 5,
    //           offset: const Offset(0, 0), // changes position of shadow
    //         ),
    //       ],
    //       borderRadius: BorderRadius.circular(12),
    //       border: Border.all(
    //         width: 1,
    //         color: AppTheme.colorPrimary,
    //       ),
    //       color: AppTheme.colorPrimaryDark);
  }
}
