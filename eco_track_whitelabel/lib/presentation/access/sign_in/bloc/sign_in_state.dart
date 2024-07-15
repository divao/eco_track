import 'package:eco_track_whitelabel/presentation/common/utils/status/button_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/input_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/sign_in_status.dart';

final class SignInState {
  const SignInState({
    required this.signInStatus,
    required this.buttonStatus,
    required this.email,
    required this.password,
    required this.emailInputStatus,
    required this.passwordInputStatus,
  });

  final SignInStatus signInStatus;
  final ButtonStatus buttonStatus;
  final String email;
  final String password;
  final InputStatus emailInputStatus;
  final InputStatus passwordInputStatus;

  SignInState copyWith({
    SignInStatus? signInStatus,
    ButtonStatus? buttonStatus,
    String? email,
    String? password,
    InputStatus? emailInputStatus,
    InputStatus? passwordInputStatus,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      buttonStatus: buttonStatus ?? this.buttonStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      emailInputStatus: emailInputStatus ?? this.emailInputStatus,
      passwordInputStatus: passwordInputStatus ?? this.passwordInputStatus,
    );
  }
}