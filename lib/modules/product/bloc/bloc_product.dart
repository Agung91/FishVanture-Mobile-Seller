import 'package:seller/modules/budidaya/model/model_price_list.dart';
import 'package:seller/modules/product/model/create_product_input.dart';
import 'package:seller/modules/product/model/error_product.dart';
import 'package:seller/modules/product/model/update_product_input.dart';
import 'package:seller/modules/product/repo/repo_product.dart';
import 'package:sstream/sstream.dart';

class ProductBloc {
  ProductBloc(this._repo);

  final ProductHttpRepo _repo;

  // final listPrice = SStream<List<PriceModel>?>(null);
  final listPrice = SStream<List<PriceListModel>?>(null);

  final date = SStream<DateTime?>(null);
  final estTonase = ''.stream;
  final weight = ''.stream;
  final price = ''.stream;

  void makeEmpty() {
    listPrice.add([]);
    price.add('');
    weight.add('');
    estTonase.add('');
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

    // listPriceVal?.add(
    //   PriceModel(
    //     limit: int.parse(weightVal),
    //     price: int.parse(priceVal),
    //   ),
    // );
    listPriceVal?.add(
      PriceListModel(
        limit: int.parse(weightVal),
        price: int.parse(priceVal),
      ),
    );
    listPrice.add(listPriceVal);
    price.add('');
    weight.add('');
  }

  addPriceDefault() async {
    final listPriceVal = listPrice.value;
    final priceVal = price.value;
    if (priceVal == '') {
      throw ProductError();
    }

    // listPriceVal?.add(
    //   PriceModel(
    //     limit: 1,
    //     price: int.parse(priceVal),
    //   ),
    // );
    listPriceVal?.add(
      PriceListModel(
        limit: 1,
        price: int.parse(priceVal),
      ),
    );
    listPrice.add(listPriceVal);
    price.add('');
    weight.add('');
  }

  void removePrice(int limit) {
    final listPriceVal = listPrice.value;
    listPriceVal?.removeWhere((element) => element.limit == limit);
    listPrice.add(listPriceVal);
  }

  void currentPrice(PriceListModel data) {
    price.add(data.price.toString());
    weight.add(data.limit.toString());
  }

  void updatePrice(PriceListModel data) {
    final listPriceVal = listPrice.value;
    final priceVal = price.value;
    if (priceVal == '') throw ProductError();

    final weightVal = weight.value;
    if (weightVal == '') throw ProductError();

    if (listPriceVal == null) throw ProductError();

    for (var element in listPriceVal) {
      if (element.id == data.id) {
        element.price = int.parse(priceVal);
        element.limit = int.parse(weightVal);
        listPrice.add(listPriceVal);
        price.add('');
        weight.add('');
        return;
      }
    }
  }

  void updatePriceDefault(PriceListModel data) {
    final listPriceVal = listPrice.value;
    final priceVal = price.value;
    if (priceVal == '') throw ProductError();

    if (listPriceVal == null) throw ProductError();

    for (var element in listPriceVal) {
      if (element.id == data.id) {
        element.price = int.parse(priceVal);
        element.limit = 1;
        listPrice.add(listPriceVal);
        price.add('');

        return;
      }
    }
  }

  Future<void> createProduct(String budidayaID) async {
    final estTonaseVal = estTonase.value;
    if (estTonaseVal == null || estTonaseVal == '') {
      throw ProductError();
    }
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
            estTonase: int.parse(estTonaseVal),
            estDate: dateVal,
            input: listPriceVal
                .map((e) => PriceModel(limit: e.limit, price: e.price))
                .toList()),
      );
      makeEmpty();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(String budidayaID) async {
    final estTonaseVal = estTonase.value;
    if (estTonaseVal == null || estTonaseVal == '') {
      throw ProductError();
    }
    final dateVal = date.value;
    if (dateVal == null) {
      throw ProductError();
    }
    final listPriceVal = listPrice.value;
    if (listPriceVal == null || listPriceVal.isEmpty) {
      throw ProductError();
    }
    try {
      await _repo.updateProduct(UpdateProductInput(
          budidayaID: budidayaID,
          estTonase: int.parse(estTonaseVal),
          estDate: dateVal,
          pricelist: listPriceVal));
      makeEmpty();
    } catch (e) {
      rethrow;
    }
  }
}
