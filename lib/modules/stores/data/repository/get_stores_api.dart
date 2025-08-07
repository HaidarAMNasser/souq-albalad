// lib/modules/stores/data/store_details_api.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq_al_balad/global/endpoints/core/api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/modules/stores/data/models/get_stores_model.dart';
import 'package:souq_al_balad/modules/stores/data/repository/get_stores_repo.dart';

class StoreApi {
  final API _api = API();

  Future<ResponseState<StoresResponse>> getStoreById(int storeId) async {
    const String apiUrl = 'stores';

    return _api.apiMethod<StoresResponse>(
      apiUrl,
      httpEnum: HttpEnum.get,
      queryParameters: {'id': storeId},
      parseJson: (json) => StoresResponse.fromJson(json),
    );
  }
} // lib/modules/stores/logic/store_details_state.dart
