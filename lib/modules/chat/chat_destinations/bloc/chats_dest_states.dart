import 'package:souq_al_balad/global/endpoints/chat/models/chat_model.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';

class ChatDestState {
  StateEnum chatDestState;
  List<ChatModel>? chats;
  String errorMessage;

  ChatDestState({
    this.chatDestState = StateEnum.loading,
    this.errorMessage = '',
    this.chats,
  });

  ChatDestState copyWith({
    StateEnum? chatDestState,
    String? errorMessage,
    List<ChatModel>? chats,
  }) {
    return ChatDestState(
      chatDestState: chatDestState ?? this.chatDestState,
      errorMessage: errorMessage ?? this.errorMessage,
      chats: chats ?? this.chats,
    );
  }
}
