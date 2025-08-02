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

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chatId: json['chat_id'],
      otherUser:
          json['other_user'] != null
              ? UserModel.fromJson(json['other_user'])
              : null,
      latestMessage:
          json['latest_message'] != null
              ? ChatMessageModel.fromJson(json['latest_message'])
              : null,
      unseenCount: json['unseen_count'],
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
