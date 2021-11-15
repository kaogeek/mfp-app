import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
class PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;

  const PostButton({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            // padding: const EdgeInsets.symmetric(horizontal: 10.0),
            height: 50.0,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                // Container(
                //   width: 90,
                //   child: Text(label, maxLines: 2, overflow: TextOverflow.ellipsis))

                Container(
                                    width: 90,

                  child: Text(
              label,
              style: Theme.of(context).textTheme.subtitle1,
              maxLines: 2,
              overflow: TextOverflow.ellipsis
            ),
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}


