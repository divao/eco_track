import 'package:eco_track_whitelabel/presentation/common/utils/status/button_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/input_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/sign_up_status.dart';

final class SignUpState {
  const SignUpState({
    required this.signUpStatus,
    required this.buttonStatus,
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.nameInputStatus,
    required this.emailInputStatus,
    required this.passwordInputStatus,
    required this.passwordConfirmationInputStatus,
  });

  final SignUpStatus signUpStatus;
  final ButtonStatus buttonStatus;
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final InputStatus nameInputStatus;
  final InputStatus emailInputStatus;
  final InputStatus passwordInputStatus;
  final InputStatus passwordConfirmationInputStatus;

  SignUpState copyWith({
    SignUpStatus? signUpStatus,
    ButtonStatus? buttonStatus,
    String? name,
    String? email,
    String? password,
    String? passwordConfirmation,
    InputStatus? nameInputStatus,
    InputStatus? emailInputStatus,
    InputStatus? passwordInputStatus,
    InputStatus? passwordConfirmationInputStatus,
  }) {
    return SignUpState(
      signUpStatus: signUpStatus ?? this.signUpStatus,
      buttonStatus: buttonStatus ?? this.buttonStatus,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      nameInputStatus: nameInputStatus ?? this.nameInputStatus,
      emailInputStatus: emailInputStatus ?? this.emailInputStatus,
      passwordInputStatus: passwordInputStatus ?? this.passwordInputStatus,
      passwordConfirmationInputStatus: passwordConfirmationInputStatus ??
          this.passwordConfirmationInputStatus,
    );
  }
}
