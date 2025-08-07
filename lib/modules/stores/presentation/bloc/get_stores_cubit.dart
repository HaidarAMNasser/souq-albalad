
// lib/modules/stores/data/store_details_api.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq_al_balad/global/endpoints/core/api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/modules/stores/data/models/get_stores_model.dart';
import 'package:souq_al_balad/modules/stores/data/repository/get_stores_repo.dart';
part 'get_stores_state.dart';
class StoreDetailsCubit extends Cubit<StoreDetailsState> {
  final StoreRepository _storeRepository = StoreRepository();

  StoreDetailsCubit() : super(StoreDetailsInitial());

  Future<void> fetchStoreDetails(int storeId) async {
    emit(StoreDetailsLoading());

    final response = await _storeRepository.fetchStoreDetails(storeId);

    if (response is SuccessState<StoreData>) {
      emit(StoreDetailsSuccess(storeData: response.data));

    } else if (response is ErrorState<StoreData>) {
      emit(StoreDetailsFailure(errorMessage: response.errorMessage.getErrors));
    }
  }

}