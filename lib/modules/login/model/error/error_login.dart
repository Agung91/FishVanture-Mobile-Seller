import 'package:seller/common/errors/errors.dart';

class LoginError extends Errors {
  LoginError()
      : super(
            message: 'Field can\'t be empty', detail: 'Field can\'t be empty');
}
