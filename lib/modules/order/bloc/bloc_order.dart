import 'package:seller/modules/order/repo/repo_order.dart';
import 'package:sstream/sstream.dart';

class OrderBloc {
  OrderBloc(this._repo) {
    order();
  }
  final OrderHttpRepo _repo;

  // final orderActive = SStream<List<OrderModel>>([]);
  // final orderComplete = SStream<List<OrderModel>>([]);

  // void _splitData(List<OrderModel> listOrder) {
  //   // final ordersValue = orders.value;
  //   final activeOrder =
  //       listOrder.where((element) => element.status == 'active').toList();
  //   final completeOrder =
  //       listOrder.where((element) => element.status != 'active').toList();

  //   orderActive.add(activeOrder);
  //   orderComplete.add(completeOrder);
  // }
  Future<void> order() async {
    try {
      final response = await _repo.order();
      // orders.add(response.rows);
      // _splitData(response.rows);
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> cancelOrder(String budidayaID) async {
  //   try {
  //     await _repo.cancelOrder(OrderCancelInput(
  //       id: budidayaID,
  //     ));
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
