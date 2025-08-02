// ignore: file_names
import 'package:souq_al_balad/global/endpoints/core/api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';

class LoginApi {
  Future<ResponseState<MessageModel>> login(
    String email,
    String password,
  ) async {
    return API().apiMethod(
      'login',
      httpEnum: HttpEnum.post,
      data: {'email': email, 'password': password},
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  Future<ResponseState<MessageModel>> logInAsGuest() async {
    return API().apiMethod(
      'guest/register',
      httpEnum: HttpEnum.post,
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }
}
