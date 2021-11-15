import 'package:flutter/material.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class CarouselLoading extends StatelessWidget {
  const CarouselLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor:Colors.grey[300],
      child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Container(
                width: double.infinity,
                height: 400,
                color: Colors.grey,
              ),
            ),
          ],
        ),
    );
  }
}