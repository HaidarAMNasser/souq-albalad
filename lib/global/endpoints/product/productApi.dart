// ignore: file_names
import 'package:souq_al_balad/global/endpoints/core/api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';

class ProductApi {
  Future<ResponseState<MessageModel>> getFeaturedProducts() async {
    return API().apiMethod(
      'products',
      httpEnum: HttpEnum.get,
      data: {'is_featured': '1'},
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  Future<ResponseState<MessageModel>> getNewestProducts() async {
    return API().apiMethod(
      'products',
      httpEnum: HttpEnum.get,
      data: {'newest': '1'},
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  getProductById(int productId) {}
}
