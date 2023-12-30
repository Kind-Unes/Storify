import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/comps/small_btn.dart';
import 'package:mobile/comps/rect.dart';
import "package:mobile/consts.dart";
import 'package:mobile/pages/PromptPage.dart';

class LandingPage extends StatelessWidget {
  
  void on_start() {
    Get.to(PromptPage());
  } 

  LandingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEF3349),
      body:  Container(
        decoration: BoxDecoration(
          image:  DecorationImage(image: AssetImage("assets/home_page1.png")),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -200,
              child: SvgPicture.asset(
                "assets/snow_effect.svg",
              ),
            ), 
            Positioned(
              bottom: -200,
              right: 0,
              child: Transform.rotate(
                angle: -3.14,
                child: SvgPicture.asset(
                  "assets/snow_effect.svg",
                ),
              ),
            ), 
            Positioned(
              bottom: 0,
              left: 0,
              child: SvgPicture.asset(
                "assets/bomaa.svg",
              ),
            ),   
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              right: 0,
              child: SvgPicture.asset(
                "assets/pengin.svg",
              ),
            ), 

            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: (MediaQuery.of(context).size.width - SMALL_BTN_WIDTH) * 0.5,
              child: Column(
                children: [ 
                  Text("Storify",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,

                  ),),
                  SizedBox(height: 50,),
                  SmallBtn(
                    on_click: () => {on_start()},
                    text: "Start",
                ),
              ],
              ),
            ),
            Column(
              children: [
                Rect(
                  height: MediaQuery.of(context).padding.top * 0.5,
                  color: Color(0xFFF27728),
                ),
                Rect(
                  height: MediaQuery.of(context).padding.top * 0.5,
                  color: Color(0xFFFFCF25),
                ),
              ],
            ),
        ]),
      ),
    );
  }
}
