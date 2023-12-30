import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/consts.dart';
import 'package:mobile/pages/PromptPage.dart';
import 'package:mobile/state/StoryPageControler.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void on_done_clicked() {
      Get.to(PromptPage());
    }

    var storyPageControler = Get.find<StoryPageControler>();

    return Scaffold(
        backgroundColor: const Color(0xFFE8F3FF),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: -5,
              child: SvgPicture.asset(
                "assets/result.svg",
              ),
            ),
            Positioned(
              left:
                  (MediaQuery.of(context).size.width - COMPLETED_WIDTH * 0.85) /
                      2,
              top: (MediaQuery.of(context).size.height - COMPLETED_HEIGHT) / 2,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    "assets/completed.svg",
                    width: COMPLETED_WIDTH * 0.85,
                  ),
                  Positioned(
                    bottom: 0,
                    left: (COMPLETED_WIDTH - COMPLETED_WIDTH_RECT) * 0.5,
                    child: Container(
                      height: COMPLETED_HEIGHT * 0.45,
                      width: COMPLETED_WIDTH_RECT -
                          (COMPLETED_WIDTH - COMPLETED_WIDTH_RECT),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "In the story we learned",
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Obx(
                                  () => Center(
                                    child: Text(
                                      "${storyPageControler.story.value['en-value'][0].length > 50 ? storyPageControler.story.value['en-value'][0].substring(0, 50)+'...' : storyPageControler.story.value['en-value'][0]}",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Obx(() => Text("your score is ${storyPageControler.quiz_score()}/3")) 
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: (COMPLETED_WIDTH - OKEYBTY_WIDTH) * 0.85 / 2,
                    child: GestureDetector(
                      onTap: () {
                        on_done_clicked();
                      },
                      child: SvgPicture.asset(
                        "assets/okey_btn.svg",
                        width: OKEYBTY_WIDTH * 0.85,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
