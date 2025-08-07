// lib/modules/stores/data/store_details_repository.dart

import 'package:souq_al_balad/global/endpoints/models/model.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/modules/stores/data/models/get_stores_model.dart';
import 'package:souq_al_balad/modules/stores/data/repository/get_stores_api.dart';

class StoreRepository {
  final StoreApi _storeApi = StoreApi();

  Future<ResponseState<StoreData>> fetchStoreDetails(int storeId) async {
    try {
      final apiResponse = await _storeApi.getStoreById(storeId);

      if (apiResponse is SuccessState<StoresResponse>) {
        // final storeList = apiResponse.data.result.stores;
        final storeList = apiResponse.data.result?.stores ?? [];
        if (storeList.isNotEmpty) {
          return ResponseState.success(storeList.first);
        } else {
          return ResponseState.error(
            Model(error: MessageModel(message: 'Store not found.')),
          );
        }
      } else if (apiResponse is ErrorState<StoresResponse>) {
        return ResponseState.error(apiResponse.errorMessage);
      } else {
        return ResponseState.error(
          Model(
              error: MessageModel(
                  message: 'An unexpected response state was received.')),
        );
      }
    } catch (e, stacktrace) {
      return Model.catchError<StoreData>(e, stacktrace);
    }
  }
}
