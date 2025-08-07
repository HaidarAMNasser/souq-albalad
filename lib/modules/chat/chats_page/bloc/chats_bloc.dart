// lib/modules/chat/chats_page/bloc/chats_bloc.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:souq_al_balad/global/endpoints/chat/chatApi.dart';
import 'package:souq_al_balad/global/endpoints/chat/models/chat_model.dart'; // <-- ADD THIS IMPORT

import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/modules/chat/chats_page/bloc/chats_event.dart';
import 'package:souq_al_balad/modules/chat/chats_page/bloc/chats_states.dart';

import '../../../../global/endpoints/chat/models/message_model.dart';

class ChatBloc extends Bloc<ChatEvents, ChatState> {
  ChatBloc() : super(ChatState()) {
    on<GetChatMessagesEvent>(_getChatsEvent);
    on<AddMessageToListEvent>(_addMessageToList);
    on<SendMessageEvent>(_sendMessageEvent);
    on<StartChatWithUserEvent>(_onStartChat); // <-- REGISTER THE NEW EVENT
  }

  // === ADD THIS ENTIRE NEW METHOD ===
  Future<void> _onStartChat(
      StartChatWithUserEvent event, Emitter<ChatState> emit) async {
    if (event.otherUser.id == null) {
      Fluttertoast.showToast(msg: "Cannot start chat: User ID is missing.");
      emit(state.copyWith(
          chatState: StateEnum.start, errorMessage: "User ID is missing."));
      return;
    }

    emit(state.copyWith(chatState: StateEnum.loading, clearNewChat: true));

    final response = await ChatApi().checkOrCreateNewChat(event.otherUser.id!);

    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        // The API response `result` contains the nested 'chat' object.
        final Map<String, dynamic> chatData = res.data.result['chat'];

        // Manually build a complete ChatModel for navigation.
        final ChatModel completeChat = ChatModel(
          chatId: chatData['id'], // Get ID from the API response
          otherUser: event.otherUser, // Get full user info from the event
          latestMessage: null,
          unseenCount: 0,
        );

        // Emit a success state with the chat object ready for navigation
        emit(state.copyWith(
          chatState: StateEnum.Success,
          newlyCreatedChat: completeChat,
        ));
      } else {
        Fluttertoast.showToast(msg: res.data.message);
        emit(state.copyWith(
            chatState: StateEnum.failed, errorMessage: res.data.message));
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(
          chatState: StateEnum.failed,
          errorMessage: res.errorMessage.error!.message));
    }
  }

  Future<void> _getChatsEvent(
      GetChatMessagesEvent event, Emitter<ChatState> emit) async {
    // ... This method is unchanged ...
    emit(state.copyWith(chatState: StateEnum.loading));
    ResponseState<MessageModel> response =
        await ChatApi().getMessagesForChat(event.chatId);
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        List<ChatMessageModel> chats = (res.data.result as List)
            .map((item) => ChatMessageModel.fromJson(item))
            .toList();
        emit(state.copyWith(chatState: StateEnum.Success, chatMessages: chats));
      } else {
        Fluttertoast.showToast(msg: res.data.message);
        emit(state.copyWith(
            chatState: StateEnum.start, errorMessage: res.data.message));
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(
          chatState: StateEnum.start,
          errorMessage: res.errorMessage.error!.message));
    }
  }

  Future<void> _sendMessageEvent(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    // ... This method is unchanged ...
    ResponseState<MessageModel> response = await ChatApi().sendMessage(
      event.chatId,
      event.message,
    );
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        print("Message sent to API successfully.");
      } else {
        Fluttertoast.showToast(msg: res.data.message);
        print("API Error on send: ${res.data.message}");
      }
    } else {
      Fluttertoast.showToast(msg: "Failed to send message. Check connection.");
    }
  }

  void _addMessageToList(AddMessageToListEvent event, Emitter<ChatState> emit) {
    // ... This method is unchanged ...
    final List<ChatMessageModel> currentMessages =
        List.from(state.chatMessages ?? []);
    currentMessages.add(event.message);
    emit(state.copyWith(
        chatMessages: currentMessages, chatState: StateEnum.Success));
  }
}
