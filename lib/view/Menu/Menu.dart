import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/view/Menu/Detilmenu.dart';

class MenuSC extends StatefulWidget {
  // MenuSC({Key? key}) : super(key: key);

  @override
  _MenuSCState createState() => _MenuSCState();
}

class _MenuSCState extends State<MenuSC> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            controller: _trackingScrollController,
            slivers: [
              primaryAppBar(context),

            
              SliverToBoxAdapter(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      ' ข้อมูลเกี่ยวกับพรรค',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Anakotmai-Bold',
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (BuildContext context) {
                      return Detilmenu();
                    }));
                  },
                  child: Container(
                    margin: EdgeInsets.all(14),
                    width: 100,
                    height: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ]),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 10,
                          right: 40,
                          child: Image.asset("images/profile.jpeg"),
                          width: 60,
                          height: 150,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30, left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'บริจาค',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Anakotmai-Bold',
                                    fontSize: 24),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'ซื้อสินค้าพรรคก้าวไกล สนับสนุนการ\nทำงานเพื่อประชาธิปไตย',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Anakotmai',
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.all(14),
                  width: 100,
                  height: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: MColors.primaryBlue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 4,
                          spreadRadius: 2,
                        ),
                      ]),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 10,
                        right: 40,
                        child: Image.asset("images/profile.jpeg"),
                        width: 60,
                        height: 150,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30, left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'เกี่ยวกับพรรค',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Anakotmai-Bold',
                                  fontSize: 24),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'ซื้อสินค้าพรรคก้าวไกล สนับสนุนการ\nทำงานเพื่อประชาธิปไตย',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Anakotmai'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      ' ข้อมูลเกี่ยวกับพรรค',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Anakotmai-Bold',
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 170,
                                height: 130,
                                 decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.grey[200],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        blurRadius: 0.5,
                                        spreadRadius: 0.5,
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.chat_rounded,
                                        size: 66.0,
                                        color: primaryColor,
                                      ),
                                      Text(
                                        'ช่องทางการติดต่อ',
                                        style: TextStyle(
                                            color: MColors.primaryBlue,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Anakotmai-Bold',
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Container(
                                width: 170,
                                height: 130,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.grey[200],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        blurRadius: 0.5,
                                        spreadRadius: 0.5,
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.mark_email_unread_outlined,
                                        size: 66.0,
                                        color: primaryColor,
                                      ),
                                      Text(
                                        'ร้องเรียน',
                                        style: TextStyle(
                                            color: MColors.primaryBlue,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Anakotmai-Bold',
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 170,
                                height: 130,
                                 decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.grey[200],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        blurRadius: 0.5,
                                        spreadRadius: 0.5,
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.hail_rounded,
                                        size: 66.0,
                                        color: primaryColor,
                                      ),
                                      Text(
                                        'อาสาสมัคร',
                                        style: TextStyle(
                                            color: MColors.primaryBlue,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Anakotmai-Bold',
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Container(
                                width: 170,
                                height: 130,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.grey[200],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        blurRadius: 0.5,
                                        spreadRadius: 0.5,
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.supervised_user_circle_rounded,
                                        size: 66.0,
                                        color: primaryColor,
                                      ),
                                      Text(
                                        'บุคลากร',
                                        style: TextStyle(
                                            color: MColors.primaryBlue,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Anakotmai-Bold',
                                            fontSize: 16),
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
            ],
          ),
        ),
      ),
    );

   
  }
}
