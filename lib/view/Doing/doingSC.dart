import 'package:flutter/material.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';

class DoingSC extends StatefulWidget {
  // DoingSC({Key? key}) : super(key: key);

  @override
  _DoingSCState createState() => _DoingSCState();
}

class _DoingSCState extends State<DoingSC> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  var token;

  var userid;

  var userimageUrl;

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print('initState');
    super.initState();
    setState(() {
      Api.gettoke().then((value) => value({
            token = value,
            print('token$token'),
          }));

      Api.getmyuid().then((value) => ({
            setState(() {
              userid = value;
            }),
            print('userid$userid'),
          }));
      Api.getimageURL().then((value) => ({
            setState(() {
              userimageUrl = value;
            }),
            print('userimageUrl$userimageUrl'),
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            controller: _trackingScrollController,
            slivers: [
              primaryAppBar(context, token, userid, userimageUrl),
              SliverToBoxAdapter(
                child: Container(
                  color: primaryColor,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'สิ่งที่ "พรรคก้าวไกล" กำลังทำอยู่',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Anakotmai',
                          fontSize: 19),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'สิ่งที่กำลังทำใน 1 เดือนที่ผ่านมา',
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: MColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Anakotmai',
                          fontSize: 17),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 19, top: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: width / 2.3,
                                height: hight / 5.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[100],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        blurRadius: 0.5,
                                        spreadRadius: 0.5,
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 40.0,
                                        backgroundImage: NetworkImage(
                                            'https://via.placeholder.com/150'),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      Text(
                                        '#WaterBank',
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Anakotmai-Bold',
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Container(
                                width: width / 2.3,
                                height: hight / 5.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[100],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        blurRadius: 0.5,
                                        spreadRadius: 0.5,
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 40.0,
                                        backgroundImage: NetworkImage(
                                            'https://via.placeholder.com/150'),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      Text(
                                        '# WALKTODAY',
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Anakotmai-Bold',
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Row(
                            children: [
                              Container(
                                width: width / 2.3,
                                height: hight / 5.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[100],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        blurRadius: 0.5,
                                        spreadRadius: 0.5,
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 40.0,
                                        backgroundImage: NetworkImage(
                                            'https://via.placeholder.com/150'),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      Text(
                                        'มอบแรงใจสู้แรงงาน',
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Anakotmai-Bold',
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Container(
                                width: width / 2.3,
                                height: hight / 5.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[100],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        blurRadius: 0.5,
                                        spreadRadius: 0.5,
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 40.0,
                                        backgroundImage: NetworkImage(
                                            'https://via.placeholder.com/150'),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      Text(
                                        'ชุดยังชีพ',
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Anakotmai-Bold',
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: Divider(
                color: Colors.transparent,
                height: 10,
                thickness: 6,
              )),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      'สิ่งที่ทำที่เคยทำมา',
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: MColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Anakotmai',
                          fontSize: 17),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(16),
                        width: width,
                        height: hight / 7.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[50],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 0.5,
                                spreadRadius: 0.5,
                              ),
                            ]),
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 16.0, left: 14.0),
                              child: CircleAvatar(
                                radius: 36.0,
                                backgroundImage: NetworkImage(
                                    'https://via.placeholder.com/150'),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 18.0, left: 110),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '#พรบจัดสรร',
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Anakotmai-Bold',
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '#ร่างพระราชบัญญัการจัดสรรที่ดิน\n(ฉบับที่..) พ.ศ. ....',
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontFamily: 'Anakotmai',
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: Divider(
                color: Colors.transparent,
                height: 10,
                thickness: 6.0,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
