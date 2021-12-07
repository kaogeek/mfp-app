import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/allWidget/circle_button.dart';
import 'package:mfp_app/allWidget/custom_tab_bar.dart';
import 'package:mfp_app/view/Doing/doingSC.dart';
import 'package:mfp_app/view/Menu/Menu.dart';
import 'package:mfp_app/view/Shop/Shop.dart';
import 'package:mfp_app/view/Today/TodaySc.dart';
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
    // TODO: implement initState
    super.initState();
    //  Api.gettoke().then((value) => value({
    //           checktoken = value,
    //           // print('checktoken$checktoken'),
    //         }));

    Api.getmyuid().then((value) => ({
          setState(() {
            userid = value;
          }),
          // print('myuidhome$userid'),
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
    'images/Element@2x.png',
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
    final Size screenSize = MediaQuery.of(context).size;
    
    return
        // Platform.isAndroid?isAnd():
        DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        appBar: null,
        // CustomAppBar(
        //           currentUser: currentUser,
        //           icons: _icons,
        //           selectedIndex: _selectedIndex,
        //            onTap: (index) => setState(() => _selectedIndex = index),
        //         ),

        body: IndexedStack(
          index: _selectedIndex,
          children: _screens(),
        ),
        bottomNavigationBar: Container(
          // padding: const EdgeInsets.only(bottom: 1.0),
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
                print('_selectedIndex$_selectedIndex');
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

  Widget isAnd() {
    int _selectedIndex = 0;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MColors.primaryWhite,
          title: Image.asset(
            'images/MFP-Logo-Horizontal.png',
            width: 150,
            height: 150,
          ),
          centerTitle: false,
          actions: [
            CircleButton(
              icon: Icons.search,
              iconSize: 30.0,
              onPressed: () => print('search'),
            ),
            CircleButton(
              icon: MdiIcons.bellOutline,
              iconSize: 30.0,
              onPressed: () => print('Messenger'),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                radius: 25.0,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150'),
                backgroundColor: Colors.transparent,
              ),
            )
          ],
          bottom: new PreferredSize(
            preferredSize: new Size(1.0, 45.0),
            child: new Container(
              child: new TabBar(
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: MColors.primaryColor,
                      width: 3.0,
                    ),
                  ),
                ),
                tabs: [
                  new Container(
                    height: 45.0,
                    child: new Tab(
                      icon: Icon(
                        Icons.home,
                        color: MColors.textGrey,
                      ),
                    ),
                  ),
                  new Container(
                    height: 45.0,
                    child: new Tab(
                      icon: Icon(
                        Icons.ondemand_video,
                        color: MColors.textGrey,
                      ),
                    ),
                  ),
                  new Container(
                    height: 45.0,
                    child: new Tab(
                      icon: Icon(
                        MdiIcons.bellOutline,
                        color: MColors.textGrey,
                      ),
                    ),
                  ),
                  new Container(
                    height: 45.0,
                    child: new Tab(
                      icon: Icon(
                        Icons.menu,
                        color: MColors.textGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // CustomAppBar(
        //           currentUser: currentUser,
        //           icons: _icons,
        //           selectedIndex: _selectedIndex,
        //            onTap: (index) => setState(() => _selectedIndex = index),
        //         ),

        body: TabBarView(
          children: [
            TodaySc(),
            DoingSC(),
            ShopSC(),
            MenuSC(),
          ],
        ),

        // bottomNavigationBar: Container(
        //   padding: const EdgeInsets.only(bottom: 13.0),
        //   color: Colors.white,
        //   child: CustomTabBar(
        //     icons: _icons,
        //     selectedIndex: _selectedIndex,
        //     onTap: (index) => setState(() => _selectedIndex = index), lable: 'data',
        //   ),
        // ),
      ),
    );
  }
}
