
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mfp_app/allWidget/PostButton.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/model/postModel.dart';
import 'package:mfp_app/allWidget/circle_button.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/utils/style.dart';

//APPBARS-------------------------------------

// Widget primaryAppBar(
//   Widget leading,
//   Widget title,
//   Color backgroundColor,
//   PreferredSizeWidget bottom,
//   bool centerTile,
//   List<Widget> actions,
// ) {
//   return AppBar(
//     brightness: Brightness.light,
//     elevation: 0.0,
//     backgroundColor: backgroundColor,
//     leading: leading,
//     title: title,
//     bottom: bottom,
//     centerTitle: centerTile,
//     actions: actions,
//   );
// }

Widget primaryAppBar(context) {
  return SliverAppBar(
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    title: Image.asset(
      'images/MFP-Logo-Horizontal.png',
      width: 150,
      height: 150,
    ),
    // Text(
    //   'facebook',
    //   style: const TextStyle(
    //     color: Colors.blue,
    //     fontSize: 28.0,
    //     fontWeight: FontWeight.bold,
    //     letterSpacing: -1.2,
    //   ),
    // ),
        automaticallyImplyLeading: false,

    centerTitle: false,
    floating: true,
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
          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          backgroundColor: Colors.transparent,
        ),
      )
    ],
  );
}
Widget AppBardetail(context,String authorposttext,String lable) {
  return SliverAppBar(
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    title:Text(
         '$lable $authorposttext',style:TextStyle(fontSize: 16,color: MColors.textDark,fontFamily: '')),
    // Text(
    //   'facebook',
    //   style: const TextStyle(
    //     color: Colors.blue,
    //     fontSize: 28.0,
    //     fontWeight: FontWeight.bold,
    //     letterSpacing: -1.2,
    //   ),
    // ),
    centerTitle: false,
    floating: true,
    leading:  IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: MColors.textGrey,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
    
  );
}

Widget UIlikecommentshear(context,int like,int comment,int share) {
  return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
               decoration: BoxDecoration(
                color: MColors.primaryBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_outline,
                size: 10.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              child: Text(
                '$like ถูกใจ',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            Text(
              '$comment ความคิดเห็น',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '$share  แชร์',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            )
          ],
        ),
        const Divider(),
        Row(
          children: [
            PostButton(
              icon: Icon(
                Icons.favorite_outline,
                color: MColors.primaryBlue,
                size: 20.0,
              ),
              label: 'ถูกใจ',
              onTap: () => print('Like'),
            ),
            PostButton(
              icon: Icon(
                MdiIcons.commentOutline,
                color: MColors.primaryBlue,
                size: 20.0,
              ),
              label: 'ความคิดเห็น',
              onTap: () => print('Comment'),
            ),
            PostButton(
              icon: Icon(
                Icons.share,
                color: MColors.primaryBlue,
                size: 25.0,
              ),
              label: 'แชร์',
              onTap: () => print('Share'),
            )
          ],
        ),
        SizedBox(
              height: 5,
            ),
      ],
    );
  // Row(
  //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   children: <Widget>[
  //     IconButton(
  //       padding: EdgeInsets.all(2.0),
  //         icon: Icon(
  //           Icons.favorite_outline,
  //           color: MColors.primaryBlue,
  //         ),
  //         onPressed: () {}),
  //     Text(
  //       '${like.toString()} ถูกใจ',
  //       style: Theme.of(context).textTheme.subtitle1,
  //     ),
  //     Spacer(),
  //     IconButton(icon: Icon(Icons.comment_outlined), onPressed: () {}),
  //     Text(
  //       '${comment.toString()} ความคิดเห็น',
  //       style: Theme.of(context).textTheme.subtitle1,
  //     ),
  //     Spacer(),
  //     IconButton(icon: Icon(Icons.share), onPressed: () {}),
  //     Text(
  //       '${share.toString()} แชร์',
  //       style: Theme.of(context).textTheme.subtitle1,
  //     ),
  //   ],
  // );
}



