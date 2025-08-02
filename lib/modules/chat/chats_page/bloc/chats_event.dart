import 'package:souq_al_balad/global/endpoints/chat/models/message_model.dart';
import 'package:flutter/src/widgets/framework.dart';

abstract class ChatEvents {
  const ChatEvents();
}

class GetChatMessagesEvent extends ChatEvents {
  BuildContext context;
  int chatId;
  GetChatMessagesEvent(this.chatId, this.context);
}

class AddMessageToListEvent extends ChatEvents {
  BuildContext context;
  ChatMessageModel message;
  AddMessageToListEvent(this.message, this.context);
}
