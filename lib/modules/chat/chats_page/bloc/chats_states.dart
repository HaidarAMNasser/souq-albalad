// lib/modules/chat/chats_page/bloc/chats_states.dart

import 'package:souq_al_balad/global/endpoints/chat/models/chat_model.dart'; // <-- Add this import
import 'package:souq_al_balad/global/endpoints/chat/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';

class ChatState {
  StateEnum chatState;
  List<ChatMessageModel>? chatMessages;
  String errorMessage;
  ChatModel? newlyCreatedChat; // <-- ADD THIS PROPERTY

  ChatState({
    this.chatState = StateEnum.loading,
    this.errorMessage = '',
    this.chatMessages,
    this.newlyCreatedChat, // <-- ADD THIS TO THE CONSTRUCTOR
  });

  // === FIX THE COPYWITH METHOD ===
  ChatState copyWith({
    StateEnum? chatState,
    String? errorMessage,
    List<ChatMessageModel>? chatMessages,
    ChatModel? newlyCreatedChat, // <-- ADD THIS PARAMETER
    bool clearNewChat = false, // <-- ADD THIS PARAMETER
  }) {
    return ChatState(
      chatState: chatState ?? this.chatState,
      errorMessage: errorMessage ?? this.errorMessage,
      chatMessages: chatMessages ?? this.chatMessages,
      // If we want to clear it, set it to null, otherwise use the new or old value
      newlyCreatedChat:
          clearNewChat ? null : newlyCreatedChat ?? this.newlyCreatedChat,
    );
  }
}
