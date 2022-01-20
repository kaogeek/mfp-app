import 'package:flutter/material.dart';
import 'package:mfp_app/utils/app_theme.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Function onPressed;
  final Color color;

  const CircleButton({
    Key key,
    @required this.icon,
    @required this.iconSize,
    @required this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: IconButton(
        
        icon: Icon(
          icon,
          color: color,
        ),
        padding:EdgeInsets.zero,
        iconSize: iconSize,
        onPressed: onPressed,
       splashRadius: AppTheme.splashRadius,
      ),
    );
  }
}
