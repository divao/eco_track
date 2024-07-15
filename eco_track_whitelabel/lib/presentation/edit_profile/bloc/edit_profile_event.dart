import 'dart:io';

abstract class EditProfileEvent {}

class SetProfileFields extends EditProfileEvent {}

class NameChanged extends EditProfileEvent {
  NameChanged(this.name);

  final String name;
}

class EditProfileSubmitted extends EditProfileEvent {
  EditProfileSubmitted({
    required this.name,
    this.profileImage,
  });

  final String name;
  final File? profileImage;
}
