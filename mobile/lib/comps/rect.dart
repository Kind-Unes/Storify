import 'package:flutter/material.dart';


class Rect extends StatelessWidget {
  final Color color;
  double? width;
  double? height;

  Rect({super.key,required this.color,this.width,this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: color,
              ),
            );
  }
}
