// ignore: file_names
import 'package:souq_al_balad/global/endpoints/core/api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/forget_password/models/reset_password_model.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';

class ForgetPasswordApi {
  Future<ResponseState<MessageModel>> forget(String email) async {
    return API().apiMethod(
      'password/forgot',
      httpEnum: HttpEnum.post,
      data: {'email': email},
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  Future<ResponseState<MessageModel>> verifyOtp(
    String email,
    String otp,
  ) async {
    return API().apiMethod(
      'password/verify-otp',
      httpEnum: HttpEnum.post,
      data: {'email': email, 'otp': otp},
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  Future<ResponseState<MessageModel>> resetPassword(
    ResetPasswordModel resetPassModel,
  ) async {
    return API().apiMethod(
      'password/reset',
      httpEnum: HttpEnum.post,
      data: resetPassModel.toJson(),
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }
}
