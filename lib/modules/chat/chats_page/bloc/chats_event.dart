// lib/modules/chat/chats_page/bloc/chats_event.dart

import 'package:flutter/material.dart';
import 'package:souq_al_balad/global/endpoints/chat/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/user/models/user_model.dart'; // <-- ADD THIS IMPORT

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

class SendMessageEvent extends ChatEvents {
  final int chatId;
  final String message;
  SendMessageEvent({required this.chatId, required this.message});
}

// === ADD THIS NEW EVENT ===
// This event will trigger finding/creating a chat and navigating to it.
class StartChatWithUserEvent extends ChatEvents {
  final UserModel otherUser;
  StartChatWithUserEvent({required this.otherUser});
}
