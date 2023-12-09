import 'package:dart_openai/dart_openai.dart';

class Message {
  int id;
  String conversationId;
  Role role;
  String text;

  Message(this.id,
      {required this.conversationId, required this.role, required this.text});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': conversationId,
      'role': role.index,
      'text': text,
    };
  }

  @override
  String toString() {
    return 'Message{id: $id, conversationId: $conversationId, role: $role, text: $text}';
  }
}

enum Role { user, assistant, system }

extension Convert on Role {
  OpenAIChatMessageRole get asOpenAIChatMessageRole {
    switch (this) {
      case Role.assistant:
        return OpenAIChatMessageRole.assistant;
      case Role.system:
        return OpenAIChatMessageRole.system;
      case Role.user:
        return OpenAIChatMessageRole.user;
    }
  }
}
