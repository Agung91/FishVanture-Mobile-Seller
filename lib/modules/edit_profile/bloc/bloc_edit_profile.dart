import 'package:seller/core/auth/bloc/authenticated.dart';
import 'package:seller/modules/edit_profile/model/model_profile.dart';
import 'package:seller/modules/edit_profile/repo/repo_edit_profile.dart';
import 'package:sstream/sstream.dart';

class EditProfileBloc extends Authenticated {
  EditProfileBloc(this._repo) {
    getProfile();
  }

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
