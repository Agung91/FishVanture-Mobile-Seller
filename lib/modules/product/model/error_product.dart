import 'package:seller/common/errors/errors.dart';

class ProductError extends Errors {
  ProductError()
      : super(
          code: 'FiledCantBeEmpty',
          message: 'Harap lengkapi semua field',
        );
}
