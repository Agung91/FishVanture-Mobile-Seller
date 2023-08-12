import 'package:seller/modules/budidaya/model/input_create_budidaya.dart';
import 'package:seller/modules/budidaya/model/model_budidaya.dart';
import 'package:seller/modules/budidaya/repo/repo_budidaya.dart';
import 'package:sstream/sstream.dart';

class BudidayaBloc {
  BudidayaBloc(this._repo);

  final BudidayaHttpRepo _repo;

  final listBudidaya = SStream<List<BudidayaModel>>([]);

  final date = SStream<DateTime?>(null);
  final pool = ''.stream;
  final fish = ''.stream;

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
        poolID: poolVal,
        dateOfSeed: dateVal,
        fishSpeciesID: fishVal,
      ));
    } catch (e) {
      rethrow;
    }
  }
}
