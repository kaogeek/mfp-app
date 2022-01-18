import 'package:auto_size_text/auto_size_text.dart';
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
    this.width, this.containerwidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    var widthCont = MediaQuery.of(context).size.width;

    return Container(
     width: MediaQuery.of(context).size.width/containerwidth,

      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            // color: Colors.black,
            // padding: const EdgeInsets.symmetric(vertical: 10.0),
            height: hight / 25.0,
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment :CrossAxisAlignment.center,
              children: [
                
                Spacer(),
                icon,
                // const SizedBox(width: 4.0),
                // Container(
                //   width: 90,
                //   child: Text(label, maxLines: 2, overflow: TextOverflow.ellipsis))
                const SizedBox(width: 5,),
                Container(
                  width: MediaQuery.of(context).size.width*width,
                  child: Text(label,
                      style: TextStyle(   fontFamily: AppTheme.FontAnakotmaiLight,

                    fontSize: 14,
                    color: MColors.primaryBlue,
                    
                    overflow: TextOverflow.ellipsis,),
                      maxLines: 1,
                      // minFontSize: 14,
                      // maxFontSize: 17,
                      overflow: TextOverflow.ellipsis),
                ),
                Spacer(),
                // Container(
                //   width: widthCont / width ,
                //   alignment: Alignment.centerLeft,
                //   child: Text(label,
                //       style: Theme.of(context).textTheme.subtitle1,
                //       maxLines: 1,
                //       overflow: TextOverflow.clip),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
