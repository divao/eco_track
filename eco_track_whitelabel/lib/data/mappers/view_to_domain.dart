import 'package:domain/model/user_profile.dart';
import 'package:eco_track_whitelabel/data/view/model/profile_vm.dart';

extension ProfileVMMappers on ProfileVM {
  UserProfile toDM() => UserProfile(
    name: name,
    email: email,
    imageUrl: imageUrl,
  );
}