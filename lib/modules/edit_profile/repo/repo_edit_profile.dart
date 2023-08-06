import 'package:seller/common/http/http.dart';
import 'package:seller/config/hosts.dart';
import 'package:seller/modules/edit_profile/model/model_profile.dart';
import 'package:seller/modules/edit_profile/model/service_edit_profile.dart';

class ProfileHttpRepo extends HttpService implements EditProfileService {
  @override
  Future<ProfileModel> getProfile() async {
    try {
      final reseponse = await get('$host/profile');
      return ProfileModel.fromMap(reseponse);
    } catch (e) {
      rethrow;
    }
  }
}
