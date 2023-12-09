import 'package:flutter_gpt/services/gpt.dart';
import 'package:get/get.dart';

import '../models/conversation.dart';
import '../models/message.dart';

class ChatGetLogic extends GetxController {
  final List<Conversation> conversations = <Conversation>[].obs;
  final List<Message> messages = <Message>[].obs;
  final ChatGPTService chatGPTService = ChatGPTService();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void getResponse() {
    chatGPTService.getResponse(messages, (Message newMessage) {
      update(); // 更新 UI
    });
  }
}
