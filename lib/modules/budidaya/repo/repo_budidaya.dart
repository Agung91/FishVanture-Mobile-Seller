import 'package:seller/common/http/http.dart';
import 'package:seller/config/hosts.dart';
import 'package:seller/modules/budidaya/model/input_create_budidaya.dart';
import 'package:seller/modules/budidaya/model/model_budidaya.dart';
import 'package:seller/modules/budidaya/model/service_budidaya.dart';

class BudidayaHttpRepo extends HttpService implements BudidayaService {
  @override
  Future<String?> createBudidaya(CreateBudidayaInput input) async {
    try {
      final response = await post(
        '$host/create-budidaya',
        body: input.toMap(),
      );
      return response.id;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<BudidayaModel>> getBudidaya() async {
    try {
      final response = await get('$host/list-budidaya-seller');
      if (response is List) {
        return List<Map<String, dynamic>>.from(response)
            .map((e) => BudidayaModel.fromMap(e))
            .toList();
      }
      throw 'Can\'t parse budidaya model';
    } catch (e) {
      rethrow;
    }
  }
}
