sealed class SignInEvent {

  const SignInEvent(this.email, this.password);

  final String email;
  final String password;
}

class EmailChanged extends SignInEvent {
  const EmailChanged(super.email, super.password);
}

class PasswordChanged extends SignInEvent {
  const PasswordChanged(super.email, super.password);
}

class SignInSubmitted extends SignInEvent {
  const SignInSubmitted(super.email, super.password);
}