import 'package:souq_al_balad/global/endpoints/core/api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/global/endpoints/user/models/user_model.dart';
import 'package:dio/dio.dart';

class UserApi {
  Future<ResponseState<MessageModel>> getUserProfile() async {
    return API().apiMethod(
      'user/getProfile',
      httpEnum: HttpEnum.get,
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  Future<ResponseState<MessageModel>> editUserProfile(UserModel profile) async {
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
      'user/editProfile',
      httpEnum: HttpEnum.post,
      data: profile.toJson(),
      dataMedia: formData,
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }
}
