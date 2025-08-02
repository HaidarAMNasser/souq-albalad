import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';

class ResetPasswordState {
  StateEnum resetPasswordState;
  String errorMessage;
  ResetPasswordState({
    this.resetPasswordState = StateEnum.start,
    this.errorMessage = '',
  });

  ResetPasswordState copyWith({
    StateEnum? resetPasswordState,
    String? errorMessage,
  }) {
    return ResetPasswordState(
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
