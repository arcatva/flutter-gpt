import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gpt/models/message.dart';
import 'package:flutter_gpt/views/components/chat_message.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/chat_get.dart';

class ChatGetPage extends StatelessWidget {
  const ChatGetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(direction: Axis.vertical, children: [
      ChatGetConversationWindow(),
      ChatGetTextField(),
    ]);
    ;
  }
}

class ChatGetConversationWindow extends StatelessWidget {
  final logic = Get.find<ChatGetLogic>();

  ChatGetConversationWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<ChatGetLogic>(
        builder: (logic) {
          if (logic.messages.isNotEmpty) {
            return ListView.builder(
              itemCount: logic.messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: logic.messages[index]);
              },
            );
          } else {
            return Text('Hello');
          }
        },
      ),
    );
  }
}

class ChatGetTextField extends StatelessWidget {
  final logic = Get.find<ChatGetLogic>();
  final _textEditingController = TextEditingController();

  ChatGetTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatGetLogic>(builder: (logic) {
      return Container(
        alignment: AlignmentDirectional.bottomCenter,
        padding:
            const EdgeInsets.only(left: 35, right: 35, bottom: 25, top: 25),
        child: Row(
          children: [
            Form(
              child: Expanded(
                child: TextFormField(
                  controller: _textEditingController,
                  maxLines: 3,
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                    hintText: "Message FlutterGPT...",
                    filled: true,
                    fillColor: CupertinoColors.extraLightBackgroundGray,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            SizedBox(
              height: 40,
              width: 40,
              child: ElevatedButton(
                onPressed: () {
                  logic.messages.add(Message(1,
                      conversationId: "conversationId",
                      role: Role.user,
                      text: _textEditingController.text.trim()));
                  _textEditingController.clear();
                  logic.update();
                  logic.getResponse();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  padding: EdgeInsets.zero,
                ),
                child: SvgPicture.asset("assets/icons/send.svg"),
              ),
            ),
          ],
        ),
      );
    });
  }
}
