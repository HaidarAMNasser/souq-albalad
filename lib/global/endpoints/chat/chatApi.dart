// ignore: file_names
import 'package:souq_al_balad/global/endpoints/core/api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';

class ChatApi {
  Future<ResponseState<MessageModel>> checkOrCreateNewChat(
      int secondUserId) async {
    print(
        '[ChatApi] 🔄 Starting checkOrCreateNewChat with secondUserId: $secondUserId');

    final response = await API().apiMethod(
      'chat/check-or-create',
      httpEnum: HttpEnum.post,
      data: {'second_user': secondUserId},
      parseJson: (json) {
        print('[ChatApi] ✅ Response received for checkOrCreateNewChat: $json');
        return MessageModel.fromJson(json);
      },
    );

    print(
        '[ChatApi] 🏁 Finished checkOrCreateNewChat with result: ${response}');
    return response;
  }

  Future<ResponseState<MessageModel>> sendMessage(
      int chatId, String message) async {
    print(
        '[ChatApi] 🔄 Starting sendMessage with chatId: $chatId and message: "$message"');

    final response = await API().apiMethod(
      'send-message',
      httpEnum: HttpEnum.post,
      data: {'chat_id': chatId, 'message': message},
      parseJson: (json) {
        print('[ChatApi] ✅ Response received for sendMessage: $json');
        return MessageModel.fromJson(json);
      },
    );

    print('[ChatApi] 🏁 Finished sendMessage with result: ${response}');
    return response;
  }

  Future<ResponseState<MessageModel>> getMessagesForChat(int chatId) async {
    print('[ChatApi] 🔄 Starting getMessagesForChat with chatId: $chatId');

    final response = await API().apiMethod(
      'chats/$chatId/messages',
      httpEnum: HttpEnum.get,
      parseJson: (json) {
        print('[ChatApi] ✅ Response received for getMessagesForChat: $json');
        return MessageModel.fromJson(json);
      },
    );

    print('[ChatApi] 🏁 Finished getMessagesForChat with result: ${response}');
    return response;
  }

  Future<ResponseState<MessageModel>> getChats() async {
    print('[ChatApi] 🔄 Starting getChats');

    final response = await API().apiMethod(
      'chats',
      httpEnum: HttpEnum.get,
      parseJson: (json) {
        print('[ChatApi] ✅ Response received for getChats: $json');
        return MessageModel.fromJson(json);
      },
    );

    print('[ChatApi] 🏁 Finished getChats with result: ${response}');
    return response;
  }

  Future<ResponseState<MessageModel>> markMessageAsRead(
      int messageId, int readerId) async {
    print(
        '[ChatApi] 🔄 Starting markMessageAsRead with messageId: $messageId, readerId: $readerId');

    final response = await API().apiMethod(
      'broadcast-read',
      httpEnum: HttpEnum.post,
      data: {'message_id': messageId, 'reader_id': readerId},
      parseJson: (json) {
        print('[ChatApi] ✅ Response received for markMessageAsRead: $json');
        return MessageModel.fromJson(json);
      },
    );

    print('[ChatApi] 🏁 Finished markMessageAsRead with result: ${response}');
    return response;
  }
}
