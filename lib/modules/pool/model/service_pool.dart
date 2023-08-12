import 'package:seller/modules/pool/model/input_create_pool.dart';
import 'package:seller/modules/pool/model/model_pool.dart';

abstract class PoolService {
  Future<String?> createPool(CreatePoolInput input);
  Future<List<PoolModel>> getPools(String id);
}
