import 'package:souq_al_balad/global/endpoints/core/api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/global/endpoints/signup/models/sign_up_merchant_model.dart';
import 'package:dio/dio.dart';

class SellerApi {
  Future<ResponseState<MessageModel>> getSellerProfile() async {
    return API().apiMethod(
      'seller/getProfile',
      httpEnum: HttpEnum.get,
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  Future<ResponseState<MessageModel>> editSellerProfile(
    SignUpMerchantModel profile,
  ) async {
    FormData formData;

    if (profile.logo != null) {
      formData = FormData.fromMap(profile.toJson());
      formData.files.add(
        MapEntry(
          "logo",
          await MultipartFile.fromFile(
            profile.logo!.path,
            filename: "logo.${profile.logo!.path.split(".").last}",
          ),
        ),
      );
    } else {
      formData = FormData.fromMap(profile.toJson());
    }

    return API().apiMethod(
      'seller/editProfile',
      httpEnum: HttpEnum.post,
      data: profile.toJson(),
      dataMedia: formData,
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }
}
