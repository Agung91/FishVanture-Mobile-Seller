import 'package:seller/modules/product/model/create_product_input.dart';
import 'package:seller/modules/product/model/error_product.dart';
import 'package:seller/modules/product/repo/repo_product.dart';
import 'package:sstream/sstream.dart';

class ProductBloc {
  ProductBloc(this._repo);

  final ProductHttpRepo _repo;

  final listPrice = SStream<List<PriceModel>>([]);
  final price = ''.stream;
  final weight = ''.stream;
  final date = SStream<DateTime?>(null);

  void makeEmpty() {
    listPrice.add([]);
    price.add('');
    weight.add('');
    date.add(null);
  }

  addPrice() async {
    final listPriceVal = listPrice.value;
    final priceVal = price.value;
    if (priceVal == '') {
      throw ProductError();
    }
    final weightVal = weight.value;
    if (weightVal == '') {
      throw ProductError();
    }

    listPriceVal.add(
      PriceModel(limit: int.parse(weightVal), price: int.parse(priceVal)),
    );
    listPrice.add(listPriceVal);
    price.add('');
    weight.add('');
  }

  void removePrice(int limit) {
    final listPriceVal = listPrice.value;
    listPriceVal.removeWhere((element) => element.limit == limit);
    listPrice.add(listPriceVal);
  }

  Future<void> createProduct(String budidayaID) async {
    final dateVal = date.value;
    if (dateVal == null) {
      throw ProductError();
    }
    final listPriceVal = listPrice.value;
    if (listPriceVal == null || listPriceVal.isEmpty) {
      throw ProductError();
    }
    try {
      await _repo.createProduct(
        CreateProductInput(
            budidayaID: budidayaID,
            estTonase: listPriceVal.first.price,
            estDate: dateVal,
            input: listPrice.value),
      );
      makeEmpty();
    } catch (e) {
      rethrow;
    }
  }
}
