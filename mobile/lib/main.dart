import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mobile/pages/LandingPage.dart';
import 'package:mobile/state/StoryPageControler.dart';
import 'package:mobile/state/TTS.dart';



void main() {
  Get.lazyPut<StoryPageControler>(() => StoryPageControler());
  Get.put(TTSControler());
  runApp(const Storyfy());
}

class Storyfy extends StatelessWidget {
  const Storyfy({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Storyfy',
      theme: ThemeData(
        fontFamily: "MontserratAlternates",
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
