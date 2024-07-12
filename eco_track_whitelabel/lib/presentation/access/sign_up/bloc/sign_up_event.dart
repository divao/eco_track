abstract class SignUpEvent {}

class NameChanged extends SignUpEvent {
  NameChanged(this.name);

  final String name;
}

class EmailChanged extends SignUpEvent {
  EmailChanged(this.email);

  final String email;
}

class PasswordChanged extends SignUpEvent {
  PasswordChanged(this.password, this.passwordConfirmation);

  final String password;
  final String passwordConfirmation;
}

class PasswordConfirmationChanged extends SignUpEvent {
  PasswordConfirmationChanged(this.password, this.passwordConfirmation);

  final String password;
  final String passwordConfirmation;
}

class SignUpSubmitted extends SignUpEvent {
  SignUpSubmitted({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
}
