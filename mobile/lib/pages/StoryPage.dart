import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/comps/small_btn.dart';
import 'package:mobile/consts.dart';
import 'package:mobile/pages/QuizPage.dart';
import 'package:mobile/state/StoryPageControler.dart';
import 'package:mobile/state/TTS.dart';

class StoryPageContent extends StatefulWidget {
  StoryPageContent({super.key});

  @override
  State<StoryPageContent> createState() => _StoryPageContentState();
}

class _StoryPageContentState extends State<StoryPageContent> {
  StoryPageControler storypageControler = Get.find<StoryPageControler>();

  void to_quiz() {
    Get.to(QuizPage());
  }

  @override
  void initState() {
    for (var i = 0;i < min(storypageControler.imgs.length,storypageControler.story.value["en-story"].length);i++) {
      storypageControler.load_imgs(storypageControler.story.value["en-story"][i], i);
    }

    super.initState();
  }

  void on_play_sound() async {
    
    final ctr = Get.find<TTSControler>();
    final sections = Get.find<StoryPageControler>().story.value["en-story"];
      var collection = "";
      for (var i = 0; i < sections.length; i++) {
          collection += sections[i];
      }

    await ctr.ftts!.speak(collection);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Text(
              "Story:",
              style: TextStyle(
                fontSize: 25,
                decoration: TextDecoration.underline,
              ),
            ),
            SmallBtn(
              on_click: () {on_play_sound();},
              text: "Hear",
              width: 110,
              font_size: 18,
              text_length: 11,
            ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Column(children: [
              for (var i = 0;
                  i < storypageControler.story.value["en-story"].length;
                  i++)
                Column(
                  children: [
                    Obx(
                      () {
                        if (storypageControler.imgs_exist.value[i] == -1)
                          return CircularProgressIndicator();

                        if (storypageControler.imgs_exist.value[i] == 0 || i >= storypageControler.imgs_exist.value.length)
                          return SizedBox();


                        return ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.memory(
                            Base64Decoder().convert(
                              storypageControler.imgs.value[i],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      storypageControler.story.value["en-story"][i].toString(),
                      style: TextStyle(
                        fontSize: 20,
                        height: 2.2,
                      ),
                    ),
                  ],
                ),
            ]),
            SizedBox(height: 20),
            SmallBtn(
              on_click: () {
                to_quiz();
              },
              text: "Quiz!",
            )
          ],
        ),
      ),
    );
  }
}

class StoryPageLoading extends StatelessWidget {
  StoryPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Generating The Story....",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(
                  color: Colors.red,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: (MediaQuery.of(context).size.width - FOXY_WIDTH) * 0.5,
            child: SvgPicture.asset(
              "assets/foxy.svg",
            ),
          )
        ],
      ),
    );
  }
}

class StoryPage extends StatelessWidget {
  StoryPage({super.key});

  void on_quiz() {
    Get.to(QuizPage());
  }

  StoryPageControler storypageControler = Get.find<StoryPageControler>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Obx(() {
        if (!storypageControler.got_response.value) {
          return StoryPageLoading();
        }
        return StoryPageContent();
      })),
    );
  }
}
