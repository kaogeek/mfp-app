// import 'package:flutter/material.dart';
// import 'package:mfp_app/allWidget/allWidget.dart';
// import 'package:mfp_app/constants/colors.dart';

// class ProfileUITEST extends StatefulWidget {
//   // ShopSC({Key? key}) : super(key: key);

//   @override
//   _ProfileUITESTState createState() => _ProfileUITESTState();
// }

// class _ProfileUITESTState extends State<ProfileUITEST> {
//   final TrackingScrollController _trackingScrollController =
//       TrackingScrollController();

//   @override
//   void dispose() {
//     _trackingScrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: SafeArea(
//         child: Scaffold(
//           body: CustomScrollView(
//             controller: _trackingScrollController,
//             slivers: [
//               primaryAppBar(context, ""),
//               SliverToBoxAdapter(
//                   child: Divider(
//                 color: Colors.transparent,
//                 height: 3,
//                 thickness: 6.0,
//               )),
//               SliverToBoxAdapter(
//                 child: Container(
//                   height: 130.0,
//                   color: Colors.white,
//                   child: Row(
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(top: 2.0, left: 25.0),
//                             child: CircleAvatar(
//                               radius: 42.0,
//                               backgroundImage: NetworkImage(
//                                   'https://via.placeholder.com/150'),
//                               backgroundColor: Colors.transparent,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 15.0,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                               top: 38.0,
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(
//                                   'Nuttawut Phonwa',
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 18.0,
//                                       fontFamily: 'Anakotmai-Bold',
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   'nuttawut.p@absolute.co.th',
//                                   style: TextStyle(
//                                     color: Colors.black54,
//                                     fontSize: 15.5,
//                                     fontFamily: 'Anakotmai',
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: 36.0),
//                             child: Icon(
//                               Icons.arrow_forward_ios_sharp,
//                               size: 28.0,
//                               color: primaryColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                   child: Divider(
//                 color: Colors.transparent,
//                 height: 3,
//                 thickness: 6.0,
//               )),
//               SliverToBoxAdapter(
//                   child: Container(
//                 color: Colors.white,
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 18.0, left: 25.0),
//                   child: Text(
//                     'เพจที่ดูแล',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 18.0,
//                       fontFamily: 'Anakotmai-Bold',
//                     ),
//                   ),
//                 ),
//               )),
//               SliverToBoxAdapter(
//                 child: Center(
//                   child: Container(
//                     height: 150,
//                     color: Colors.white,
//                     child: Padding(
//                       padding: EdgeInsets.only(top: 18.0, left: 30.0),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 child: Column(
//                                   children: [
//                                     CircleAvatar(
//                                       radius: 36.0,
//                                       backgroundImage: NetworkImage(
//                                           'https://via.placeholder.com/150'),
//                                       backgroundColor: Colors.transparent,
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 10),
//                                       child: Text(
//                                         'Nuttawut',
//                                         style: TextStyle(
//                                           color: Colors.black54,
//                                           fontSize: 18.0,
//                                           fontFamily: 'Anakotmai',
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 34.0,
//                               ),
//                               Container(
//                                 child: Column(
//                                   children: [
//                                     CircleAvatar(
//                                       radius: 36.0,
//                                       backgroundImage: NetworkImage(
//                                           'https://via.placeholder.com/150'),
//                                       backgroundColor: Colors.transparent,
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 8.0),
//                                       child: Text(
//                                         'สร้างเพจ',
//                                         style: TextStyle(
//                                           color: Colors.black54,
//                                           fontSize: 18.0,
//                                           fontFamily: 'Anakotmai',
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                   child: Divider(
//                 color: Colors.transparent,
//                 height: 3,
//                 thickness: 6.0,
//               )),
//               SliverToBoxAdapter(
//                 child: Container(
//                   height: 60.0,
//                   color: Colors.white,
//                   child: Row(
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(top: 2.0, left: 25.0),
//                             child: Text(
//                               'สมาชิกพรรค',
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 17.0,
//                                   fontFamily: 'Anakotmai-Bold',
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10.0,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                               top: 18.0,
//                               left: 65.0,
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(
//                                   'ยังไม่ได้เป็นสมาชิก',
//                                   style: TextStyle(
//                                       color: primaryColor,
//                                       fontSize: 17.0,
//                                       fontFamily: 'Anakotmai-Bold',
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(top: 4, left: 16.0),
//                             child: Icon(
//                               Icons.arrow_forward_ios_sharp,
//                               size: 18.0,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                   child: Divider(
//                 color: Colors.transparent,
//                 height: 3,
//                 thickness: 6.0,
//               )),
//               SliverToBoxAdapter(
//                 child: Container(
//                   height: 60.0,
//                   color: Colors.white,
//                   child: Row(
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(top: 2.0, left: 25.0),
//                             child: Text(
//                               'ประวัติการบริจาค',
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 17.0,
//                                   fontFamily: 'Anakotmai-Bold',
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 182.0,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(top: 4, left: 16.0),
//                             child: Icon(
//                               Icons.arrow_forward_ios_sharp,
//                               size: 18.0,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                   child: Divider(
//                 color: Colors.transparent,
//                 height: 3,
//                 thickness: 6.0,
//               )),
//               SliverToBoxAdapter(
//                 child: Container(
//                   height: 60.0,
//                   color: Colors.white,
//                   child: Row(
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(top: 2.0, left: 25.0),
//                             child: Text(
//                               'ติดตาม',
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 17.0,
//                                   fontFamily: 'Anakotmai-Bold',
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 252.0,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(top: 4, left: 16.0),
//                             child: Icon(
//                               Icons.arrow_forward_ios_sharp,
//                               size: 18.0,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                   child: Divider(
//                 color: Colors.transparent,
//                 height: 3,
//                 thickness: 6.0,
//               )),
//               SliverToBoxAdapter(
//                 child: Container(
//                   height: 60.0,
//                   color: Colors.white,
//                   child: Row(
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(top: 2.0, left: 25.0),
//                             child: Text(
//                               'ประวัติ',
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 17.0,
//                                   fontFamily: 'Anakotmai-Bold',
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 255.0,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(top: 4, left: 16.0),
//                             child: Icon(
//                               Icons.arrow_forward_ios_sharp,
//                               size: 18.0,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                   child: Divider(
//                 color: Colors.transparent,
//                 height: 3,
//                 thickness: 6.0,
//               )),
//               SliverToBoxAdapter(
//                 child: Container(
//                   height: 60.0,
//                   color: Colors.white,
//                   child: Row(
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(top: 2.0, left: 25.0),
//                             child: Text(
//                               'เชื่อมต่อ social media',
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 17.0,
//                                   fontFamily: 'Anakotmai-Bold',
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 126.0,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(top: 4, left: 16.0),
//                             child: Icon(
//                               Icons.arrow_forward_ios_sharp,
//                               size: 18.0,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                   child: Divider(
//                 color: Colors.transparent,
//                 height: 3,
//                 thickness: 6.0,
//               )),
//               SliverToBoxAdapter(
//                   child: Container(
//                 color: Colors.white,
//                 height: 26.0,
//               )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
