// In lib/modules/chat/chat_destinations/bloc/chats_dest_states.dart

import 'package:souq_al_balad/global/endpoints/chat/models/chat_model.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';

class ChatDestState {
  final StateEnum chatDestState;
  final List<ChatModel>? chats;
  final String errorMessage;
  final ChatModel? newlyCreatedChat;
  ChatDestState({
    this.chatDestState = StateEnum.start,
    this.chats,
    this.errorMessage = '',
    this.newlyCreatedChat,
  });

  ChatDestState copyWith({
    StateEnum? chatDestState,
    List<ChatModel>? chats,
    String? errorMessage,
    ChatModel? newlyCreatedChat,
    bool clearNewChat = false,
  }) {
    return ChatDestState(
      chatDestState: chatDestState ?? this.chatDestState,
      chats: chats ?? this.chats,
      errorMessage: errorMessage ?? this.errorMessage,
      newlyCreatedChat:
          clearNewChat ? null : newlyCreatedChat ?? this.newlyCreatedChat,
    );
  }
}
