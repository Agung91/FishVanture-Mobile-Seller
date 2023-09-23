import 'package:seller/common/http/http.dart';
import 'package:seller/config/hosts.dart';
import 'package:seller/modules/order/model/input_order_complete.dart';
import 'package:seller/modules/order/model/model_order.dart';
import 'package:seller/modules/order/model/service_order.dart';

class OrderHttpRepo extends HttpService implements OrderService {
  @override
  Future<PaginatedOrder> order() async {
    try {
      final response = await get(
        '$host/order',
      );
      if (response is Map<String, dynamic>) {
        return PaginatedOrder.fromMap(response);
      }
      throw 'Can\'t parse Order model';
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> orderComplete(CompleteOrderInput input) async {
    try {
      final response = await post(
        '$host/update-order-success',
        body: input.toMap(),
      );
      return response.id;
    } catch (e) {
      rethrow;
    }
  }
}
