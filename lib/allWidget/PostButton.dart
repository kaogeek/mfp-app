import 'package:flutter/material.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';

class PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;
  final double width;
  final double containerwidth;

  const PostButton({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.onTap,
    this.width,
    this.containerwidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;

    return Container(
      width: MediaQuery.of(context).size.width / containerwidth,
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: hight / 25.0,
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                icon,
                const SizedBox(
                  width: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * width,
                  child: Text(label,
                      style: TextStyle(
                        fontFamily: AppTheme.FontAnakotmaiLight,
                        fontSize: 14,
                        color: MColors.primaryBlue,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
