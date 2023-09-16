import 'package:seller/common/http/http.dart';
import 'package:seller/config/hosts.dart';
import 'package:seller/modules/product/model/create_product_input.dart';
import 'package:seller/modules/product/model/service_product.dart';
import 'package:seller/modules/product/model/update_product_input.dart';

class ProductHttpRepo extends HttpService implements ProductService {
  @override
  Future<String?> createProduct(CreateProductInput input) async {
    try {
      final response = await post(
        '$host/create-multiple-pricelist',
        body: input.toMap(),
      );
      return response.id;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> updateProduct(UpdateProductInput input) async {
    try {
      final response = await post(
        '$host/update-budidaya-with-pricelist',
        body: input.toMap(),
      );
      return response.id;
    } catch (e) {
      rethrow;
    }
  }
}
