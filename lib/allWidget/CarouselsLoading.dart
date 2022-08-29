
import 'package:flutter/material.dart';
import 'package:mfp_app/utils/app.style.config.dart';
import 'package:shimmer/shimmer.dart';

class CarouselLoading extends StatelessWidget {
  const CarouselLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appStyle =AppStyle(context);
    return Column(
      children: [
        Shimmer.fromColors(
          highlightColor: Colors.white,
          baseColor: Colors.grey[200],
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Container(
              width: double.infinity,
              height: appStyle.getHeight(percent:45),
              color: Colors.grey,
            ),
          ),
        ),
        Shimmer.fromColors(
          highlightColor: Colors.white,
          baseColor: Colors.grey[200],
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 2, 10, 0),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 15.0,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
