import 'package:seller/core/auth/bloc/authenticated.dart';
import 'package:seller/modules/budidaya/model/input_create_budidaya.dart';
import 'package:seller/modules/budidaya/model/model_budidaya.dart';
import 'package:seller/modules/budidaya/repo/repo_budidaya.dart';
import 'package:seller/modules/fish/model/model_fish.dart';
import 'package:seller/modules/pool/model/model_pool.dart';
import 'package:sstream/sstream.dart';

class BudidayaBloc extends Authenticated {
  BudidayaBloc(this._repo);

  final BudidayaHttpRepo _repo;

  final listBudidaya = SStream<List<BudidayaModel>>([]);

  final date = SStream<DateTime?>(null);
  final pool = SStream<PoolModel?>(null);
  final fish = SStream<FishModel?>(null);

  void makeEmpty() {
    date.add(null);
    pool.add(null);
    fish.add(null);
  }

  Future<void> getListBudidaya() async {
    try {
      final response = await _repo.getBudidaya();
      listBudidaya.add(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createBudidaya() async {
    final dateVal = date.value;
    if (dateVal == null || dateVal == '') {
      throw 'Field tidak boleh kosong';
    }
    final poolVal = pool.value;
    if (poolVal == null || poolVal == '') {
      throw 'Field tidak boleh kosong';
    }
    final fishVal = fish.value;
    if (fishVal == null || fishVal == '') {
      throw 'Field tidak boleh kosong';
    }
    try {
      await _repo.createBudidaya(CreateBudidayaInput(
        poolID: poolVal.id ?? '',
        dateOfSeed: dateVal,
        fishSpeciesID: fishVal.id,
      ));
      makeEmpty();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> onLogin() async {
    getListBudidaya();
  }

  @override
  Future<void> onLogout() async {
    listBudidaya.add([]);
  }
}
