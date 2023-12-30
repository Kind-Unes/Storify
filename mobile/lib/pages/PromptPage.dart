import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/comps/option_list.dart';
import 'package:mobile/comps/small_btn.dart';
import 'package:mobile/pages/QuizPage.dart';
import 'package:mobile/pages/StoryPage.dart';
import 'package:mobile/state/StoryPageControler.dart';
import 'package:mobile/state/TTS.dart';

class PromptPage extends StatefulWidget {
  const PromptPage({super.key});

  @override
  State<PromptPage> createState() => _PromptPageState();
}

class _PromptPageState extends State<PromptPage> {
  List<List<String>> options = [
    ["Langauge:", "English", "Arabic"],
    ["Age:", "2-6 years", "7-13 years", "14-18 years"],
    ["Quiz Difficulty:", "Easy", "Medium", "Hard"],
    ["Size:", "Long (150 words)", "Normal (100 words)", "Short (50 words)"],
  ];

  void on_generate() async {
    if (input_ctrler.text.toString() == "") {
      Get.snackbar("Error", "please insert a prompt",
          duration: const Duration(seconds: 1));
      return;
    }
    Get.find<StoryPageControler>().caption.value = input_ctrler.text.toString();
    Get.find<StoryPageControler>().generate_story(input_ctrler.text.toString());
    Get.to(() => StoryPage());
  }

  final TextEditingController input_ctrler = TextEditingController();

  @override
  void dispose() {
    input_ctrler.dispose();
    super.dispose();
  }

  final ImagePicker _picker = ImagePicker();


   void on_select_img() async {
    final media = await _picker.pickImage(source: ImageSource.gallery);
    final bytes =  await media?.readAsBytes();
    if(bytes != null) {
      final base64_image = base64Encode(bytes);
      Get.find<StoryPageControler>().generate_story_from_img(base64_image);
      Get.to(() => StoryPage());
    } else {
        Get.snackbar("Error", "failed to load image from gallery",duration: const Duration(seconds: 3));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              "assets/dear.svg",
              width: 120,
            )),
        Positioned(
            bottom: 0,
            left: 0,
            child: SvgPicture.asset(
              "assets/1.svg",
            )),
        Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 0,
                        offset: Offset(0, 5),
                      )
                    ]),
                child: TextField(
                  controller: input_ctrler,
                  decoration: InputDecoration(
                    hintText: "type a small story...",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("or insert a "),
                  SmallBtn(
                    on_click: () {
                      on_select_img();
                    },
                    width: 120,
                    text: "Img",
                    font_size: 16,
                    text_length: 11,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Options:",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      for (var option in options) OptionList(options: option),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SmallBtn(
                  on_click: () {
                    on_generate();
                  },
                  text: "Generate",
                  text_length: 10,
                  font_size: 22),
            ],
          ),
        ),
      ]),
    ));
  }
}
