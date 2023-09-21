import 'package:seller/common/http/http.dart';
import 'package:seller/config/hosts.dart';
import 'package:seller/modules/order/model/service_order.dart';

class OrderHttpRepo extends HttpService implements OrderService {
  @override
  Future<String?> order() async {
    try {
      final response = await get(
        '$host/order',
      );
      if (response is Map<String, dynamic>) {}
      throw 'Can\'t parse Order model';
    } catch (e) {
      rethrow;
    }
  }
}
