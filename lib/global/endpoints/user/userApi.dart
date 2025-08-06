import 'package:souq_al_balad/global/endpoints/core/api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/global/endpoints/signup/models/sign_up_merchant_model.dart';
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
          "profile_image",
          await MultipartFile.fromFile(
            profile.logo!.path,
            filename: "profile_image.${profile.logo!.path.split(".").last}",
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

  Future<ResponseState<MessageModel>> updateUserToSeller(SignUpMerchantModel profile) async {

    FormData formData = FormData.fromMap(profile.toJson());

    List<MapEntry<String, MultipartFile>> fileEntries = [];

    if (profile.logo != null) {
      fileEntries.add(
        MapEntry(
          "logo",
          await MultipartFile.fromFile(
            profile.logo!.path,
            filename: "logo.${profile.logo!.path.split('.').last}",
          ),
        ),
      );
    }

    if (profile.coverImage != null) {
      fileEntries.add(
        MapEntry(
          "cover_image",
          await MultipartFile.fromFile(
            profile.coverImage!.path,
            filename: "cover_image.${profile.coverImage!.path.split('.').last}",
          ),
        ),
      );
    }

    if (fileEntries.isNotEmpty) {
      formData.files.addAll(fileEntries);
    }

    return API().apiMethod(
      'customer/upgrade-to-seller',
      httpEnum: HttpEnum.post,
      data: profile.toJson(),
      dataMedia: formData,
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  Future<ResponseState<MessageModel>> getUser(int id) async {
    return API().apiMethod(
      'user/getUser?user_id=$id',
      httpEnum: HttpEnum.get,
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }
}
