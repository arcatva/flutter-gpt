import 'dart:developer';
import 'dart:io' show Platform;

import 'package:dart_openai/dart_openai.dart';
import 'package:get/get.dart';

import 'chat_get.dart';

class SettingGetLogic extends GetxController {
  final Map<String, String> envVars = Platform.environment;

  @override
  Future<void> onInit() async {
    Get.put(ChatGetLogic(), permanent: true);
    // initialize OpenAI service settings
    log("Initializing OpenAI service settings");
    OpenAI.apiKey = envVars['OPENAI_API_KEY']!;
    OpenAI.baseUrl = "https://api.openai.com/";
    // finish OpenAI service loading
    log("Finished loading OpenAI service");

    // TODO: implement onInit
    super.onInit();
  }
}
