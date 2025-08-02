// ignore: file_names
import 'package:souq_al_balad/global/endpoints/core/api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';

class ChatApi {
  Future<ResponseState<MessageModel>> checkOrCreateNewChat(
    int secondUserId,
  ) async {
    return API().apiMethod(
      'chat/check-or-create',
      httpEnum: HttpEnum.post,
      data: {'second_user': secondUserId},
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  Future<ResponseState<MessageModel>> sendMessage(
    int chatId,
    String message,
  ) async {
    return API().apiMethod(
      'chat/check-or-create',
      httpEnum: HttpEnum.post,
      data: {'chat_id': chatId, 'message': message},
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  Future<ResponseState<MessageModel>> getMessagesForChat(int chatId) async {
    return API().apiMethod(
      'chats/$chatId/messages',
      httpEnum: HttpEnum.get,
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  Future<ResponseState<MessageModel>> getChats() async {
    return API().apiMethod(
      'chats',
      httpEnum: HttpEnum.get,
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  Future<ResponseState<MessageModel>> markMessageAsRead(
    int messageId,
    int readerId,
  ) async {
    return API().apiMethod(
      'broadcast-read',
      httpEnum: HttpEnum.post,
      data: {'message_id': messageId, 'reader_id': readerId},
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }
}
