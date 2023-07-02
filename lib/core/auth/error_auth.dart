import 'package:seller/common/errors/errors.dart';

class LocalAuthError extends Errors {
  LocalAuthError()
      : super(message: 'Not Found', detail: 'Can\'t find AuthToken on local');
}
