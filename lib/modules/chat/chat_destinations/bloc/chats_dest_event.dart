// lib/modules/chat/chat_destinations/bloc/chats_dest_event.dart

import 'package:flutter/material.dart';
import 'package:souq_al_balad/global/endpoints/user/models/user_model.dart'; // <-- ADD THIS IMPORT

abstract class ChatDestEvents {
  const ChatDestEvents();
}

class GetChatsEvent extends ChatDestEvents {
  BuildContext context;
  GetChatsEvent(this.context);
}

// === THIS IS THE CHANGE ===
// We need to pass the full user object to have its details after creating the chat.
class StartChatWithUserEvent extends ChatDestEvents {
  final UserModel otherUser;
  StartChatWithUserEvent({required this.otherUser});
}
