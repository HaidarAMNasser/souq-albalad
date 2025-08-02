import 'package:souq_al_balad/global/endpoints/chat/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';

class ChatState {
  StateEnum chatState;
  List<ChatMessageModel>? chatMessages;
  String errorMessage;

  ChatState({
    this.chatState = StateEnum.loading,
    this.errorMessage = '',
    this.chatMessages,
  });

  ChatState copyWith({
    StateEnum? chatState,
    String? errorMessage,
    List<ChatMessageModel>? chatMessages,
  }) {
    return ChatState(
      chatState: chatState ?? this.chatState,
      errorMessage: errorMessage ?? this.errorMessage,
      chatMessages: chatMessages ?? this.chatMessages,
    );
  }
}
