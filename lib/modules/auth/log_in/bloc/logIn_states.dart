import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';

class LoginState {
  StateEnum loginState;
  StateEnum loginGuestState;
  String errorMessage;
  LoginState({
    this.loginState = StateEnum.start,
    this.loginGuestState = StateEnum.start,
    this.errorMessage = '',
  });

  LoginState copyWith({
    StateEnum? loginState,
    StateEnum? loginGuestState,
    String? errorMessage,
  }) {
    return LoginState(
      loginState: loginState ?? this.loginState,
      loginGuestState: loginGuestState ?? this.loginGuestState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
