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

  Future<ResponseState<MessageModel>> editSellerProfile(SignUpMerchantModel profile) async {

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
      'seller/editProfile',
      httpEnum: HttpEnum.post,
      data: profile.toJson(),
      dataMedia: formData,
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  Future<ResponseState<MessageModel>> getSellerProducts() async {
    return API().apiMethod(
      'products/me',
      httpEnum: HttpEnum.get,
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  Future<ResponseState<MessageModel>> deleteProduct(int productId) async {
    return API().apiMethod(
      'admin/products/delete?product_id=$productId}',
      httpEnum: HttpEnum.delete,
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }
}
