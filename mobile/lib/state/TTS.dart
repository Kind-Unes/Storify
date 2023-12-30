import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:mobile/consts.dart';
import 'package:mobile/pages/PromptPage.dart';

class TTSControler extends GetxController{
  FlutterTts? ftts; 

  @override
  void onInit() {
  

    
    super.onInit();
  }

  @override
  void onReady() async{

    ftts = FlutterTts();
    await ftts!.setLanguage("en-US");
    await ftts!.setVolume(1.0);
    await ftts!.setSpeechRate(0.5);
    await ftts!.setPitch(1.0); 


    super.onReady();

  }
  @override
  void onClose(){
    super.onClose();
  }




}