import 'package:seller/core/auth/bloc/authenticated.dart';
import 'package:seller/modules/fish/model/model_fish.dart';
import 'package:seller/modules/fish/repo/repo_fish.dart';
import 'package:sstream/sstream.dart';

class FishBloc extends Authenticated {
  FishBloc(this._repo);

  final FishHttpRepo _repo;

  final listFish = SStream<List<FishModel>>([]);

  Future<void> getFishes() async {
    try {
      final response = await _repo.getFishes();
      listFish.add(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> onLogin() async {
    getFishes();
  }

  @override
  Future<void> onLogout() async {
    listFish.add([]);
  }
}
