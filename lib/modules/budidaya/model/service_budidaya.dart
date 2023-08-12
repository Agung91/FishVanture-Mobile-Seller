import 'package:seller/modules/budidaya/model/input_create_budidaya.dart';
import 'package:seller/modules/budidaya/model/model_budidaya.dart';

abstract class BudidayaService {
  Future<String?> createBudidaya(CreateBudidayaInput input);
  Future<List<BudidayaModel>> getBudidaya();
}
