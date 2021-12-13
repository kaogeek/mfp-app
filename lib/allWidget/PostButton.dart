import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;
  final double width;

  const PostButton({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.onTap,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    var widthCont = MediaQuery.of(context).size.width;

    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            // color: Colors.black,
            // padding: const EdgeInsets.symmetric(horizontal: 2.0),
            height: hight / 20.0,
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment :CrossAxisAlignment.center,
              children: [
                icon,
                // const SizedBox(width: 4.0),
                // Container(
                //   width: 90,
                //   child: Text(label, maxLines: 2, overflow: TextOverflow.ellipsis))

                Container(
                  width: widthCont / width ,
                  alignment: Alignment.centerLeft,
                  child: Text(label,
                      style: Theme.of(context).textTheme.subtitle1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
