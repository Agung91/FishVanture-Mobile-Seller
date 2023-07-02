import 'model_profile.dart';

abstract class ProfileService {
  Future<ProfileModel> getProfile();
}
