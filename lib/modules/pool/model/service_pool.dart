import 'package:seller/modules/pool/model/model_pool.dart';

abstract class PoolService {
  Future<List<PoolModel>> getPools(String id);
}
