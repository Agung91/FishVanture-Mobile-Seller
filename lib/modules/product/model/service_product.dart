import 'package:seller/modules/product/model/create_product_input.dart';
import 'package:seller/modules/product/model/update_product_input.dart';

abstract class ProductService {
  Future<String?> createProduct(CreateProductInput input);
  Future<String?> updateProduct(UpdateProductInput input);
}
