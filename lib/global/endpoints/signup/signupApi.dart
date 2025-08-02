// ignore: file_names
import 'package:souq_al_balad/global/endpoints/core/api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/global/endpoints/signup/models/sign_up_merchant_model.dart';
import 'package:souq_al_balad/global/endpoints/signup/models/sign_up_user_model.dart';
import 'package:dio/dio.dart';

class SignupApi {
  Future<ResponseState<MessageModel>> signupUser(SignUpUserModel signUp) async {
    return API().apiMethod(
      'customer/register',
      httpEnum: HttpEnum.post,
      data: signUp.toJson(),
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  Future<ResponseState<MessageModel>> signupMerchant(
    SignUpMerchantModel signUp,
  ) async {
    FormData formData = FormData.fromMap(signUp.toJson());
    formData.files.add(
      MapEntry(
        "logo",
        await MultipartFile.fromFile(
          signUp.logo!.path,
          filename: "logo ${signUp.logo!.path.toString().split(".").last}",
        ),
      ),
    );
    return API().apiMethod(
      'seller/register',
      httpEnum: HttpEnum.post,
      data: signUp.toJson(),
      dataMedia: formData,
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }
}
