import 'dart:async';

import 'package:souq_al_balad/global/endpoints/chat/chatApi.dart';
import 'package:souq_al_balad/global/endpoints/chat/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart'
    show StateEnum;
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/modules/chat/chats_page/bloc/chats_event.dart';
import 'package:souq_al_balad/modules/chat/chats_page/bloc/chats_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:fluttertoast/fluttertoast.dart';

class ChatBloc extends Bloc<ChatEvents, ChatState> {
  ChatBloc() : super(ChatState()) {
    on<GetChatMessagesEvent>(_getChatsEvent);
    on<AddMessageToListEvent>(_addMessageToList);
  }

  void _getChatsEvent(ChatEvents event, Emitter<ChatState> emit) async {
    emit(state.copyWith(chatState: StateEnum.loading));
    ResponseState<MessageModel> response = await ChatApi().getChats();
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        List<ChatMessageModel> chats = [];
        for (var i = 0; i < res.data.result.length; i++) {
          ChatMessageModel chat = ChatMessageModel.fromJson(res.data.result[i]);
          chats.add(chat);
        }
        emit(state.copyWith(chatState: StateEnum.Success, chatMessages: chats));
      } else {
        emit(state.copyWith(errorMessage: res.data.message));
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(chatState: StateEnum.start));
    }
  }

  FutureOr<void> _addMessageToList(
    AddMessageToListEvent event,
    Emitter<ChatState> emit,
  ) {
    state.chatMessages!.add(event.message);
    emit(state.copyWith(chatMessages: state.chatMessages));
  }
}
