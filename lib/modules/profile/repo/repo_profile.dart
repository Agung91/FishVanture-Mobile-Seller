import 'package:seller/common/http/http.dart';
import 'package:seller/config/hosts.dart';
import 'package:seller/modules/profile/model/model_profile.dart';
import 'package:seller/modules/profile/model/service_profile.dart';

class ProfileHttpRepo extends HttpService implements ProfileService {
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
