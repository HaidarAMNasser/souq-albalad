import 'package:souq_al_balad/global/endpoints/user/models/user_model.dart';

class ChatMessageModel {
  int? id;
  int? chatId;
  int? senderId;
  String? message;
  int? isSeen;
  String? readAt;
  String? createdAt;
  String? updatedAt;
  UserModel? sender;

  ChatMessageModel({
    this.id,
    this.chatId,
    this.senderId,
    this.message,
    this.isSeen,
    this.readAt,
    this.createdAt,
    this.updatedAt,
    this.sender,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'],
      chatId: json['chat_id'],
      senderId: json['sender_id'],
      message: json['message'],
      isSeen: json['is_seen'],
      readAt: json['read_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      sender:
          json['sender'] != null ? UserModel.fromJson(json['sender']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['chat_id'] = chatId;
    data['sender_id'] = senderId;
    data['message'] = message;
    data['is_seen'] = isSeen;
    data['read_at'] = readAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    return data;
  }
}
