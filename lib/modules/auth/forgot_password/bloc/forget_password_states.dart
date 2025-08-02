import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';

class ForgetPasswordState {
  StateEnum forgetPassState;
  String errorMessage;
  ForgetPasswordState({
    this.forgetPassState = StateEnum.start,
    this.errorMessage = '',
  });

  ForgetPasswordState copyWith({
    StateEnum? forgetPassState,
    String? errorMessage,
  }) {
    return ForgetPasswordState(
      forgetPassState: forgetPassState ?? this.forgetPassState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
