// ignore: file_names
import 'package:souq_al_balad/global/endpoints/core/api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';

class NotificationApi {
  Future<ResponseState<MessageModel>> sendFcmToken(String fcmToken) async {
    return API().apiMethod(
      'user/fcm-token',
      httpEnum: HttpEnum.post,
      data: {'firebase_token': fcmToken},
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }
}
