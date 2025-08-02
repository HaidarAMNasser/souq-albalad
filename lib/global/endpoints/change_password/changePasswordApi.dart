import 'package:souq_al_balad/global/endpoints/core/api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';

class ChangePasswordApi {
  Future<ResponseState<MessageModel>> changePassword(
    String oldPassword,
    String password,
    String confirmPassword,
  ) async {
    return API().apiMethod(
      'update-password',
      httpEnum: HttpEnum.post,
      data: {
        'old_password': oldPassword,
        'password': password,
        'password_confirmation': confirmPassword,
      },
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }
}
