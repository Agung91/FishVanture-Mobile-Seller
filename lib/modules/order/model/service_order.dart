import 'package:seller/modules/order/model/input_order_complete.dart';
import 'package:seller/modules/order/model/model_order.dart';

abstract class OrderService {
  Future<PaginatedOrder> order();
  Future<String?> orderComplete(CompleteOrderInput input);
}
