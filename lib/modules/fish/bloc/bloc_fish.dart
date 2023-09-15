import 'package:seller/core/auth/bloc/authenticated.dart';
import 'package:seller/modules/fish/model/input_create_fish.dart';
import 'package:seller/modules/fish/model/model_fish.dart';
import 'package:seller/modules/fish/repo/repo_fish.dart';
import 'package:sstream/sstream.dart';

class FishBloc extends Authenticated {
  FishBloc(this._repo);

  final FishHttpRepo _repo;

  final listFish = SStream<List<FishModel>>([]);

  final name = ''.stream;
  final from = ''.stream;

  Future<void> getFishes() async {
    try {
      final response = await _repo.getFishes();
      listFish.add(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createFish() async {
    final nameVal = name.value;
    if (nameVal == '') {
      throw 'Harap lengkapi field';
    }
    final fromVal = from.value;
    if (fromVal == '') {
      throw 'Harap lengkapi field';
    }
    try {
      await _repo.createFish(
        CreateFishInput(name: nameVal, asal: fromVal),
      );
      name.add('');
      from.add('');
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
