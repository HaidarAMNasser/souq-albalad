// lib/modules/chat/chat_destinations/bloc/chats_dest_bloc.dart

import 'package:souq_al_balad/global/data/local/cache_helper.dart';
import 'package:souq_al_balad/global/endpoints/chat/chatApi.dart';
import 'package:souq_al_balad/global/endpoints/chat/models/chat_model.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart'
    show StateEnum;
import 'package:souq_al_balad/global/endpoints/logout/logoutApi.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/modules/auth/log_in/view/screen/log_in_screen.dart';
import 'package:souq_al_balad/modules/chat/chat_destinations/bloc/chats_dest_event.dart';
import 'package:souq_al_balad/modules/chat/chat_destinations/bloc/chats_dest_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ChatDestBloc extends Bloc<ChatDestEvents, ChatDestState> {
  ChatDestBloc() : super(ChatDestState()) {
    on<GetChatsEvent>(_getChatsEvent);
    on<StartChatWithUserEvent>(_onStartChat);
  }

  void _getChatsEvent(ChatDestEvents event, Emitter<ChatDestState> emit) async {
    // ... This method is unchanged and correct ...
    emit(state.copyWith(chatDestState: StateEnum.loading));
    ResponseState<MessageModel> response = await ChatApi().getChats();
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        List<ChatModel> chats = [];
        for (var i = 0; i < res.data.result.length; i++) {
          ChatModel chat = ChatModel.fromJson(res.data.result[i]);
          chats.add(chat);
        }
        emit(state.copyWith(chatDestState: StateEnum.Success, chats: chats));
      } else {
        emit(state.copyWith(errorMessage: res.data.message));
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(chatDestState: StateEnum.start));
    }
  }

  // === THIS IS THE CORRECTED METHOD ===
  void _onStartChat(
      StartChatWithUserEvent event, Emitter<ChatDestState> emit) async {
    // 1. Check for a valid user ID before doing anything.
    if (event.otherUser.id == null) {
      Fluttertoast.showToast(msg: "Cannot start chat: User ID is missing.");
      return;
    }

    emit(state.copyWith(chatDestState: StateEnum.loading, clearNewChat: true));

    // 2. Call the API with the non-nullable ID.
    final response = await ChatApi().checkOrCreateNewChat(event.otherUser.id!);

    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;

      if (res.data.success) {
        // The API response `result` contains the nested 'chat' object.
        final Map<String, dynamic> chatData = res.data.result['chat'];

        // 3. Manually build a complete ChatModel for safe navigation.
        final ChatModel completeChat = ChatModel(
          chatId: chatData['id'], // Get the ID from the API response
          otherUser: event.otherUser, // Get the full user info from the event
          latestMessage: null, // New chat has no last message
          unseenCount: 0, // New chat has no unread messages
        );

        // 4. Emit the state with the complete chat object.
        emit(state.copyWith(
          chatDestState: StateEnum.Success,
          newlyCreatedChat: completeChat,
        ));
      } else {
        Fluttertoast.showToast(msg: res.data.message);
        emit(state.copyWith(
          chatDestState: StateEnum.failed,
          errorMessage: res.data.message,
        ));
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(
        chatDestState: StateEnum.failed,
        errorMessage: res.errorMessage.error!.message,
      ));
    }
  }
}
