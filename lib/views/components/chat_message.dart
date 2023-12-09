import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gpt/models/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      foregroundDecoration:
          BoxDecoration(border: Border.all(color: Colors.white)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: message.role == Role.assistant
            ? [
                const Text(
                  "FlutterGPT",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                MessageRow(message: message),
              ]
            : [
                const Text(
                  "You",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                MessageRow(message: message),
              ],
      ),
    );
  }
}

class MessageRow extends StatelessWidget {
  final Message message;

  const MessageRow({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          // 使文本填充剩余空间
          child: SelectableText(
            message.text,
            style: const TextStyle(),
          ),
        ),
        IconButton(
          iconSize: 15,
          icon: const Icon(Icons.copy),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: message.text));
          },
        ),
      ],
    );
  }
}
