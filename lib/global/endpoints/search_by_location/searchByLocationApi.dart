import 'package:souq_al_balad/global/endpoints/core/api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';

class SearchByLocationApi {
  Future<ResponseState<MessageModel>> searchByLocation(
    int distance,
    double latitude,
    double longitude,
  ) async {
    return API().apiMethod(
      'search/byLocation',
      httpEnum: HttpEnum.post,
      data: {"distance": distance, "lat": latitude, "long": longitude},
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }
}
