import 'package:seller/modules/pond/model/pond_id.dart';
import 'package:seller/modules/pool/model/model_pool.dart';
import 'package:seller/modules/pool/repo/repo_pool.dart';
import 'package:sstream/sstream.dart';

class PoolBloc {
  PoolBloc(this._repo) {
    getPools();
  }

  final PoolHttpRepo _repo;

  final listPool = SStream<List<PoolModel>>([]);

  Future<void> getPools() async {
    try {
      final response = await _repo.getPools(PondID().id ?? '');
      listPool.add(response);
    } catch (e) {
      rethrow;
    }
  }
}
