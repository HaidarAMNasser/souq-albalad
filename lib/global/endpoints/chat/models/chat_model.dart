// lib/global/endpoints/chat/models/chat_model.dart

import 'package:souq_al_balad/global/endpoints/chat/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/user/models/user_model.dart';

class ChatModel {
  int? chatId;
  UserModel? otherUser;
  ChatMessageModel? latestMessage;
  int? unseenCount;

  ChatModel({
    this.chatId,
    this.otherUser,
    this.latestMessage,
    this.unseenCount,
  });

  // === THIS IS THE CORRECTED AND ROBUST FACTORY ===
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    int? extractedChatId;
    Map<String, dynamic>? otherUserData;
    Map<String, dynamic>? latestMessageData;
    int? unseenCountData;

    // This handles the structure from your 'getChats' list API
    if (json.containsKey('chat_id')) {
      extractedChatId = json['chat_id'];
      otherUserData = json['other_user'];
      latestMessageData = json['latest_message'];
      unseenCountData = json['unseen_count'];
    }
    // This handles the structure from your 'checkOrCreateNewChat' API
    else if (json.containsKey('chat') && json['chat'] is Map) {
      final Map<String, dynamic> chatObject = json['chat'];
      extractedChatId = chatObject['id'];
      // other_user and latest_message are not in this response,
      // so their data will correctly remain null.
    }

    return ChatModel(
      chatId: extractedChatId,
      otherUser:
          otherUserData != null ? UserModel.fromJson(otherUserData) : null,
      latestMessage: latestMessageData != null
          ? ChatMessageModel.fromJson(latestMessageData)
          : null,
      // Use the extracted value, and provide a default of 0 if it's null
      unseenCount: unseenCountData ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chat_id'] = chatId;
    if (otherUser != null) {
      data['other_user'] = otherUser!.toJson();
    }
    if (latestMessage != null) {
      data['latest_message'] = latestMessage!.toJson();
    }
    data['unseen_count'] = unseenCount;
    return data;
  }
}
