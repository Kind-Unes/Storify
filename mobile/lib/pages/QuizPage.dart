import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/comps/option_list.dart';
import 'package:mobile/comps/small_btn.dart';
import 'package:mobile/pages/PromptPage.dart';
import 'package:mobile/pages/ResultPage.dart';
import 'package:mobile/state/StoryPageControler.dart';

class Quiz extends StatelessWidget {
  final String title;
  final List<String> options;
  Quiz({super.key, required this.title, required this.options});


  StoryPageControler storypageControler = Get.find<StoryPageControler>();

  void on_quiz_answer(idx,i) {
    storypageControler.quiz_answers[idx] = i; 
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Image(image: AssetImage("assets/hint.png")),
          ],
        ),
        OptionList(options: options,callback: (i) { 
            // find the index of the quiz
            var idx = 0;
            if(title.contains("2")) idx = 2 - 1;
            if(title.contains("3")) idx = 3 - 1;
            on_quiz_answer(idx,i);
          },),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  StoryPageControler storypageControler = Get.find<StoryPageControler>();

  Map<String, List<dynamic>> quizs = {};

  void on_cancel() {
    Get.to(PromptPage());
  }

  void on_continue() {
    Get.to(ResultPage());
  }

  @override
  void initState() {
    setState(() {
      quizs["Quiz 1"] = storypageControler.story.value["en-qz"][0];
      quizs["Quiz 2"] = storypageControler.story.value["en-qz"][1];
      quizs["Quiz 3"] = storypageControler.story.value["en-qz"][2];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      on_cancel();
                    },
                    child: SvgPicture.asset(
                      "assets/cancel.svg",
                      width: 30,
                    ),
                  ),
                  Expanded(
                    child: Center(
                        child: Text(
                      "Quizs",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    )),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var key in quizs.keys)
                        Quiz(
                          title: key,
                          options: (quizs[key] as List)
                              .map((item) => item as String)
                              .toList(),
                        ),
                      SmallBtn(
                        on_click: () { on_continue(); },
                        text: "continue",
                        text_length: 9,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
