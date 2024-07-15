abstract class ProfileEvent {}

class GetProfile extends ProfileEvent {}

class SignOut extends ProfileEvent {}

class DeleteUser extends ProfileEvent {
  DeleteUser({
    required this.password,
  });

  final String password;
}

class TryAgain extends ProfileEvent {}