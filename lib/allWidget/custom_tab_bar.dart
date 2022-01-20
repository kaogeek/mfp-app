import 'package:flutter/material.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';

class CustomTabBar extends StatelessWidget {
  final List<IconData> icons;
  final List<String> iconsimage;

  final int selectedIndex;
  final Function(int) onTap;
  final bool isBottomIndicator;
  final List lable;

  CustomTabBar({
    Key key,
    @required this.icons,
    @required this.selectedIndex,
    @required this.onTap,
    this.isBottomIndicator = false,
    @required this.lable,
    this.iconsimage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
        border: isBottomIndicator
            ? Border(
                bottom: BorderSide(
                  color: MColors.primaryColor,
                  width: 3.0,
                ),
              )
            : Border(
                top: BorderSide(
                  color: MColors.primaryColor,
                  width: 3.0,
                ),
              ),
      ),
      labelStyle: TextStyle(
        fontSize: 12,
        fontFamily: AppTheme.FontAnakotmaiLight,
      ),
      labelColor: Colors.black,
      tabs:
          // _tabs,
          icons
              .asMap()
              .map((i, e) => MapEntry(
                    i,
                    Tab(
                      iconMargin: EdgeInsets.only(bottom: 10.0),
                      // text: "data",
                      icon: Image.asset(
                        iconsimage[i],
                        color: i == selectedIndex
                            ? MColors.primaryColor
                            : Colors.grey[500],
                        width: 21,
                        height: 21,
                      ),
                      text: lable[i],
                    ),
                  ))
              .values
              .toList(),
      onTap: onTap,
    );
  }
}
