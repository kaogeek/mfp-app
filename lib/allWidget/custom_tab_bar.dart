import 'package:flutter/material.dart';
import 'package:mfp_app/constants/colors.dart';

class CustomTabBar extends StatelessWidget {
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;
  final bool isBottomIndicator;
  final String lable;

  CustomTabBar({
    Key key,
    @required this.icons,
    @required this.selectedIndex,
    @required this.onTap,
    this.isBottomIndicator = false,
    @required this.lable,
  }) : super(key: key);

  final List<Tab> _tabs = [
    Tab(
        icon: Icon(
          Icons.account_circle,
          color: Colors.black,
        ),
        text: 'User Info'),
    Tab(
      icon: Icon(Icons.chat_bubble),
      text: 'Messages',
    ),
    Tab(
      icon: Icon(Icons.photo_size_select_actual),
      text: 'Multimedia',
    ),
    Tab(
      icon: Icon(Icons.show_chart),
      text: 'Statistics',
    ),
  ];
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
        fontSize: 14,
      ),
      tabs:
          // _tabs,
          icons
              .asMap()
              .map((i, e) => MapEntry(
                    i,
                    Tab(
                      iconMargin: EdgeInsets.only(bottom: 2.0),
                      // text: "data",
                      icon: Icon(
                        e,
                        color: i == selectedIndex
                            ? MColors.primaryColor
                            : Colors.grey[500],
                        size: 30.0,
                      ),
                    ),
                  ))
              .values
              .toList(),
      onTap: onTap,
    );
  }
}
