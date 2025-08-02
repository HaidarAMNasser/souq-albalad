import 'package:souq_al_balad/global/endpoints/core/api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';

class LogoutApi {
  Future<ResponseState<MessageModel>> logout() async {
    return API().apiMethod(
      'logout',
      httpEnum: HttpEnum.post,
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }
}
