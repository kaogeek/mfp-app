import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/custom_tab_bar.dart';
import 'package:mfp_app/view/Doing/doing.dart';
import 'package:mfp_app/view/Menu/menu.dart';
import 'package:mfp_app/view/Shop/shop.dart';
import 'package:mfp_app/view/Today/today_Sc.dart';
import 'dart:io' show Platform;

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  var userid;
  int _selectedIndex = 0;
  bool taptoload = false;
  @override
  void initState() {
    super.initState();


    Api.getmyuid().then((value) => ({
          setState(() {
            userid = value;
          }),
        }));
  }

  List<Widget> _screens() {
    return [
      TodaySc(
        userid: userid,
        taptoload: taptoload,
      ),
      DoingSC(),
      ShopSC(),
      MenuSC(),
    ];
  }

  final List<String> _iconsimage = const [
    'images/Today_Icon.png',
    'images/Group 10711@2x.png',
    'images/shopping basket@2x.png',
    'images/Group 11614@2x.png',
  ];
  final List<IconData> _icons = const [
    Icons.home,
    Icons.ondemand_video,
    MdiIcons.bellOutline,
    Icons.menu,
  ];
  final List<String> _lable = const [
    "Today",
    "กำลังทำ",
    "สินค้า",
    "เมนู",
  ];

  @override
  Widget build(BuildContext context) {
    return
        DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        appBar: null,
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens(),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: CustomTabBar(
            iconsimage: _iconsimage,
            icons: _icons,
            selectedIndex: _selectedIndex,
            onTap: (index) {
              Platform.isAndroid
                  ? HapticFeedback.vibrate()
                  : HapticFeedback.lightImpact();
              setState(() {
                _selectedIndex = index;
              });
              if (_selectedIndex == 0) {
                setState(() {
                  taptoload = true;
                });
              }
            },
            lable: _lable,
          ),
        ),
      ),
    );
  }

 
}
