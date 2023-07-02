import 'package:seller/core/auth/bloc/authenticated.dart';
import 'package:seller/modules/profile/model/model_profile.dart';
import 'package:seller/modules/profile/repo/repo_profile.dart';
import 'package:sstream/sstream.dart';

class ProfileBloc extends Authenticated {
  ProfileBloc(this._repo);

  final ProfileHttpRepo _repo;

  final profile = SStream<ProfileModel?>(null);

  Future<void> getProfile() async {
    try {
      final response = await _repo.getProfile();
      profile.add(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> onLogin() async {
    getProfile();
  }

  @override
  Future<void> onLogout() async {
    profile.add(null);
  }
}
