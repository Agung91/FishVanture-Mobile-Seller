import 'package:seller/common/errors/errors.dart';

class ProductError extends Errors {
  ProductError()
      : super(
          code: 'Field can\'t be empty',
          message: 'Field can\'t be empty',
        );
}
