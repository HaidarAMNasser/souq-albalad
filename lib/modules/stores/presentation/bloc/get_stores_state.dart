
part of 'get_stores_cubit.dart';

abstract class StoreDetailsState extends Equatable {
  const StoreDetailsState();

  @override
  List<Object> get props => [];
}

class StoreDetailsInitial extends StoreDetailsState {}

class StoreDetailsLoading extends StoreDetailsState {}

class StoreDetailsSuccess extends StoreDetailsState {
  final StoreData storeData;

  const StoreDetailsSuccess({required this.storeData});

  @override
  List<Object> get props => [storeData];
}

class StoreDetailsFailure extends StoreDetailsState {
  final String errorMessage;

  const StoreDetailsFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}