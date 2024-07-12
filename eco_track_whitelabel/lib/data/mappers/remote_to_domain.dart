import 'package:domain/model/user_profile.dart';
import 'package:eco_track_whitelabel/data/remote/model/user_profile_rm.dart';

extension UserProfileRMMappers on UserProfileRM {
  UserProfile toDM() => UserProfile(
    name: name,
  );
}