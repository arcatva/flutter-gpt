import 'dart:developer';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../controllers/chat_get.dart';
import '../models/message.dart';
import 'llm.dart';

class ChatGPTService extends LLM {
  static final ChatGPTService _instance = ChatGPTService._internal();
  final model = "gpt-4-1106-preview";

  factory ChatGPTService() {
    return _instance;
  }

  ChatGPTService._internal() {
    log("Initializing ChatGPT service $model");
  } // create singleton instance for

  void getResponse(List<Message> messages, ValueChanged<Message> onResponse) {
    for (Message msg in messages) {
      print(msg.text);
    }

    final List<OpenAIChatCompletionChoiceMessageModel> openAIMessages = [];

    messages = messages.reversed
        .toList(); // reverse order to show latest message first
    String content = "";

    for (Message message in messages) {
      content = content + message.text;
      // 插入到 openAIMessages 第一个位置
      openAIMessages.insert(
        0,
        // push the latest message in to list head, then this message will be pushed behind if new on come in
        OpenAIChatCompletionChoiceMessageModel(
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(message.text)
          ],
          role: message.role.asOpenAIChatMessageRole,
        ),
      );
    }

    final chatStream = OpenAI.instance.chat.createStream(
      model: "gpt-4-1106-preview",
      messages: openAIMessages,
    );
    var response = Message(1,
        conversationId: "conversationId", text: "●", role: Role.assistant);
    var chatGetLogic = Get.find<ChatGetLogic>();
    chatGetLogic.messages.add(response);
    chatStream.listen(
      (streamChatCompletion) {
        response.text =
            "${response.text.substring(0, response.text.length - 1)}${streamChatCompletion.choices.first.delta.content?.first.text ?? ''}●";
        onResponse(response);
        chatGetLogic.update();
      },
      onDone: () {
        response.text = response.text.substring(0, response.text.length - 1);
        chatGetLogic.update();
      },
    );
  }
}
