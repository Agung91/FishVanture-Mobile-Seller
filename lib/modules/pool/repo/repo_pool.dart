import 'package:seller/common/http/http.dart';
import 'package:seller/config/hosts.dart';
import 'package:seller/modules/pool/model/input_create_pool.dart';
import 'package:seller/modules/pool/model/service_pool.dart';

class PoolHttpRepo extends HttpService implements PoolService {
  @override
  Future<String?> createPool(CreatePoolInput input) async {
    try {
      final response = post('$host/create-pool', body: input.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
