import 'package:seller/modules/pool/model/model_pool.dart';
import 'package:seller/modules/pool/repo/repo_pool.dart';
import 'package:sstream/sstream.dart';

class PoolBloc {
  PoolBloc(this._repo);

  final PoolHttpRepo _repo;

  final listPool = SStream<List<PoolModel>>([]);

  Future<void> getPools(String id) async {
    try {
      final response = await _repo.getPools(id);
      listPool.add(response);
    } catch (e) {
      rethrow;
    }
  }
}
