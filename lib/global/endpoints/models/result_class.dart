import 'model.dart';

abstract class ResponseState<T> {
  factory ResponseState.success(T data) = SuccessState<T>;

  factory ResponseState.error(Model e) = ErrorState<T>;

  factory ResponseState.loading() = LoadingState<T>;
}

class SuccessState<T> implements ResponseState<T> {
  final T data;

  const SuccessState(this.data);
}

class ErrorState<T> implements ResponseState<T> {
  final Model errorMessage;

  ErrorState(this.errorMessage);
}

class LoadingState<T> implements ResponseState<T> {
  const LoadingState();
}
