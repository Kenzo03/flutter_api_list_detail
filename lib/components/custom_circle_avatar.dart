import 'package:flutter/material.dart';

class BorderedCircleAvatar extends StatelessWidget {
  final String imgPath;
  final double rad;
  final double borderWidth;
  final Color borderColor;

  const BorderedCircleAvatar(
      {Key? key,
      required this.imgPath,
      required this.rad,
      required this.borderWidth,
      required this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: rad + borderWidth,
      backgroundColor: borderColor,
      child: CircleAvatar(backgroundImage: AssetImage(imgPath), radius: rad),
    );
  }
}
