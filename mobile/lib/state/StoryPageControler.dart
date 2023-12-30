import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/consts.dart';
import 'package:mobile/pages/PromptPage.dart';

class StoryPageControler extends GetxController{
  // story structure 
  // [en-story,en-quiz,en-value,ar-story,ar-quiz,ar-value]
  final story = {}.obs; 
  final got_response = false.obs;
  final caption = "".obs;


  // at most 10 section in every story 
  final imgs = ["","","","","","","","","",""].obs;
  final imgs_exist = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1].obs;


  final quiz_answers = [1,1,1].obs;

  int quiz_score() {
    var final_score = 0;
    for (var i = 0 ; i <  quiz_answers.value.length; i++) {
        if (quiz_answers.value[i] == 2) final_score += 1;
    }
    return final_score;
  }

  @override
  void onInit(){
    super.onInit();
  }

  @override
  void onReady(){
    super.onReady();
  }

  @override
  void onClose(){
    super.onClose();
  }


  void load_imgs(prompt,index) {
    imgs_exist.value[index] = -1;

    final dio = Dio();
    dio.post(BACKEND_URL +"/generate_image",data: {
      "prompt": prompt,
      "caption": caption.value,
    }).then((value) {
      var decoded = json.decode(value.toString());
      if(index < imgs.value.length) {
        imgs.value[index] = decoded["image"];
        imgs_exist.value[index] = 1;
        imgs_exist.refresh();
        imgs.refresh();
      } else {
        imgs_exist.value[index] = 0;
        imgs_exist.refresh();
      }

    }).catchError((error) {
        debugPrint(error.toString());
        imgs_exist.value[index] = 0;
        imgs_exist.refresh();
    });
  } 

  void generate_story(String prompt) {
    got_response.value = false;

    final dio = Dio();
    dio.post(BACKEND_URL + "/generate",data: {
      "prompt": prompt,
    }).then((value) {
      got_response.value = true;
      var decoded = json.decode(value.toString());

      debugPrint(decoded["result"].keys.toString());
      story.value = decoded["result"];

    }).catchError((error) {
        debugPrint(error.toString());
        Get.back();
        Get.snackbar("Error", "there seems to be a problem in our server",duration: const Duration(seconds: 3));
    });

  }


  void generate_story_from_img(img_base64) async {
    Get.find<StoryPageControler>().got_response.value = false;

    final dio = Dio();
    dio.post(BACKEND_URL + "/generate_story_from_image",data: {
      "img-data": img_base64,
    }).then((value) {

      got_response.value = true;
      var decoded = json.decode(value.toString());
      story.value = decoded["result"];

    }).catchError((error) {
        // debugPrint(error.toString());
        Get.back();
        Get.snackbar("Error", "there seems to be a problem in our server",duration: const Duration(seconds: 3));
    });    
  }

}