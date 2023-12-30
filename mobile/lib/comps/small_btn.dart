import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/consts.dart';



class SmallBtn extends StatelessWidget {
  double? width;
  double? height;
  final String text;
  double font_size = 25;
  int text_length;
  
  
  Function on_click = () => {};


  SmallBtn({super.key,this.width,this.height,required this.on_click,required this.text,this.font_size = 25,this.text_length = -1});




  @override
  Widget build(BuildContext context) {
    return GestureDetector( 

        onTap: () => on_click(),
      child : Stack(
      children: [
           SvgPicture.asset(
            "assets/btn_small.svg",
            width: width,
          ),
        Positioned(
          // offseting using the text size
          // font size of 20 so math go brrr
          left: (SMALL_BTN_WIDTH - font_size / 2 *  (text_length == -1 ? text.length : text_length)) * 0.5,
          top: SMALL_BTN_HEIGHT * 0.5,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: font_size,
                fontWeight: FontWeight.bold,
              ),
          )
        ),
      ],
    ));
  }
}